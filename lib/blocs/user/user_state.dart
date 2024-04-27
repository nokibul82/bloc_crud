part of "user_bloc.dart";




abstract class UserState{
  List<User> users;
  UserState({required this.users});
}

class UserInitial extends UserState{
  UserInitial({required List<User> users}) :super(users: users);
}

class UserUpdated extends UserState{
  UserUpdated({required List<User> users}) :super(users: users);
}