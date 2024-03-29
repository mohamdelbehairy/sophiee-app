import 'package:app/models/users_model.dart';

final class GetFriendsState {}

final class GetFriendsInitial extends GetFriendsState {}

final class GetFriendsLoading extends GetFriendsState {}

final class GetFriendsSuccess extends GetFriendsState {
  final List<UserModel> friends;

  GetFriendsSuccess({required this.friends});
}

final class GetFriendsFailure extends GetFriendsState {
  final String errorMessage;

  GetFriendsFailure({required this.errorMessage});
}
