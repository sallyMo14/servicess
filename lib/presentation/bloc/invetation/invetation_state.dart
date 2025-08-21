part of 'invetation_bloc.dart';

abstract class InvetationState {
  const InvetationState();
}

class InvetationInitial extends InvetationState {}
class InvetationsRefreshState extends InvetationState {}

class InvetationLoadingState extends InvetationState {}

class GotInvetationsState extends InvetationState {
  Map<String, dynamic> invetations;

  GotInvetationsState({required this.invetations});
}

class InvetationExceptionState extends InvetationState {
  String message;
  InvetationExceptionState({required this.message});
}
