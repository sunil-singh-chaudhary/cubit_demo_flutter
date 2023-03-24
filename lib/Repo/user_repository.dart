import 'package:cubit_demo_app/Models/user_model.dart';

import 'base_repository.dart';
import 'exceptions/repository_exception.dart';

class UserRepository extends BaseRepository {
  UserRepository({
    Client? client,
  }) : super(client);

  Future<List<Users>> getUsers() async {
    final response = await get<List>('/users').catchError((error) {
      if (error is RepositoryException) {
        throw error;
      } else {
        throw const RepositoryException();
      }
    });

    return response.map((e) => Users.fromJson(e)).toList();
  }

  Future<Users> getUser(int id) async {
    final response =
        await get<Map<String, dynamic>>('/users/$id').catchError((error) {
      if (error is RepositoryException) {
        throw error;
      } else {
        throw const RepositoryException();
      }
    });

    final user = Users.fromJson(response);

    return user;
  }
}
