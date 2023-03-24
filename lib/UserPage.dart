import 'dart:developer';

import 'package:cubit_demo_app/Repo/user_repository.dart';
import 'package:cubit_demo_app/userBloc/user_cubit.dart';
import 'package:cubit_demo_app/userBloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'UsersLoaded.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserCubit(context.read<UserRepository>())..getUsers(),
      child: const UserView(),
    );
  }
}

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demo')),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          switch (state.status) {
            case UserStatus.initial:
              return const Text('initial');

            case UserStatus.loading:
              return const CircularProgressIndicator();

            case UserStatus.success:
              print(state.status);
              log(state.status.toString());
              return UsersLoaded(
                users: state.user,
                onRefresh: context.read<UserCubit>().refreshUsers,
              );

            case UserStatus.failed:
              return const Text('error');
          }
        },
      ),
    );
  }
}
