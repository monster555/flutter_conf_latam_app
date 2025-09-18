import 'dart:convert';
import 'dart:io';

import 'package:conf_auth_repository/conf_auth_repository.dart';
import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'update_information_state.dart';

class UpdateInformationCubit extends Cubit<UpdateInformationState> {
  UpdateInformationCubit(
    super.initialState, {
    required IUserRepository userRepository,
    required IConfAuthRepository authRepository,
  }) : _userRepository = userRepository,
       _authRepository = authRepository;

  final IUserRepository _userRepository;
  final IConfAuthRepository _authRepository;

  Future<void> update({
    required String firstName,
    required String lastName,
    File? photo,
  }) async {
    emit(const UpdatingInformation());
    final avatar = await photo?.toBase64();
    final id = _authRepository.currentUser!.id;
    final data = {
      'id': id,
      'name': firstName,
      'surname': lastName,
      if (avatar != null) 'avatar': avatar,
    };
    final result = await _userRepository.create(data);
    final state = switch (result) {
      Success(:final data) => UpdatedInformation(user: data),
      Failure() => const UpdatingInformationError(),
    };
    emit(state);
  }
}

extension on File {
  Future<String?> toBase64() async {
    try {
      final bytes = await readAsBytes();
      final base64Image = base64Encode(bytes);
      return 'data:image/jpeg;base64,$base64Image';
    } on Exception catch (_) {
      return null;
    }
  }
}
