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
import '../../../app/features/week_schedules/week_schedule.dart' as _i2;
import 'package:workouts_reminder_server/src/generated/protocol.dart' as _i3;

abstract class Progress
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Progress._({
    this.id,
    required this.userId,
    this.weeks,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Progress({
    int? id,
    required _i1.UuidValue userId,
    List<_i2.WeekSchedule>? weeks,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ProgressImpl;

  factory Progress.fromJson(Map<String, dynamic> jsonSerialization) {
    return Progress(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      weeks: jsonSerialization['weeks'] == null
          ? null
          : _i3.Protocol().deserialize<List<_i2.WeekSchedule>>(
              jsonSerialization['weeks'],
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = ProgressTable();

  static const db = ProgressRepository._();

  @override
  int? id;

  _i1.UuidValue userId;

  List<_i2.WeekSchedule>? weeks;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Progress]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Progress copyWith({
    int? id,
    _i1.UuidValue? userId,
    List<_i2.WeekSchedule>? weeks,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Progress',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      if (weeks != null) 'weeks': weeks?.toJson(valueToJson: (v) => v.toJson()),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Progress',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      if (weeks != null)
        'weeks': weeks?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ProgressInclude include({_i2.WeekScheduleIncludeList? weeks}) {
    return ProgressInclude._(weeks: weeks);
  }

  static ProgressIncludeList includeList({
    _i1.WhereExpressionBuilder<ProgressTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProgressTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProgressTable>? orderByList,
    ProgressInclude? include,
  }) {
    return ProgressIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Progress.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Progress.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProgressImpl extends Progress {
  _ProgressImpl({
    int? id,
    required _i1.UuidValue userId,
    List<_i2.WeekSchedule>? weeks,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         weeks: weeks,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Progress]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Progress copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    Object? weeks = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Progress(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      weeks: weeks is List<_i2.WeekSchedule>?
          ? weeks
          : this.weeks?.map((e0) => e0.copyWith()).toList(),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ProgressUpdateTable extends _i1.UpdateTable<ProgressTable> {
  ProgressUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> userId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.userId,
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

class ProgressTable extends _i1.Table<int?> {
  ProgressTable({super.tableRelation}) : super(tableName: 'progress') {
    updateTable = ProgressUpdateTable(this);
    userId = _i1.ColumnUuid(
      'userId',
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

  late final ProgressUpdateTable updateTable;

  late final _i1.ColumnUuid userId;

  _i2.WeekScheduleTable? ___weeks;

  _i1.ManyRelation<_i2.WeekScheduleTable>? _weeks;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  _i2.WeekScheduleTable get __weeks {
    if (___weeks != null) return ___weeks!;
    ___weeks = _i1.createRelationTable(
      relationFieldName: '__weeks',
      field: Progress.t.id,
      foreignField: _i2.WeekSchedule.t.$_progressWeeksProgressId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.WeekScheduleTable(tableRelation: foreignTableRelation),
    );
    return ___weeks!;
  }

  _i1.ManyRelation<_i2.WeekScheduleTable> get weeks {
    if (_weeks != null) return _weeks!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'weeks',
      field: Progress.t.id,
      foreignField: _i2.WeekSchedule.t.$_progressWeeksProgressId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.WeekScheduleTable(tableRelation: foreignTableRelation),
    );
    _weeks = _i1.ManyRelation<_i2.WeekScheduleTable>(
      tableWithRelations: relationTable,
      table: _i2.WeekScheduleTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _weeks!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    createdAt,
    updatedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'weeks') {
      return __weeks;
    }
    return null;
  }
}

class ProgressInclude extends _i1.IncludeObject {
  ProgressInclude._({_i2.WeekScheduleIncludeList? weeks}) {
    _weeks = weeks;
  }

  _i2.WeekScheduleIncludeList? _weeks;

  @override
  Map<String, _i1.Include?> get includes => {'weeks': _weeks};

  @override
  _i1.Table<int?> get table => Progress.t;
}

class ProgressIncludeList extends _i1.IncludeList {
  ProgressIncludeList._({
    _i1.WhereExpressionBuilder<ProgressTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Progress.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Progress.t;
}

class ProgressRepository {
  const ProgressRepository._();

  final attach = const ProgressAttachRepository._();

  final attachRow = const ProgressAttachRowRepository._();

  final detach = const ProgressDetachRepository._();

  final detachRow = const ProgressDetachRowRepository._();

  /// Returns a list of [Progress]s matching the given query parameters.
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
  Future<List<Progress>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ProgressTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProgressTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProgressTable>? orderByList,
    _i1.Transaction? transaction,
    ProgressInclude? include,
  }) async {
    return session.db.find<Progress>(
      where: where?.call(Progress.t),
      orderBy: orderBy?.call(Progress.t),
      orderByList: orderByList?.call(Progress.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [Progress] matching the given query parameters.
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
  Future<Progress?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ProgressTable>? where,
    int? offset,
    _i1.OrderByBuilder<ProgressTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProgressTable>? orderByList,
    _i1.Transaction? transaction,
    ProgressInclude? include,
  }) async {
    return session.db.findFirstRow<Progress>(
      where: where?.call(Progress.t),
      orderBy: orderBy?.call(Progress.t),
      orderByList: orderByList?.call(Progress.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [Progress] by its [id] or null if no such row exists.
  Future<Progress?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    ProgressInclude? include,
  }) async {
    return session.db.findById<Progress>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [Progress]s in the list and returns the inserted rows.
  ///
  /// The returned [Progress]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Progress>> insert(
    _i1.Session session,
    List<Progress> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Progress>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Progress] and returns the inserted row.
  ///
  /// The returned [Progress] will have its `id` field set.
  Future<Progress> insertRow(
    _i1.Session session,
    Progress row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Progress>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Progress]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Progress>> update(
    _i1.Session session,
    List<Progress> rows, {
    _i1.ColumnSelections<ProgressTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Progress>(
      rows,
      columns: columns?.call(Progress.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Progress]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Progress> updateRow(
    _i1.Session session,
    Progress row, {
    _i1.ColumnSelections<ProgressTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Progress>(
      row,
      columns: columns?.call(Progress.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Progress] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Progress?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<ProgressUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Progress>(
      id,
      columnValues: columnValues(Progress.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Progress]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Progress>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<ProgressUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ProgressTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProgressTable>? orderBy,
    _i1.OrderByListBuilder<ProgressTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Progress>(
      columnValues: columnValues(Progress.t.updateTable),
      where: where(Progress.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Progress.t),
      orderByList: orderByList?.call(Progress.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Progress]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Progress>> delete(
    _i1.Session session,
    List<Progress> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Progress>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Progress].
  Future<Progress> deleteRow(
    _i1.Session session,
    Progress row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Progress>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Progress>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ProgressTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Progress>(
      where: where(Progress.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ProgressTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Progress>(
      where: where?.call(Progress.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class ProgressAttachRepository {
  const ProgressAttachRepository._();

  /// Creates a relation between this [Progress] and the given [WeekSchedule]s
  /// by setting each [WeekSchedule]'s foreign key `_progressWeeksProgressId` to refer to this [Progress].
  Future<void> weeks(
    _i1.Session session,
    Progress progress,
    List<_i2.WeekSchedule> weekSchedule, {
    _i1.Transaction? transaction,
  }) async {
    if (weekSchedule.any((e) => e.id == null)) {
      throw ArgumentError.notNull('weekSchedule.id');
    }
    if (progress.id == null) {
      throw ArgumentError.notNull('progress.id');
    }

    var $weekSchedule = weekSchedule
        .map(
          (e) => _i2.WeekScheduleImplicit(
            e,
            $_progressWeeksProgressId: progress.id,
          ),
        )
        .toList();
    await session.db.update<_i2.WeekSchedule>(
      $weekSchedule,
      columns: [_i2.WeekSchedule.t.$_progressWeeksProgressId],
      transaction: transaction,
    );
  }
}

class ProgressAttachRowRepository {
  const ProgressAttachRowRepository._();

  /// Creates a relation between this [Progress] and the given [WeekSchedule]
  /// by setting the [WeekSchedule]'s foreign key `_progressWeeksProgressId` to refer to this [Progress].
  Future<void> weeks(
    _i1.Session session,
    Progress progress,
    _i2.WeekSchedule weekSchedule, {
    _i1.Transaction? transaction,
  }) async {
    if (weekSchedule.id == null) {
      throw ArgumentError.notNull('weekSchedule.id');
    }
    if (progress.id == null) {
      throw ArgumentError.notNull('progress.id');
    }

    var $weekSchedule = _i2.WeekScheduleImplicit(
      weekSchedule,
      $_progressWeeksProgressId: progress.id,
    );
    await session.db.updateRow<_i2.WeekSchedule>(
      $weekSchedule,
      columns: [_i2.WeekSchedule.t.$_progressWeeksProgressId],
      transaction: transaction,
    );
  }
}

class ProgressDetachRepository {
  const ProgressDetachRepository._();

  /// Detaches the relation between this [Progress] and the given [WeekSchedule]
  /// by setting the [WeekSchedule]'s foreign key `_progressWeeksProgressId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> weeks(
    _i1.Session session,
    List<_i2.WeekSchedule> weekSchedule, {
    _i1.Transaction? transaction,
  }) async {
    if (weekSchedule.any((e) => e.id == null)) {
      throw ArgumentError.notNull('weekSchedule.id');
    }

    var $weekSchedule = weekSchedule
        .map(
          (e) => _i2.WeekScheduleImplicit(
            e,
            $_progressWeeksProgressId: null,
          ),
        )
        .toList();
    await session.db.update<_i2.WeekSchedule>(
      $weekSchedule,
      columns: [_i2.WeekSchedule.t.$_progressWeeksProgressId],
      transaction: transaction,
    );
  }
}

class ProgressDetachRowRepository {
  const ProgressDetachRowRepository._();

  /// Detaches the relation between this [Progress] and the given [WeekSchedule]
  /// by setting the [WeekSchedule]'s foreign key `_progressWeeksProgressId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> weeks(
    _i1.Session session,
    _i2.WeekSchedule weekSchedule, {
    _i1.Transaction? transaction,
  }) async {
    if (weekSchedule.id == null) {
      throw ArgumentError.notNull('weekSchedule.id');
    }

    var $weekSchedule = _i2.WeekScheduleImplicit(
      weekSchedule,
      $_progressWeeksProgressId: null,
    );
    await session.db.updateRow<_i2.WeekSchedule>(
      $weekSchedule,
      columns: [_i2.WeekSchedule.t.$_progressWeeksProgressId],
      transaction: transaction,
    );
  }
}
