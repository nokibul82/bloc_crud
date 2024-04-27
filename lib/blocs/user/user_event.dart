part of "user_bloc.dart";



@immutable
abstract class UserEvent{}

class AddUser extends UserEvent{
  final User user;

  AddUser({required this.user});
}

class DeleteUser extends UserEvent{
  final User user;

  DeleteUser({required this.user});
}

class UpdateUser extends UserEvent{
  final User user;

  UpdateUser({required this.user});
}

