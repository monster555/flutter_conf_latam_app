import 'package:flutter_bloc/flutter_bloc.dart';

class ValueCubit<T> extends Cubit<T> {
  ValueCubit(super.initialState);

  void update(T value) => emit(value);
}
