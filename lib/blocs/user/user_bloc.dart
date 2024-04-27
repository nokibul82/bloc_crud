import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../models/user_model.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent,UserState> {
  UserBloc() : super(UserInitial(users: [])){
   on<AddUser>(_addUser);
   on<DeleteUser>(_deleteUser);
   on<UpdateUser>(_updateUser);
  }

  void _addUser(AddUser event,Emitter<UserState> emit){
    state.users.add(event.user);
    emit(UserUpdated(users: state.users));
  }

  void _deleteUser(DeleteUser event,Emitter<UserState> emit){
    state.users.remove(event.user);
    emit(UserUpdated(users: state.users));
  }

  void _updateUser(UpdateUser event,Emitter<UserState> emit){
    for(int i = 0; i < state.users.length; i++){
      if(event.user.id == state.users[i].id){
        state.users[i] = event.user;
      }
    }
    emit(UserUpdated(users: state.users));
  }
}