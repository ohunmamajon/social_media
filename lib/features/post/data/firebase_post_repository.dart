import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media/features/post/domain/entities/post.dart';
import 'package:social_media/features/post/domain/repos/post_repo.dart';

class FirebasePostRepository implements PostRepo {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // store the posts in a collection called 'post'
  final CollectionReference postsCollection =
      FirebaseFirestore.instance.collection('posts');

  @override
  Future<void> createPost(Post post) async {
    try {
      await postsCollection.doc(post.id).set(post.toJson());
    } catch (e) {
      throw Exception("Error creating post: $e");
    }
  }

  @override
  Future<void> deletePost(String postId) async {
    await postsCollection.doc(postId).delete();
  }

  @override
  Future<List<Post>> fetchAllPosts() async {
    try {
      // get all posts with most recennt posts at the top
      final postSnapshot =
          await postsCollection.orderBy('timestamp', descending: true).get();

      // convert each firestore doc from json -> list of posts
      final List<Post> allPosts = postSnapshot.docs
          .map((doc) => Post.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      return allPosts;
    } catch (e) {
      throw Exception("Error fetching post: $e");
    }
  }

  @override
  Future<List<Post>> fetchPostsByUserId(String userId) async {
    try {
      final postsSnapshot =
          await postsCollection.where('userId', isEqualTo: userId).get();

      final userPosts = postsSnapshot.docs
          .map((doc) => Post.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      return userPosts;
    } catch (e) {
      throw Exception("Error fetching posts by user: $e");
    }
  }

  @override
  Future<void> toggleLikePost(String postId, String userId) async {
    try {
      // get the post document from firestore
      final postDoc = await postsCollection.doc(postId).get();
      if (postDoc.exists) {
        final post = Post.fromJson(postDoc.data() as Map<String, dynamic>);

        // chcek if user has already liked this post
        final hasLiked = post.likes.contains(userId);

        //update the likes list
        if (hasLiked) {
          post.likes.remove(userId);
        } else {
          post.likes.add(userId);
        }

        await postsCollection.doc(postId).update({'likes': post.likes});
      } else {
        throw Exception("Post not found");
      }
    } catch (e) {
      throw Exception("Error toggling like: $e");
    }
  }
}
