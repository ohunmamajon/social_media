

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/features/profile/domain/repos/profile_repo.dart';
import 'package:social_media/features/profile/presentation/cubits/profile_states.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;

  ProfileCubit({required this.profileRepo}) : super(ProfileInitial());

  // fetch user profile using repo
  Future<void> fetchUserProfile( uid) async {
    try {
      emit(ProfileLoading());
      final user = await profileRepo.fetchUserProfile(uid);
      if (user != null) {
        emit(ProfileLoaded(user));
      } else {
        emit(ProfileError("User Not Found"));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  // update bio and/or profile picture
  Future<void> updateProfile({ required String uid, String? newBio}) async {
    emit(ProfileLoading());
    try {
      // fetch current profile
      final currentUser = await profileRepo.fetchUserProfile(uid);

      if (currentUser == null) {
        emit(ProfileError("Failed to catch user for profile update"));
        return;
      }

      // profile picture update

      // update new profile
      final updatedProfile = currentUser.copyWith(newBio: newBio ?? currentUser.bio);

//update in repo
      await profileRepo.updateProfile(updatedProfile);

// re-fetch the updated profile
      await fetchUserProfile(uid);
    } catch (e) {
      emit(ProfileError("Error updating profile: $e"));
    }
  }
}
