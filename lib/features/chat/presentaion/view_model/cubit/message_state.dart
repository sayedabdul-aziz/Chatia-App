part of 'message_cubit.dart';

abstract class MessageState {}

class MessageInitial extends MessageState {}

class MessagesLoadingState extends MessageState {}

class MessagesSuccessState extends MessageState {}

class MessagesErrorState extends MessageState {}

class GetMembersLoadingState extends MessageState {}

class GetMembersSuccessState extends MessageState {}

class GetMembersErrorState extends MessageState {}

class GetAdminLoadingState extends MessageState {}

class GetAdminSuccessState extends MessageState {}

class GetAdminErrorState extends MessageState {}
