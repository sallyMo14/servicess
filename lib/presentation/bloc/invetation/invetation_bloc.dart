import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../../domain/usecases/accept_invetation_usecase.dart';
import '../../../domain/usecases/get_provider_invetations_usecase.dart';
import '../../../domain/usecases/reject_invetation_usecase.dart';

part 'invetation_event.dart';
part 'invetation_state.dart';

class InvetationBloc extends Bloc<InvetationEvent, InvetationState> {
  GetProviderInvetationsUsecase getProviderInvetationsUsecase;
  AcceptInvetationUsecase acceptInvetationUsecase;
  RejectInvetationUsecase rejectInvetationUsecase;
  InvetationBloc({
    required this.getProviderInvetationsUsecase,
    required this.acceptInvetationUsecase,
    required this.rejectInvetationUsecase,
  }) : super(InvetationInitial()) {
    on<GetInvetationsEvent>(_onGeInvetations);
    on<AcceptInvitationEvent>(_onAcceptInv);
    on<RejectInvitationEvent>(_onRejectInv);
  }

  FutureOr<void> _onGeInvetations(
    GetInvetationsEvent event,
    Emitter<InvetationState> emit,
  ) async {
    try {
      emit(InvetationLoadingState());
      final result = await getProviderInvetationsUsecase.call(
        event.userId,
      );
      emit(GotInvetationsState(invetations: result));
    } catch (e) {
      emit(
        InvetationExceptionState(
          message: "unable to get Invetations : ${e.toString()}",
        ),
      );
    }
  }

  FutureOr<void> _onAcceptInv(
    AcceptInvitationEvent event,
    Emitter<InvetationState> emit,
  ) async {
    try {
      emit(InvetationLoadingState());
      await acceptInvetationUsecase.call(event.invId);
      emit(InvetationsRefreshState());
    } catch (e) {
      emit(
        InvetationExceptionState(
          message:
              "unable to accept this Invetation : ${e.toString()}",
        ),
      );
    }
  }

  FutureOr<void> _onRejectInv(
    RejectInvitationEvent event,
    Emitter<InvetationState> emit,
  ) async {
    try {
      emit(InvetationLoadingState());
      await rejectInvetationUsecase.call(event.invId);
      emit(InvetationsRefreshState());
    } catch (e) {
      emit(
        InvetationExceptionState(
          message:
              "unable to reject this Invetation : ${e.toString()}",
        ),
      );
    }
  }
}
