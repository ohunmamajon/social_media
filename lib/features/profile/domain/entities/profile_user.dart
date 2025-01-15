import 'package:social_media/features/auth/domain/entities/app_user.dart';

class ProfileUser extends AppUser {
  final String bio;
  final String profileImageUrl;

  ProfileUser(
      {required super.email,
      required super.uid,
      required super.name,
      required this.bio,
      required this.profileImageUrl});

  // method to update profile user
  ProfileUser copyWith({String? newBio, String? newProfileImageUrl}) {
    return ProfileUser(
        email: email,
        uid: uid,
        name: name,
        bio: newBio ?? bio,
        profileImageUrl: newProfileImageUrl ?? profileImageUrl);
  }

  // convert profile user -> Json
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'bio': bio,
      'profileImageUrl': profileImageUrl
    };
  }

  // convert Json -> ProfileUser
  factory ProfileUser.fromJson(Map<String, dynamic> json) {
    return ProfileUser(
        email: json['email'],
        uid: json['uid'],
        name: json['name'],
        bio: json['bio'] ?? '',
        profileImageUrl: json['profileImageUrl'] ?? '');
  }
}
