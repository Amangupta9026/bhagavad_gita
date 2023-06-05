/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

class Users extends _i1.TableRow {
  Users({
    int? id,
    required this.phoneNumber,
  }) : super(id);

  factory Users.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Users(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      phoneNumber: serializationManager
          .deserialize<String>(jsonSerialization['phoneNumber']),
    );
  }

  static final t = UsersTable();

  String phoneNumber;

  @override
  String get tableName => 'users';
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
    };
  }

  @override
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
    };
  }

  @override
  void setColumn(
    String columnName,
    value,
  ) {
    switch (columnName) {
      case 'id':
        id = value;
        return;
      case 'phoneNumber':
        phoneNumber = value;
        return;
      default:
        throw UnimplementedError();
    }
  }

  static Future<List<Users>> find(
    _i1.Session session, {
    UsersExpressionBuilder? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Users>(
      where: where != null ? where(Users.t) : null,
      limit: limit,
      offset: offset,
      orderBy: orderBy,
      orderByList: orderByList,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static Future<Users?> findSingleRow(
    _i1.Session session, {
    UsersExpressionBuilder? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findSingleRow<Users>(
      where: where != null ? where(Users.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static Future<Users?> findById(
    _i1.Session session,
    int id,
  ) async {
    return session.db.findById<Users>(id);
  }

  static Future<int> delete(
    _i1.Session session, {
    required UsersExpressionBuilder where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Users>(
      where: where(Users.t),
      transaction: transaction,
    );
  }

  static Future<bool> deleteRow(
    _i1.Session session,
    Users row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow(
      row,
      transaction: transaction,
    );
  }

  static Future<bool> update(
    _i1.Session session,
    Users row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.update(
      row,
      transaction: transaction,
    );
  }

  static Future<void> insert(
    _i1.Session session,
    Users row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert(
      row,
      transaction: transaction,
    );
  }

  static Future<int> count(
    _i1.Session session, {
    UsersExpressionBuilder? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Users>(
      where: where != null ? where(Users.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
  }
}

typedef UsersExpressionBuilder = _i1.Expression Function(UsersTable);

class UsersTable extends _i1.Table {
  UsersTable() : super(tableName: 'users');

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  final id = _i1.ColumnInt('id');

  final phoneNumber = _i1.ColumnString('phoneNumber');

  @override
  List<_i1.Column> get columns => [
        id,
        phoneNumber,
      ];
}

@Deprecated('Use UsersTable.t instead.')
UsersTable tUsers = UsersTable();
