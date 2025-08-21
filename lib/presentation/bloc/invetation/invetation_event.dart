part of 'invetation_bloc.dart';

abstract class InvetationEvent {
  const InvetationEvent();
}

class GetInvetationsEvent extends InvetationEvent {
  String userId;
  GetInvetationsEvent({required this.userId});
}
class AcceptInvitationEvent extends InvetationEvent {
  final String invId;

  AcceptInvitationEvent({required this.invId});
}

class RejectInvitationEvent extends InvetationEvent {
  final String invId;

  RejectInvitationEvent({required this.invId});
}