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
import '../../../app/features/progress/progress.dart' as _i2;
import '../../../app/features/day_schedules/day_schedule.dart' as _i3;
import 'package:workouts_reminder_server/src/generated/protocol.dart' as _i4;

abstract class WeekSchedule
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  WeekSchedule._({
    this.id,
    this.progressId,
    this.progress,
    this.days,
    required this.deadline,
    this.note,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory WeekSchedule({
    int? id,
    int? progressId,
    _i2.Progress? progress,
    List<_i3.DaySchedule>? days,
    required DateTime deadline,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _WeekScheduleImpl;

  factory WeekSchedule.fromJson(Map<String, dynamic> jsonSerialization) {
    return WeekSchedule(
      id: jsonSerialization['id'] as int?,
      progressId: jsonSerialization['progressId'] as int?,
      progress: jsonSerialization['progress'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Progress>(
              jsonSerialization['progress'],
            ),
      days: jsonSerialization['days'] == null
          ? null
          : _i4.Protocol().deserialize<List<_i3.DaySchedule>>(
              jsonSerialization['days'],
            ),
      deadline: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['deadline'],
      ),
      note: jsonSerialization['note'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = WeekScheduleTable();

  static const db = WeekScheduleRepository._();

  @override
  int? id;

  int? progressId;

  _i2.Progress? progress;

  List<_i3.DaySchedule>? days;

  DateTime deadline;

  String? note;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [WeekSchedule]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WeekSchedule copyWith({
    int? id,
    int? progressId,
    _i2.Progress? progress,
    List<_i3.DaySchedule>? days,
    DateTime? deadline,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WeekSchedule',
      if (id != null) 'id': id,
      if (progressId != null) 'progressId': progressId,
      if (progress != null) 'progress': progress?.toJson(),
      if (days != null) 'days': days?.toJson(valueToJson: (v) => v.toJson()),
      'deadline': deadline.toJson(),
      if (note != null) 'note': note,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WeekSchedule',
      if (id != null) 'id': id,
      if (progressId != null) 'progressId': progressId,
      if (progress != null) 'progress': progress?.toJsonForProtocol(),
      if (days != null)
        'days': days?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'deadline': deadline.toJson(),
      if (note != null) 'note': note,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static WeekScheduleInclude include({
    _i2.ProgressInclude? progress,
    _i3.DayScheduleIncludeList? days,
  }) {
    return WeekScheduleInclude._(
      progress: progress,
      days: days,
    );
  }

  static WeekScheduleIncludeList includeList({
    _i1.WhereExpressionBuilder<WeekScheduleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WeekScheduleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WeekScheduleTable>? orderByList,
    WeekScheduleInclude? include,
  }) {
    return WeekScheduleIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WeekSchedule.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(WeekSchedule.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WeekScheduleImpl extends WeekSchedule {
  _WeekScheduleImpl({
    int? id,
    int? progressId,
    _i2.Progress? progress,
    List<_i3.DaySchedule>? days,
    required DateTime deadline,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         progressId: progressId,
         progress: progress,
         days: days,
         deadline: deadline,
         note: note,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [WeekSchedule]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WeekSchedule copyWith({
    Object? id = _Undefined,
    Object? progressId = _Undefined,
    Object? progress = _Undefined,
    Object? days = _Undefined,
    DateTime? deadline,
    Object? note = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return WeekSchedule(
      id: id is int? ? id : this.id,
      progressId: progressId is int? ? progressId : this.progressId,
      progress: progress is _i2.Progress?
          ? progress
          : this.progress?.copyWith(),
      days: days is List<_i3.DaySchedule>?
          ? days
          : this.days?.map((e0) => e0.copyWith()).toList(),
      deadline: deadline ?? this.deadline,
      note: note is String? ? note : this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class WeekScheduleUpdateTable extends _i1.UpdateTable<WeekScheduleTable> {
  WeekScheduleUpdateTable(super.table);

  _i1.ColumnValue<int, int> progressId(int? value) => _i1.ColumnValue(
    table.progressId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> deadline(DateTime value) =>
      _i1.ColumnValue(
        table.deadline,
        value,
      );

  _i1.ColumnValue<String, String> note(String? value) => _i1.ColumnValue(
    table.note,
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

class WeekScheduleTable extends _i1.Table<int?> {
  WeekScheduleTable({super.tableRelation}) : super(tableName: 'week_schedule') {
    updateTable = WeekScheduleUpdateTable(this);
    progressId = _i1.ColumnInt(
      'progressId',
      this,
    );
    deadline = _i1.ColumnDateTime(
      'deadline',
      this,
    );
    note = _i1.ColumnString(
      'note',
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

  late final WeekScheduleUpdateTable updateTable;

  late final _i1.ColumnInt progressId;

  _i2.ProgressTable? _progress;

  _i3.DayScheduleTable? ___days;

  _i1.ManyRelation<_i3.DayScheduleTable>? _days;

  late final _i1.ColumnDateTime deadline;

  late final _i1.ColumnString note;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  _i2.ProgressTable get progress {
    if (_progress != null) return _progress!;
    _progress = _i1.createRelationTable(
      relationFieldName: 'progress',
      field: WeekSchedule.t.progressId,
      foreignField: _i2.Progress.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.ProgressTable(tableRelation: foreignTableRelation),
    );
    return _progress!;
  }

  _i3.DayScheduleTable get __days {
    if (___days != null) return ___days!;
    ___days = _i1.createRelationTable(
      relationFieldName: '__days',
      field: WeekSchedule.t.id,
      foreignField: _i3.DaySchedule.t.weekScheduleId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.DayScheduleTable(tableRelation: foreignTableRelation),
    );
    return ___days!;
  }

  _i1.ManyRelation<_i3.DayScheduleTable> get days {
    if (_days != null) return _days!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'days',
      field: WeekSchedule.t.id,
      foreignField: _i3.DaySchedule.t.weekScheduleId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.DayScheduleTable(tableRelation: foreignTableRelation),
    );
    _days = _i1.ManyRelation<_i3.DayScheduleTable>(
      tableWithRelations: relationTable,
      table: _i3.DayScheduleTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _days!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    progressId,
    deadline,
    note,
    createdAt,
    updatedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'progress') {
      return progress;
    }
    if (relationField == 'days') {
      return __days;
    }
    return null;
  }
}

class WeekScheduleInclude extends _i1.IncludeObject {
  WeekScheduleInclude._({
    _i2.ProgressInclude? progress,
    _i3.DayScheduleIncludeList? days,
  }) {
    _progress = progress;
    _days = days;
  }

  _i2.ProgressInclude? _progress;

  _i3.DayScheduleIncludeList? _days;

  @override
  Map<String, _i1.Include?> get includes => {
    'progress': _progress,
    'days': _days,
  };

  @override
  _i1.Table<int?> get table => WeekSchedule.t;
}

class WeekScheduleIncludeList extends _i1.IncludeList {
  WeekScheduleIncludeList._({
    _i1.WhereExpressionBuilder<WeekScheduleTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(WeekSchedule.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => WeekSchedule.t;
}

class WeekScheduleRepository {
  const WeekScheduleRepository._();

  final attach = const WeekScheduleAttachRepository._();

  final attachRow = const WeekScheduleAttachRowRepository._();

  final detach = const WeekScheduleDetachRepository._();

  final detachRow = const WeekScheduleDetachRowRepository._();

  /// Returns a list of [WeekSchedule]s matching the given query parameters.
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
  Future<List<WeekSchedule>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WeekScheduleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WeekScheduleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WeekScheduleTable>? orderByList,
    _i1.Transaction? transaction,
    WeekScheduleInclude? include,
  }) async {
    return session.db.find<WeekSchedule>(
      where: where?.call(WeekSchedule.t),
      orderBy: orderBy?.call(WeekSchedule.t),
      orderByList: orderByList?.call(WeekSchedule.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [WeekSchedule] matching the given query parameters.
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
  Future<WeekSchedule?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WeekScheduleTable>? where,
    int? offset,
    _i1.OrderByBuilder<WeekScheduleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WeekScheduleTable>? orderByList,
    _i1.Transaction? transaction,
    WeekScheduleInclude? include,
  }) async {
    return session.db.findFirstRow<WeekSchedule>(
      where: where?.call(WeekSchedule.t),
      orderBy: orderBy?.call(WeekSchedule.t),
      orderByList: orderByList?.call(WeekSchedule.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [WeekSchedule] by its [id] or null if no such row exists.
  Future<WeekSchedule?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    WeekScheduleInclude? include,
  }) async {
    return session.db.findById<WeekSchedule>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [WeekSchedule]s in the list and returns the inserted rows.
  ///
  /// The returned [WeekSchedule]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<WeekSchedule>> insert(
    _i1.Session session,
    List<WeekSchedule> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<WeekSchedule>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [WeekSchedule] and returns the inserted row.
  ///
  /// The returned [WeekSchedule] will have its `id` field set.
  Future<WeekSchedule> insertRow(
    _i1.Session session,
    WeekSchedule row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<WeekSchedule>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [WeekSchedule]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<WeekSchedule>> update(
    _i1.Session session,
    List<WeekSchedule> rows, {
    _i1.ColumnSelections<WeekScheduleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<WeekSchedule>(
      rows,
      columns: columns?.call(WeekSchedule.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WeekSchedule]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<WeekSchedule> updateRow(
    _i1.Session session,
    WeekSchedule row, {
    _i1.ColumnSelections<WeekScheduleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<WeekSchedule>(
      row,
      columns: columns?.call(WeekSchedule.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WeekSchedule] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<WeekSchedule?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<WeekScheduleUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<WeekSchedule>(
      id,
      columnValues: columnValues(WeekSchedule.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [WeekSchedule]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<WeekSchedule>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<WeekScheduleUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<WeekScheduleTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WeekScheduleTable>? orderBy,
    _i1.OrderByListBuilder<WeekScheduleTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<WeekSchedule>(
      columnValues: columnValues(WeekSchedule.t.updateTable),
      where: where(WeekSchedule.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WeekSchedule.t),
      orderByList: orderByList?.call(WeekSchedule.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [WeekSchedule]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<WeekSchedule>> delete(
    _i1.Session session,
    List<WeekSchedule> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<WeekSchedule>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [WeekSchedule].
  Future<WeekSchedule> deleteRow(
    _i1.Session session,
    WeekSchedule row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<WeekSchedule>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<WeekSchedule>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<WeekScheduleTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<WeekSchedule>(
      where: where(WeekSchedule.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WeekScheduleTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<WeekSchedule>(
      where: where?.call(WeekSchedule.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class WeekScheduleAttachRepository {
  const WeekScheduleAttachRepository._();

  /// Creates a relation between this [WeekSchedule] and the given [DaySchedule]s
  /// by setting each [DaySchedule]'s foreign key `weekScheduleId` to refer to this [WeekSchedule].
  Future<void> days(
    _i1.Session session,
    WeekSchedule weekSchedule,
    List<_i3.DaySchedule> daySchedule, {
    _i1.Transaction? transaction,
  }) async {
    if (daySchedule.any((e) => e.id == null)) {
      throw ArgumentError.notNull('daySchedule.id');
    }
    if (weekSchedule.id == null) {
      throw ArgumentError.notNull('weekSchedule.id');
    }

    var $daySchedule = daySchedule
        .map((e) => e.copyWith(weekScheduleId: weekSchedule.id))
        .toList();
    await session.db.update<_i3.DaySchedule>(
      $daySchedule,
      columns: [_i3.DaySchedule.t.weekScheduleId],
      transaction: transaction,
    );
  }
}

class WeekScheduleAttachRowRepository {
  const WeekScheduleAttachRowRepository._();

  /// Creates a relation between the given [WeekSchedule] and [Progress]
  /// by setting the [WeekSchedule]'s foreign key `progressId` to refer to the [Progress].
  Future<void> progress(
    _i1.Session session,
    WeekSchedule weekSchedule,
    _i2.Progress progress, {
    _i1.Transaction? transaction,
  }) async {
    if (weekSchedule.id == null) {
      throw ArgumentError.notNull('weekSchedule.id');
    }
    if (progress.id == null) {
      throw ArgumentError.notNull('progress.id');
    }

    var $weekSchedule = weekSchedule.copyWith(progressId: progress.id);
    await session.db.updateRow<WeekSchedule>(
      $weekSchedule,
      columns: [WeekSchedule.t.progressId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [WeekSchedule] and the given [DaySchedule]
  /// by setting the [DaySchedule]'s foreign key `weekScheduleId` to refer to this [WeekSchedule].
  Future<void> days(
    _i1.Session session,
    WeekSchedule weekSchedule,
    _i3.DaySchedule daySchedule, {
    _i1.Transaction? transaction,
  }) async {
    if (daySchedule.id == null) {
      throw ArgumentError.notNull('daySchedule.id');
    }
    if (weekSchedule.id == null) {
      throw ArgumentError.notNull('weekSchedule.id');
    }

    var $daySchedule = daySchedule.copyWith(weekScheduleId: weekSchedule.id);
    await session.db.updateRow<_i3.DaySchedule>(
      $daySchedule,
      columns: [_i3.DaySchedule.t.weekScheduleId],
      transaction: transaction,
    );
  }
}

class WeekScheduleDetachRepository {
  const WeekScheduleDetachRepository._();

  /// Detaches the relation between this [WeekSchedule] and the given [DaySchedule]
  /// by setting the [DaySchedule]'s foreign key `weekScheduleId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> days(
    _i1.Session session,
    List<_i3.DaySchedule> daySchedule, {
    _i1.Transaction? transaction,
  }) async {
    if (daySchedule.any((e) => e.id == null)) {
      throw ArgumentError.notNull('daySchedule.id');
    }

    var $daySchedule = daySchedule
        .map((e) => e.copyWith(weekScheduleId: null))
        .toList();
    await session.db.update<_i3.DaySchedule>(
      $daySchedule,
      columns: [_i3.DaySchedule.t.weekScheduleId],
      transaction: transaction,
    );
  }
}

class WeekScheduleDetachRowRepository {
  const WeekScheduleDetachRowRepository._();

  /// Detaches the relation between this [WeekSchedule] and the [Progress] set in `progress`
  /// by setting the [WeekSchedule]'s foreign key `progressId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> progress(
    _i1.Session session,
    WeekSchedule weekSchedule, {
    _i1.Transaction? transaction,
  }) async {
    if (weekSchedule.id == null) {
      throw ArgumentError.notNull('weekSchedule.id');
    }

    var $weekSchedule = weekSchedule.copyWith(progressId: null);
    await session.db.updateRow<WeekSchedule>(
      $weekSchedule,
      columns: [WeekSchedule.t.progressId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [WeekSchedule] and the given [DaySchedule]
  /// by setting the [DaySchedule]'s foreign key `weekScheduleId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> days(
    _i1.Session session,
    _i3.DaySchedule daySchedule, {
    _i1.Transaction? transaction,
  }) async {
    if (daySchedule.id == null) {
      throw ArgumentError.notNull('daySchedule.id');
    }

    var $daySchedule = daySchedule.copyWith(weekScheduleId: null);
    await session.db.updateRow<_i3.DaySchedule>(
      $daySchedule,
      columns: [_i3.DaySchedule.t.weekScheduleId],
      transaction: transaction,
    );
  }
}
