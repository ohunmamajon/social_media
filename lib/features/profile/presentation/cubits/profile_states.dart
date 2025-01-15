import 'package:social_media/features/profile/domain/entities/profile_user.dart';

abstract class ProfileState {}

// initial state
class ProfileInitial extends ProfileState {}

// loading
class ProfileLoading extends ProfileState {}

// loaded
class ProfileLoaded extends ProfileState {
  final ProfileUser profileUser;
  ProfileLoaded(this.profileUser);
}

// error
class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}