/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:bhagavad_gita_client/src/protocol/users.dart' as _i3;
import 'dart:io' as _i4;
import 'protocol.dart' as _i5;

class _EndpointUsers extends _i1.EndpointRef {
  _EndpointUsers(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'users';

  _i2.Future<Map<String, dynamic>> addUser({required String phoneNumber}) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'users',
        'addUser',
        {'phoneNumber': phoneNumber},
      );

  _i2.Future<_i3.Users> getUserByPhoneNumber({required String phoneNumber}) =>
      caller.callServerEndpoint<_i3.Users>(
        'users',
        'getUserByPhoneNumber',
        {'phoneNumber': phoneNumber},
      );
}

class Client extends _i1.ServerpodClient {
  Client(
    String host, {
    _i4.SecurityContext? context,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
  }) : super(
          host,
          _i5.Protocol(),
          context: context,
          authenticationKeyManager: authenticationKeyManager,
        ) {
    users = _EndpointUsers(this);
  }

  late final _EndpointUsers users;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {'users': users};
  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
