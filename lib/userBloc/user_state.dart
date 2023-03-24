import 'package:equatable/equatable.dart';

import '../Models/user_model.dart';

enum UserStatus { initial, loading, success, failed }

extension UserStatusX on UserStatus {
  bool get isInitial => this == UserStatus.initial;
  bool get isLoading => this == UserStatus.loading;
  bool get isSuccess => this == UserStatus.success;
  bool get isFailed => this == UserStatus.failed;
}

class UserState extends Equatable {
  const UserState({required this.status, required this.user});

  final UserStatus status;
  final List<Users> user;

  factory UserState.initial() => //initial data set
      const UserState(status: UserStatus.initial, user: []);

  @override
  List<Object?> get props => [status, user];
  //watch over these two things status and users change

  UserState copyWith({UserStatus? status, List<Users>? user}) {
    return UserState(
      //using this now you dont have to create new object just copy and previous value same
      //if not assign with the new value
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }
}
