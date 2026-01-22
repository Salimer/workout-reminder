/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i2;
import '../../../app/features/profile/goal.dart' as _i3;
import 'package:workouts_reminder_server/src/generated/protocol.dart' as _i4;

abstract class Profile
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Profile._({
    this.id,
    required this.authUserId,
    this.authUser,
    this.goals,
    required this.motivation,
    required this.characterName,
    required this.fitnessLevel,
    required this.notificationTone,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Profile({
    int? id,
    required _i1.UuidValue authUserId,
    _i2.AuthUser? authUser,
    List<_i3.Goal>? goals,
    required String motivation,
    required String characterName,
    required String fitnessLevel,
    required String notificationTone,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ProfileImpl;

  factory Profile.fromJson(Map<String, dynamic> jsonSerialization) {
    return Profile(
      id: jsonSerialization['id'] as int?,
      authUserId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.AuthUser>(
              jsonSerialization['authUser'],
            ),
      goals: jsonSerialization['goals'] == null
          ? null
          : _i4.Protocol().deserialize<List<_i3.Goal>>(
              jsonSerialization['goals'],
            ),
      motivation: jsonSerialization['motivation'] as String,
      characterName: jsonSerialization['characterName'] as String,
      fitnessLevel: jsonSerialization['fitnessLevel'] as String,
      notificationTone: jsonSerialization['notificationTone'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = ProfileTable();

  static const db = ProfileRepository._();

  @override
  int? id;

  _i1.UuidValue authUserId;

  _i2.AuthUser? authUser;

  List<_i3.Goal>? goals;

  String motivation;

  String characterName;

  String fitnessLevel;

  String notificationTone;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Profile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Profile copyWith({
    int? id,
    _i1.UuidValue? authUserId,
    _i2.AuthUser? authUser,
    List<_i3.Goal>? goals,
    String? motivation,
    String? characterName,
    String? fitnessLevel,
    String? notificationTone,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Profile',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      if (goals != null) 'goals': goals?.toJson(valueToJson: (v) => v.toJson()),
      'motivation': motivation,
      'characterName': characterName,
      'fitnessLevel': fitnessLevel,
      'notificationTone': notificationTone,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Profile',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJsonForProtocol(),
      if (goals != null)
        'goals': goals?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'motivation': motivation,
      'characterName': characterName,
      'fitnessLevel': fitnessLevel,
      'notificationTone': notificationTone,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ProfileInclude include({
    _i2.AuthUserInclude? authUser,
    _i3.GoalIncludeList? goals,
  }) {
    return ProfileInclude._(
      authUser: authUser,
      goals: goals,
    );
  }

  static ProfileIncludeList includeList({
    _i1.WhereExpressionBuilder<ProfileTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProfileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProfileTable>? orderByList,
    ProfileInclude? include,
  }) {
    return ProfileIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Profile.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Profile.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProfileImpl extends Profile {
  _ProfileImpl({
    int? id,
    required _i1.UuidValue authUserId,
    _i2.AuthUser? authUser,
    List<_i3.Goal>? goals,
    required String motivation,
    required String characterName,
    required String fitnessLevel,
    required String notificationTone,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         authUser: authUser,
         goals: goals,
         motivation: motivation,
         characterName: characterName,
         fitnessLevel: fitnessLevel,
         notificationTone: notificationTone,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Profile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Profile copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? authUserId,
    Object? authUser = _Undefined,
    Object? goals = _Undefined,
    String? motivation,
    String? characterName,
    String? fitnessLevel,
    String? notificationTone,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Profile(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      authUser: authUser is _i2.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      goals: goals is List<_i3.Goal>?
          ? goals
          : this.goals?.map((e0) => e0.copyWith()).toList(),
      motivation: motivation ?? this.motivation,
      characterName: characterName ?? this.characterName,
      fitnessLevel: fitnessLevel ?? this.fitnessLevel,
      notificationTone: notificationTone ?? this.notificationTone,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ProfileUpdateTable extends _i1.UpdateTable<ProfileTable> {
  ProfileUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> authUserId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.authUserId,
    value,
  );

  _i1.ColumnValue<String, String> motivation(String value) => _i1.ColumnValue(
    table.motivation,
    value,
  );

  _i1.ColumnValue<String, String> characterName(String value) =>
      _i1.ColumnValue(
        table.characterName,
        value,
      );

  _i1.ColumnValue<String, String> fitnessLevel(String value) => _i1.ColumnValue(
    table.fitnessLevel,
    value,
  );

  _i1.ColumnValue<String, String> notificationTone(String value) =>
      _i1.ColumnValue(
        table.notificationTone,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class ProfileTable extends _i1.Table<int?> {
  ProfileTable({super.tableRelation}) : super(tableName: 'profile') {
    updateTable = ProfileUpdateTable(this);
    authUserId = _i1.ColumnUuid(
      'authUserId',
      this,
    );
    motivation = _i1.ColumnString(
      'motivation',
      this,
    );
    characterName = _i1.ColumnString(
      'characterName',
      this,
    );
    fitnessLevel = _i1.ColumnString(
      'fitnessLevel',
      this,
    );
    notificationTone = _i1.ColumnString(
      'notificationTone',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
  }

  late final ProfileUpdateTable updateTable;

  late final _i1.ColumnUuid authUserId;

  _i2.AuthUserTable? _authUser;

  _i3.GoalTable? ___goals;

  _i1.ManyRelation<_i3.GoalTable>? _goals;

  late final _i1.ColumnString motivation;

  late final _i1.ColumnString characterName;

  late final _i1.ColumnString fitnessLevel;

  late final _i1.ColumnString notificationTone;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  _i2.AuthUserTable get authUser {
    if (_authUser != null) return _authUser!;
    _authUser = _i1.createRelationTable(
      relationFieldName: 'authUser',
      field: Profile.t.authUserId,
      foreignField: _i2.AuthUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.AuthUserTable(tableRelation: foreignTableRelation),
    );
    return _authUser!;
  }

  _i3.GoalTable get __goals {
    if (___goals != null) return ___goals!;
    ___goals = _i1.createRelationTable(
      relationFieldName: '__goals',
      field: Profile.t.id,
      foreignField: _i3.Goal.t.profileId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.GoalTable(tableRelation: foreignTableRelation),
    );
    return ___goals!;
  }

  _i1.ManyRelation<_i3.GoalTable> get goals {
    if (_goals != null) return _goals!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'goals',
      field: Profile.t.id,
      foreignField: _i3.Goal.t.profileId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.GoalTable(tableRelation: foreignTableRelation),
    );
    _goals = _i1.ManyRelation<_i3.GoalTable>(
      tableWithRelations: relationTable,
      table: _i3.GoalTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _goals!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    authUserId,
    motivation,
    characterName,
    fitnessLevel,
    notificationTone,
    createdAt,
    updatedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'authUser') {
      return authUser;
    }
    if (relationField == 'goals') {
      return __goals;
    }
    return null;
  }
}

class ProfileInclude extends _i1.IncludeObject {
  ProfileInclude._({
    _i2.AuthUserInclude? authUser,
    _i3.GoalIncludeList? goals,
  }) {
    _authUser = authUser;
    _goals = goals;
  }

  _i2.AuthUserInclude? _authUser;

  _i3.GoalIncludeList? _goals;

  @override
  Map<String, _i1.Include?> get includes => {
    'authUser': _authUser,
    'goals': _goals,
  };

  @override
  _i1.Table<int?> get table => Profile.t;
}

class ProfileIncludeList extends _i1.IncludeList {
  ProfileIncludeList._({
    _i1.WhereExpressionBuilder<ProfileTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Profile.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Profile.t;
}

class ProfileRepository {
  const ProfileRepository._();

  final attach = const ProfileAttachRepository._();

  final attachRow = const ProfileAttachRowRepository._();

  final detach = const ProfileDetachRepository._();

  final detachRow = const ProfileDetachRowRepository._();

  /// Returns a list of [Profile]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Profile>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ProfileTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProfileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProfileTable>? orderByList,
    _i1.Transaction? transaction,
    ProfileInclude? include,
  }) async {
    return session.db.find<Profile>(
      where: where?.call(Profile.t),
      orderBy: orderBy?.call(Profile.t),
      orderByList: orderByList?.call(Profile.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [Profile] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Profile?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ProfileTable>? where,
    int? offset,
    _i1.OrderByBuilder<ProfileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProfileTable>? orderByList,
    _i1.Transaction? transaction,
    ProfileInclude? include,
  }) async {
    return session.db.findFirstRow<Profile>(
      where: where?.call(Profile.t),
      orderBy: orderBy?.call(Profile.t),
      orderByList: orderByList?.call(Profile.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [Profile] by its [id] or null if no such row exists.
  Future<Profile?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    ProfileInclude? include,
  }) async {
    return session.db.findById<Profile>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [Profile]s in the list and returns the inserted rows.
  ///
  /// The returned [Profile]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Profile>> insert(
    _i1.Session session,
    List<Profile> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Profile>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Profile] and returns the inserted row.
  ///
  /// The returned [Profile] will have its `id` field set.
  Future<Profile> insertRow(
    _i1.Session session,
    Profile row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Profile>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Profile]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Profile>> update(
    _i1.Session session,
    List<Profile> rows, {
    _i1.ColumnSelections<ProfileTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Profile>(
      rows,
      columns: columns?.call(Profile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Profile]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Profile> updateRow(
    _i1.Session session,
    Profile row, {
    _i1.ColumnSelections<ProfileTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Profile>(
      row,
      columns: columns?.call(Profile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Profile] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Profile?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<ProfileUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Profile>(
      id,
      columnValues: columnValues(Profile.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Profile]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Profile>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<ProfileUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ProfileTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProfileTable>? orderBy,
    _i1.OrderByListBuilder<ProfileTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Profile>(
      columnValues: columnValues(Profile.t.updateTable),
      where: where(Profile.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Profile.t),
      orderByList: orderByList?.call(Profile.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Profile]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Profile>> delete(
    _i1.Session session,
    List<Profile> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Profile>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Profile].
  Future<Profile> deleteRow(
    _i1.Session session,
    Profile row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Profile>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Profile>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ProfileTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Profile>(
      where: where(Profile.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ProfileTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Profile>(
      where: where?.call(Profile.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class ProfileAttachRepository {
  const ProfileAttachRepository._();

  /// Creates a relation between this [Profile] and the given [Goal]s
  /// by setting each [Goal]'s foreign key `profileId` to refer to this [Profile].
  Future<void> goals(
    _i1.Session session,
    Profile profile,
    List<_i3.Goal> goal, {
    _i1.Transaction? transaction,
  }) async {
    if (goal.any((e) => e.id == null)) {
      throw ArgumentError.notNull('goal.id');
    }
    if (profile.id == null) {
      throw ArgumentError.notNull('profile.id');
    }

    var $goal = goal.map((e) => e.copyWith(profileId: profile.id)).toList();
    await session.db.update<_i3.Goal>(
      $goal,
      columns: [_i3.Goal.t.profileId],
      transaction: transaction,
    );
  }
}

class ProfileAttachRowRepository {
  const ProfileAttachRowRepository._();

  /// Creates a relation between the given [Profile] and [AuthUser]
  /// by setting the [Profile]'s foreign key `authUserId` to refer to the [AuthUser].
  Future<void> authUser(
    _i1.Session session,
    Profile profile,
    _i2.AuthUser authUser, {
    _i1.Transaction? transaction,
  }) async {
    if (profile.id == null) {
      throw ArgumentError.notNull('profile.id');
    }
    if (authUser.id == null) {
      throw ArgumentError.notNull('authUser.id');
    }

    var $profile = profile.copyWith(authUserId: authUser.id);
    await session.db.updateRow<Profile>(
      $profile,
      columns: [Profile.t.authUserId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Profile] and the given [Goal]
  /// by setting the [Goal]'s foreign key `profileId` to refer to this [Profile].
  Future<void> goals(
    _i1.Session session,
    Profile profile,
    _i3.Goal goal, {
    _i1.Transaction? transaction,
  }) async {
    if (goal.id == null) {
      throw ArgumentError.notNull('goal.id');
    }
    if (profile.id == null) {
      throw ArgumentError.notNull('profile.id');
    }

    var $goal = goal.copyWith(profileId: profile.id);
    await session.db.updateRow<_i3.Goal>(
      $goal,
      columns: [_i3.Goal.t.profileId],
      transaction: transaction,
    );
  }
}

class ProfileDetachRepository {
  const ProfileDetachRepository._();

  /// Detaches the relation between this [Profile] and the given [Goal]
  /// by setting the [Goal]'s foreign key `profileId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> goals(
    _i1.Session session,
    List<_i3.Goal> goal, {
    _i1.Transaction? transaction,
  }) async {
    if (goal.any((e) => e.id == null)) {
      throw ArgumentError.notNull('goal.id');
    }

    var $goal = goal.map((e) => e.copyWith(profileId: null)).toList();
    await session.db.update<_i3.Goal>(
      $goal,
      columns: [_i3.Goal.t.profileId],
      transaction: transaction,
    );
  }
}

class ProfileDetachRowRepository {
  const ProfileDetachRowRepository._();

  /// Detaches the relation between this [Profile] and the given [Goal]
  /// by setting the [Goal]'s foreign key `profileId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> goals(
    _i1.Session session,
    _i3.Goal goal, {
    _i1.Transaction? transaction,
  }) async {
    if (goal.id == null) {
      throw ArgumentError.notNull('goal.id');
    }

    var $goal = goal.copyWith(profileId: null);
    await session.db.updateRow<_i3.Goal>(
      $goal,
      columns: [_i3.Goal.t.profileId],
      transaction: transaction,
    );
  }
}
