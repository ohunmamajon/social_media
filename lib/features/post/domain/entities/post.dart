import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String userId;
  final String userName;
  final String text;
  final String imageUrl;
  final DateTime timeStamp;

  Post(
      {required this.id,
      required this.userId,
      required this.userName,
      required this.text,
      required this.imageUrl,
      required this.timeStamp});

  Post copyWith({String? imageUrl}) {
    return Post(
        id: id,
        userId: userId,
        userName: userName,
        text: text,
        imageUrl: imageUrl ?? this.imageUrl,
        timeStamp: timeStamp);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': userName,
      'text': text,
      'imageUrl': imageUrl,
      'timestamp': Timestamp.fromDate(timeStamp)
    };
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'],
        userId: json['userId'],
        userName: json['name'],
        text: json['text'],
        imageUrl: json['imageUrl'],
        timeStamp: (json['timestamp'] as Timestamp).toDate() );
  }
}