import 'package:chatia/services/database_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/group_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  DatabaseServices databaseServices = DatabaseServices();
  Stream? groups;

  Future<void> getGroupsList() async {
    emit(GroupsLoadingState());
    try {
      await DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid)
          .gettingUserGroups()
          .then((snapshot) {
        groups = snapshot;
      });
      emit(GroupsSuccessState());
    } catch (e) {
      emit(GroupsErrorState(error: e.toString()));
    }
  }

  Future<void> createGroup(String username, String id, String groupName) async {
    emit(CreateGroupLoadingState());
    try {
      await DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid)
          .creatingGroup(username, id, groupName);
      emit(CreateGroupSuccessState());
    } catch (e) {
      emit(CreateGroupErrorState(error: e.toString()));
    }
  }
}
