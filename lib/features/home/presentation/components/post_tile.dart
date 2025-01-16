import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PostTile extends StatelessWidget {
  final Post post;

  const PostTile({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: post.imageUrl,
      height: 430,
      width: double.infinity,
      fit: BoxFit.cover,
      placeholder: (context, url) => const SizedBox(height: 430),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
