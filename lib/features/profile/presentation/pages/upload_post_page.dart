import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/features/auth/domain/entities/app_user.dart';
import 'package:social_media/features/auth/presentation/components/my_text_field.dart';
import 'package:social_media/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:social_media/features/post/domain/entities/post.dart';
import 'package:social_media/features/post/presentation/cubits/post_cubit.dart';
import 'package:social_media/features/post/presentation/cubits/post_states.dart';

class UploadPostPage extends StatefulWidget {
  const UploadPostPage({super.key});

  @override
  State<UploadPostPage> createState() => _UploadPostPageState();
}

class _UploadPostPageState extends State<UploadPostPage> {
  // mobile image pick
  PlatformFile? imagePickedFile;

  // web image pick
  Uint8List? webImage;

  // current user
  AppUser? currentUser;

  // text controller for caption
  final textControler = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    final authCubit = context.read<AuthCubit>();
    currentUser = authCubit.currentUser;
  }

  // pick image
  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: kIsWeb,
    );
    if (result != null) {
      setState(() {
        imagePickedFile = result.files.first;
        if (kIsWeb) {
          webImage = imagePickedFile!.bytes;
        }
      });
    }
  }

  // create & upload post
  void uploadPost() {
    // check if both image and caption are provided
    if (imagePickedFile == null || textControler.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Both caption and image are required")));
      return;
    }

    // create new post object.
    final newPost = Post(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        userId: currentUser!.uid,
        userName: currentUser!.name,
        text: textControler.text,
        imageUrl: '',
        timeStamp: DateTime.now(),
        likes: []
        );

// post cubit
    final postCubit = context.read<PostCubit>();

    // web upload
    if (kIsWeb) {
      postCubit.createPost(newPost, imageBytes: imagePickedFile?.bytes);
    }

    // mobile upload
    else {
      postCubit.createPost(newPost, imagePath: imagePickedFile?.path);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCubit, PostState>(
      builder: (context, state) {
        if (state is PostLoading || state is PostUploading){
          return const Scaffold(
            body: Center(child: CircularProgressIndicator(),),
          );
        }
         return buildUploadPage();
      },

      // go to previous page when upload is done & posts are loaded  
      listener: (context, state){
        if ( state is PostLoaded) {
          Navigator.pop(context);
        }
      });
  }

  Widget buildUploadPage() {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Create post"),
        foregroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          // upload button 
          IconButton(
            onPressed: uploadPost, 
            icon: const Icon(Icons.upload))
        ],
      ),
      body: Center(child: Column(children: [
        //image preview for mobile
  if ( !kIsWeb && imagePickedFile != null)
    Image.file(File(imagePickedFile!.path!)),

        // image preview for web
        if (kIsWeb && webImage != null) 
          Image.memory(webImage!),

          // pick image button 
          MaterialButton(
            onPressed:    pickImage,
            color: Colors.blue,
            child: const Text("Pick Image"),
            ),
          
          // caption text box
          MyTextField(controller: textControler, hintText: "Caption", obscureText: false)
      ],),),
    );
  }
}
