import 'package:chatia/services/database_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit() : super(MessageInitial());

  static MessageCubit get(context) => BlocProvider.of(context);

  Stream? members;

  Future<void> getMembers(String groupId) async {
    emit(GetMembersLoadingState());
    try {
      await DatabaseServices().gettingGroupMembers(groupId).then((value) {
        members = value;
      });
      emit(GetMembersSuccessState());
    } catch (e) {
      print(e.toString());
      emit(GetMembersErrorState());
    }
  }

  String? admin;
  Future<void> getAdminName(String groupId) async {
    emit(GetAdminLoadingState());
    try {
      await DatabaseServices().gettingGroupAdmin(groupId).then((value) {
        admin = value;
      });
      emit(GetAdminSuccessState());
    } catch (e) {
      print(e.toString());
      emit(GetAdminErrorState());
    }
  }
}
