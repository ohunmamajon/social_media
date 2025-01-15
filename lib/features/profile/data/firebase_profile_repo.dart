import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media/features/profile/domain/entities/profile_user.dart';
import 'package:social_media/features/profile/domain/repos/profile_repo.dart';

class FirebaseProfileRepo implements ProfileRepo {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<ProfileUser?> fetchUserProfile(String uid) async {
    try {
      final userDoc =
          await firebaseFirestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        final userData = userDoc.data();
        if (userData != null) {
          return ProfileUser(
              email: userData['email'],
              uid: uid,
              name: userData['name'],
              bio: userData['bio'] ?? '',
              profileImageUrl: userData['profileImageUrl'].toString());
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> updateProfile(ProfileUser updateProfile) async {
    // TODO: implement updateProfile
    try {
      // convert updated profile to json to store in firestore
      await firebaseFirestore
          .collection('users')
          .doc(updateProfile.uid)
          .update({
        'bio': updateProfile.bio,
        'profileImageUrl': updateProfile.profileImageUrl,
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}