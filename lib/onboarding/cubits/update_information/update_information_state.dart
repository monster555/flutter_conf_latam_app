part of 'update_information_cubit.dart';

sealed class UpdateInformationState {
  const UpdateInformationState();
}

class UpdateInformationInitialState extends UpdateInformationState {
  const UpdateInformationInitialState();
}

class UpdatingInformation extends UpdateInformationState {
  const UpdatingInformation();
}

class UpdatedInformation extends UpdateInformationState {
  const UpdatedInformation({required this.user});
  final User user;
}

class UpdatingInformationError extends UpdateInformationState {
  const UpdatingInformationError();
}
