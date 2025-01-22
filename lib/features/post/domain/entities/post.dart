import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media/features/post/domain/entities/comment.dart';

class Post {
  final String id;
  final String userId;
  final String userName;
  final String text;
  final String imageUrl;
  final DateTime timeStamp;
  final List<String> likes;
  final List<Comment> comments; // store uids

  Post(
      {required this.id,
      required this.userId,
      required this.userName,
      required this.text,
      required this.imageUrl,
      required this.timeStamp,
      required this.likes,
      required this.comments});

  Post copyWith({String? imageUrl}) {
    return Post(
        id: id,
        userId: userId,
        userName: userName,
        text: text,
        imageUrl: imageUrl ?? this.imageUrl,
        timeStamp: timeStamp,
        likes: likes,
        comments: comments);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': userName,
      'text': text,
      'imageUrl': imageUrl,
      'timestamp': Timestamp.fromDate(timeStamp),
      'likes': likes,
      'comments': comments.map((comment) => comment.toJson()).toList()
    };
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    final List<Comment> comments = (json['comments'] as List<dynamic>?)
            ?.map((commentsJson) => Comment.fromJson(commentsJson))
            .toList() ??
        [];

    return Post(
        id: json['id'],
        userId: json['userId'],
        userName: json['name'],
        text: json['text'],
        imageUrl: json['imageUrl'],
        timeStamp: (json['timestamp'] as Timestamp).toDate(),
        likes: List<String>.from(json['likes'] ?? []),
        comments: comments
        );
  }
}
