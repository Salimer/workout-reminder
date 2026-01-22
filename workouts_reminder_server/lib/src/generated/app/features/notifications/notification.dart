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
import '../../../app/features/day_schedules/day_schedule.dart' as _i2;
import 'package:workouts_reminder_server/src/generated/protocol.dart' as _i3;

abstract class Notification
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Notification._({
    this.id,
    this.dayScheduleId,
    this.daySchedule,
    required this.title,
    required this.body,
    required this.scheduledDate,
    required this.payload,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Notification({
    int? id,
    int? dayScheduleId,
    _i2.DaySchedule? daySchedule,
    required String title,
    required String body,
    required DateTime scheduledDate,
    required String payload,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _NotificationImpl;

  factory Notification.fromJson(Map<String, dynamic> jsonSerialization) {
    return Notification(
      id: jsonSerialization['id'] as int?,
      dayScheduleId: jsonSerialization['dayScheduleId'] as int?,
      daySchedule: jsonSerialization['daySchedule'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.DaySchedule>(
              jsonSerialization['daySchedule'],
            ),
      title: jsonSerialization['title'] as String,
      body: jsonSerialization['body'] as String,
      scheduledDate: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['scheduledDate'],
      ),
      payload: jsonSerialization['payload'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = NotificationTable();

  static const db = NotificationRepository._();

  @override
  int? id;

  int? dayScheduleId;

  _i2.DaySchedule? daySchedule;

  String title;

  String body;

  DateTime scheduledDate;

  String payload;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Notification]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Notification copyWith({
    int? id,
    int? dayScheduleId,
    _i2.DaySchedule? daySchedule,
    String? title,
    String? body,
    DateTime? scheduledDate,
    String? payload,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Notification',
      if (id != null) 'id': id,
      if (dayScheduleId != null) 'dayScheduleId': dayScheduleId,
      if (daySchedule != null) 'daySchedule': daySchedule?.toJson(),
      'title': title,
      'body': body,
      'scheduledDate': scheduledDate.toJson(),
      'payload': payload,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Notification',
      if (id != null) 'id': id,
      if (dayScheduleId != null) 'dayScheduleId': dayScheduleId,
      if (daySchedule != null) 'daySchedule': daySchedule?.toJsonForProtocol(),
      'title': title,
      'body': body,
      'scheduledDate': scheduledDate.toJson(),
      'payload': payload,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static NotificationInclude include({_i2.DayScheduleInclude? daySchedule}) {
    return NotificationInclude._(daySchedule: daySchedule);
  }

  static NotificationIncludeList includeList({
    _i1.WhereExpressionBuilder<NotificationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<NotificationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<NotificationTable>? orderByList,
    NotificationInclude? include,
  }) {
    return NotificationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Notification.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Notification.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _NotificationImpl extends Notification {
  _NotificationImpl({
    int? id,
    int? dayScheduleId,
    _i2.DaySchedule? daySchedule,
    required String title,
    required String body,
    required DateTime scheduledDate,
    required String payload,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         dayScheduleId: dayScheduleId,
         daySchedule: daySchedule,
         title: title,
         body: body,
         scheduledDate: scheduledDate,
         payload: payload,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Notification]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Notification copyWith({
    Object? id = _Undefined,
    Object? dayScheduleId = _Undefined,
    Object? daySchedule = _Undefined,
    String? title,
    String? body,
    DateTime? scheduledDate,
    String? payload,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Notification(
      id: id is int? ? id : this.id,
      dayScheduleId: dayScheduleId is int? ? dayScheduleId : this.dayScheduleId,
      daySchedule: daySchedule is _i2.DaySchedule?
          ? daySchedule
          : this.daySchedule?.copyWith(),
      title: title ?? this.title,
      body: body ?? this.body,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      payload: payload ?? this.payload,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class NotificationUpdateTable extends _i1.UpdateTable<NotificationTable> {
  NotificationUpdateTable(super.table);

  _i1.ColumnValue<int, int> dayScheduleId(int? value) => _i1.ColumnValue(
    table.dayScheduleId,
    value,
  );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> body(String value) => _i1.ColumnValue(
    table.body,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> scheduledDate(DateTime value) =>
      _i1.ColumnValue(
        table.scheduledDate,
        value,
      );

  _i1.ColumnValue<String, String> payload(String value) => _i1.ColumnValue(
    table.payload,
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

class NotificationTable extends _i1.Table<int?> {
  NotificationTable({super.tableRelation}) : super(tableName: 'notification') {
    updateTable = NotificationUpdateTable(this);
    dayScheduleId = _i1.ColumnInt(
      'dayScheduleId',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    body = _i1.ColumnString(
      'body',
      this,
    );
    scheduledDate = _i1.ColumnDateTime(
      'scheduledDate',
      this,
    );
    payload = _i1.ColumnString(
      'payload',
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

  late final NotificationUpdateTable updateTable;

  late final _i1.ColumnInt dayScheduleId;

  _i2.DayScheduleTable? _daySchedule;

  late final _i1.ColumnString title;

  late final _i1.ColumnString body;

  late final _i1.ColumnDateTime scheduledDate;

  late final _i1.ColumnString payload;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  _i2.DayScheduleTable get daySchedule {
    if (_daySchedule != null) return _daySchedule!;
    _daySchedule = _i1.createRelationTable(
      relationFieldName: 'daySchedule',
      field: Notification.t.dayScheduleId,
      foreignField: _i2.DaySchedule.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.DayScheduleTable(tableRelation: foreignTableRelation),
    );
    return _daySchedule!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    dayScheduleId,
    title,
    body,
    scheduledDate,
    payload,
    createdAt,
    updatedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'daySchedule') {
      return daySchedule;
    }
    return null;
  }
}

class NotificationInclude extends _i1.IncludeObject {
  NotificationInclude._({_i2.DayScheduleInclude? daySchedule}) {
    _daySchedule = daySchedule;
  }

  _i2.DayScheduleInclude? _daySchedule;

  @override
  Map<String, _i1.Include?> get includes => {'daySchedule': _daySchedule};

  @override
  _i1.Table<int?> get table => Notification.t;
}

class NotificationIncludeList extends _i1.IncludeList {
  NotificationIncludeList._({
    _i1.WhereExpressionBuilder<NotificationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Notification.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Notification.t;
}

class NotificationRepository {
  const NotificationRepository._();

  final attachRow = const NotificationAttachRowRepository._();

  final detachRow = const NotificationDetachRowRepository._();

  /// Returns a list of [Notification]s matching the given query parameters.
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
  Future<List<Notification>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<NotificationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<NotificationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<NotificationTable>? orderByList,
    _i1.Transaction? transaction,
    NotificationInclude? include,
  }) async {
    return session.db.find<Notification>(
      where: where?.call(Notification.t),
      orderBy: orderBy?.call(Notification.t),
      orderByList: orderByList?.call(Notification.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [Notification] matching the given query parameters.
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
  Future<Notification?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<NotificationTable>? where,
    int? offset,
    _i1.OrderByBuilder<NotificationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<NotificationTable>? orderByList,
    _i1.Transaction? transaction,
    NotificationInclude? include,
  }) async {
    return session.db.findFirstRow<Notification>(
      where: where?.call(Notification.t),
      orderBy: orderBy?.call(Notification.t),
      orderByList: orderByList?.call(Notification.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [Notification] by its [id] or null if no such row exists.
  Future<Notification?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    NotificationInclude? include,
  }) async {
    return session.db.findById<Notification>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [Notification]s in the list and returns the inserted rows.
  ///
  /// The returned [Notification]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Notification>> insert(
    _i1.Session session,
    List<Notification> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Notification>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Notification] and returns the inserted row.
  ///
  /// The returned [Notification] will have its `id` field set.
  Future<Notification> insertRow(
    _i1.Session session,
    Notification row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Notification>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Notification]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Notification>> update(
    _i1.Session session,
    List<Notification> rows, {
    _i1.ColumnSelections<NotificationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Notification>(
      rows,
      columns: columns?.call(Notification.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Notification]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Notification> updateRow(
    _i1.Session session,
    Notification row, {
    _i1.ColumnSelections<NotificationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Notification>(
      row,
      columns: columns?.call(Notification.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Notification] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Notification?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<NotificationUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Notification>(
      id,
      columnValues: columnValues(Notification.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Notification]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Notification>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<NotificationUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<NotificationTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<NotificationTable>? orderBy,
    _i1.OrderByListBuilder<NotificationTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Notification>(
      columnValues: columnValues(Notification.t.updateTable),
      where: where(Notification.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Notification.t),
      orderByList: orderByList?.call(Notification.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Notification]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Notification>> delete(
    _i1.Session session,
    List<Notification> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Notification>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Notification].
  Future<Notification> deleteRow(
    _i1.Session session,
    Notification row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Notification>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Notification>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<NotificationTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Notification>(
      where: where(Notification.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<NotificationTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Notification>(
      where: where?.call(Notification.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class NotificationAttachRowRepository {
  const NotificationAttachRowRepository._();

  /// Creates a relation between the given [Notification] and [DaySchedule]
  /// by setting the [Notification]'s foreign key `dayScheduleId` to refer to the [DaySchedule].
  Future<void> daySchedule(
    _i1.Session session,
    Notification notification,
    _i2.DaySchedule daySchedule, {
    _i1.Transaction? transaction,
  }) async {
    if (notification.id == null) {
      throw ArgumentError.notNull('notification.id');
    }
    if (daySchedule.id == null) {
      throw ArgumentError.notNull('daySchedule.id');
    }

    var $notification = notification.copyWith(dayScheduleId: daySchedule.id);
    await session.db.updateRow<Notification>(
      $notification,
      columns: [Notification.t.dayScheduleId],
      transaction: transaction,
    );
  }
}

class NotificationDetachRowRepository {
  const NotificationDetachRowRepository._();

  /// Detaches the relation between this [Notification] and the [DaySchedule] set in `daySchedule`
  /// by setting the [Notification]'s foreign key `dayScheduleId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> daySchedule(
    _i1.Session session,
    Notification notification, {
    _i1.Transaction? transaction,
  }) async {
    if (notification.id == null) {
      throw ArgumentError.notNull('notification.id');
    }

    var $notification = notification.copyWith(dayScheduleId: null);
    await session.db.updateRow<Notification>(
      $notification,
      columns: [Notification.t.dayScheduleId],
      transaction: transaction,
    );
  }
}
