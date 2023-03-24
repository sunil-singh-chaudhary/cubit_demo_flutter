import 'package:cubit_demo_app/Repo/user_repository.dart';
import 'package:cubit_demo_app/userBloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository? userRepository;

  UserCubit(this.userRepository) : super(UserState.initial());

  Future<void> getUsers() async {
    emit(state.copyWith(status: UserStatus.loading));
    print('started getuser loading');
    await _getUsers();
  }

  Future<void> refreshUsers() async {
    if (!state.status.isSuccess || state.user.isEmpty) {
      return;
    }

    await _getUsers();
  }

  Future<void> _getUsers() async {
    try {
      final users = await userRepository?.getUsers();

      emit(state.copyWith(
        status: UserStatus.success,
        user: users!,
      ));
    } on Exception {
      emit(state.copyWith(status: UserStatus.failed));
    }
  }
}
