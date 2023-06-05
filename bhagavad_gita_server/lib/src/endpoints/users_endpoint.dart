import 'package:bhagavad_gita_server/src/generated/users.dart';
import 'package:serverpod/serverpod.dart';

class UsersEndpoint extends Endpoint {
  Future<Map<String, dynamic>> addUser(Session session,
      {required String phoneNumber}) async {
    return {
      'message': 'User added successfully $phoneNumber!',
    };
  }

  Future<Users> getUserByPhoneNumber(Session session,
      {required String phoneNumber}) async {
    final user = await Users.find(
      session,
      where: (e) {
        return e.phoneNumber.equals(phoneNumber);
      },
    );
    return user.first;
  }
}
