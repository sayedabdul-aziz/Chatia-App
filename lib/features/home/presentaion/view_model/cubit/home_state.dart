part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class GroupsLoadingState extends HomeState {}

class GroupsSuccessState extends HomeState {
  final GroupModel? model;

  GroupsSuccessState({this.model});
}

class GroupsErrorState extends HomeState {
  final String? error;

  GroupsErrorState({this.error});
}

class CreateGroupLoadingState extends HomeState {}

class CreateGroupSuccessState extends HomeState {
  final GroupModel? model;

  CreateGroupSuccessState({this.model});
}

class CreateGroupErrorState extends HomeState {
  final String? error;

  CreateGroupErrorState({this.error});
}
