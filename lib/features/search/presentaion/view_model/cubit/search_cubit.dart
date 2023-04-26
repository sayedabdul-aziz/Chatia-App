import 'package:chatia/services/database_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of(context);

  QuerySnapshot? groups;
  bool isJoined = false;
  Future<void> searchByName(String groupName) async {
    emit(SearchLoadingState());
    try {
      await DatabaseServices().searchingByGroupName(groupName).then((value) {
        groups = value;
      });

      print(isJoined);
      emit(SearchSuccessState());
    } catch (e) {
      print(e.toString());
      emit(SearchErrorState());
    }
  }

  // Future<bool> isUser(groupName) async {
  //   await DatabaseServices().isUserJoined(groupName).then((value) {
  //     if (value) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   });
  // }
}
