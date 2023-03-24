import 'package:cubit_demo_app/Models/user_model.dart';
import 'package:flutter/material.dart';

class UsersLoaded extends StatelessWidget {
  const UsersLoaded({
    super.key,
    required this.users,
    required this.onRefresh,
  });

  final List<Users> users;
  final ValueGetter<Future<void>> onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text(
                '${user.id}',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(user.name),
            subtitle: Text(user.username),
          );
        },
      ),
    );
  }
}
