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
import '../../../app/core/enums/weekday_enum.dart' as _i2;
import '../../../app/features/notifications/notification.dart' as _i3;
import '../../../app/core/enums/day_workout_status_enum.dart' as _i4;
import 'package:workouts_reminder_server/src/generated/protocol.dart' as _i5;

abstract class DaySchedule
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DaySchedule._({
    this.id,
    required this.day,
    this.notifications,
    required this.status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now(),
       _weekScheduleDaysWeekScheduleId = null;

  factory DaySchedule({
    int? id,
    required _i2.WeekdayEnum day,
    List<_i3.Notification>? notifications,
    required _i4.DayWorkoutStatusEnum status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _DayScheduleImpl;

  factory DaySchedule.fromJson(Map<String, dynamic> jsonSerialization) {
    return DayScheduleImplicit._(
      id: jsonSerialization['id'] as int?,
      day: _i2.WeekdayEnum.fromJson((jsonSerialization['day'] as String)),
      notifications: jsonSerialization['notifications'] == null
          ? null
          : _i5.Protocol().deserialize<List<_i3.Notification>>(
              jsonSerialization['notifications'],
            ),
      status: _i4.DayWorkoutStatusEnum.fromJson(
        (jsonSerialization['status'] as String),
      ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      $_weekScheduleDaysWeekScheduleId:
          jsonSerialization['_weekScheduleDaysWeekScheduleId'] as int?,
    );
  }

  static final t = DayScheduleTable();

  static const db = DayScheduleRepository._();

  @override
  int? id;

  _i2.WeekdayEnum day;

  List<_i3.Notification>? notifications;

  _i4.DayWorkoutStatusEnum status;

  DateTime createdAt;

  DateTime updatedAt;

  final int? _weekScheduleDaysWeekScheduleId;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DaySchedule]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DaySchedule copyWith({
    int? id,
    _i2.WeekdayEnum? day,
    List<_i3.Notification>? notifications,
    _i4.DayWorkoutStatusEnum? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DaySchedule',
      if (id != null) 'id': id,
      'day': day.toJson(),
      if (notifications != null)
        'notifications': notifications?.toJson(valueToJson: (v) => v.toJson()),
      'status': status.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (_weekScheduleDaysWeekScheduleId != null)
        '_weekScheduleDaysWeekScheduleId': _weekScheduleDaysWeekScheduleId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DaySchedule',
      if (id != null) 'id': id,
      'day': day.toJson(),
      if (notifications != null)
        'notifications': notifications?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      'status': status.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static DayScheduleInclude include({
    _i3.NotificationIncludeList? notifications,
  }) {
    return DayScheduleInclude._(notifications: notifications);
  }

  static DayScheduleIncludeList includeList({
    _i1.WhereExpressionBuilder<DayScheduleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DayScheduleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DayScheduleTable>? orderByList,
    DayScheduleInclude? include,
  }) {
    return DayScheduleIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DaySchedule.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DaySchedule.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DayScheduleImpl extends DaySchedule {
  _DayScheduleImpl({
    int? id,
    required _i2.WeekdayEnum day,
    List<_i3.Notification>? notifications,
    required _i4.DayWorkoutStatusEnum status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         day: day,
         notifications: notifications,
         status: status,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [DaySchedule]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DaySchedule copyWith({
    Object? id = _Undefined,
    _i2.WeekdayEnum? day,
    Object? notifications = _Undefined,
    _i4.DayWorkoutStatusEnum? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DayScheduleImplicit._(
      id: id is int? ? id : this.id,
      day: day ?? this.day,
      notifications: notifications is List<_i3.Notification>?
          ? notifications
          : this.notifications?.map((e0) => e0.copyWith()).toList(),
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      $_weekScheduleDaysWeekScheduleId: this._weekScheduleDaysWeekScheduleId,
    );
  }
}

class DayScheduleImplicit extends _DayScheduleImpl {
  DayScheduleImplicit._({
    int? id,
    required _i2.WeekdayEnum day,
    List<_i3.Notification>? notifications,
    required _i4.DayWorkoutStatusEnum status,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? $_weekScheduleDaysWeekScheduleId,
  }) : _weekScheduleDaysWeekScheduleId = $_weekScheduleDaysWeekScheduleId,
       super(
         id: id,
         day: day,
         notifications: notifications,
         status: status,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  factory DayScheduleImplicit(
    DaySchedule daySchedule, {
    int? $_weekScheduleDaysWeekScheduleId,
  }) {
    return DayScheduleImplicit._(
      id: daySchedule.id,
      day: daySchedule.day,
      notifications: daySchedule.notifications,
      status: daySchedule.status,
      createdAt: daySchedule.createdAt,
      updatedAt: daySchedule.updatedAt,
      $_weekScheduleDaysWeekScheduleId: $_weekScheduleDaysWeekScheduleId,
    );
  }

  @override
  final int? _weekScheduleDaysWeekScheduleId;
}

class DayScheduleUpdateTable extends _i1.UpdateTable<DayScheduleTable> {
  DayScheduleUpdateTable(super.table);

  _i1.ColumnValue<_i2.WeekdayEnum, _i2.WeekdayEnum> day(
    _i2.WeekdayEnum value,
  ) => _i1.ColumnValue(
    table.day,
    value,
  );

  _i1.ColumnValue<_i4.DayWorkoutStatusEnum, _i4.DayWorkoutStatusEnum> status(
    _i4.DayWorkoutStatusEnum value,
  ) => _i1.ColumnValue(
    table.status,
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

  _i1.ColumnValue<int, int> $_weekScheduleDaysWeekScheduleId(int? value) =>
      _i1.ColumnValue(
        table.$_weekScheduleDaysWeekScheduleId,
        value,
      );
}

class DayScheduleTable extends _i1.Table<int?> {
  DayScheduleTable({super.tableRelation}) : super(tableName: 'day_schedule') {
    updateTable = DayScheduleUpdateTable(this);
    day = _i1.ColumnEnum(
      'day',
      this,
      _i1.EnumSerialization.byName,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
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
    $_weekScheduleDaysWeekScheduleId = _i1.ColumnInt(
      '_weekScheduleDaysWeekScheduleId',
      this,
    );
  }

  late final DayScheduleUpdateTable updateTable;

  late final _i1.ColumnEnum<_i2.WeekdayEnum> day;

  _i3.NotificationTable? ___notifications;

  _i1.ManyRelation<_i3.NotificationTable>? _notifications;

  late final _i1.ColumnEnum<_i4.DayWorkoutStatusEnum> status;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnInt $_weekScheduleDaysWeekScheduleId;

  _i3.NotificationTable get __notifications {
    if (___notifications != null) return ___notifications!;
    ___notifications = _i1.createRelationTable(
      relationFieldName: '__notifications',
      field: DaySchedule.t.id,
      foreignField: _i3.Notification.t.$_dayScheduleNotificationsDayScheduleId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.NotificationTable(tableRelation: foreignTableRelation),
    );
    return ___notifications!;
  }

  _i1.ManyRelation<_i3.NotificationTable> get notifications {
    if (_notifications != null) return _notifications!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'notifications',
      field: DaySchedule.t.id,
      foreignField: _i3.Notification.t.$_dayScheduleNotificationsDayScheduleId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.NotificationTable(tableRelation: foreignTableRelation),
    );
    _notifications = _i1.ManyRelation<_i3.NotificationTable>(
      tableWithRelations: relationTable,
      table: _i3.NotificationTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _notifications!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    day,
    status,
    createdAt,
    updatedAt,
    $_weekScheduleDaysWeekScheduleId,
  ];

  @override
  List<_i1.Column> get managedColumns => [
    id,
    day,
    status,
    createdAt,
    updatedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'notifications') {
      return __notifications;
    }
    return null;
  }
}

class DayScheduleInclude extends _i1.IncludeObject {
  DayScheduleInclude._({_i3.NotificationIncludeList? notifications}) {
    _notifications = notifications;
  }

  _i3.NotificationIncludeList? _notifications;

  @override
  Map<String, _i1.Include?> get includes => {'notifications': _notifications};

  @override
  _i1.Table<int?> get table => DaySchedule.t;
}

class DayScheduleIncludeList extends _i1.IncludeList {
  DayScheduleIncludeList._({
    _i1.WhereExpressionBuilder<DayScheduleTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DaySchedule.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DaySchedule.t;
}

class DayScheduleRepository {
  const DayScheduleRepository._();

  final attach = const DayScheduleAttachRepository._();

  final attachRow = const DayScheduleAttachRowRepository._();

  final detach = const DayScheduleDetachRepository._();

  final detachRow = const DayScheduleDetachRowRepository._();

  /// Returns a list of [DaySchedule]s matching the given query parameters.
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
  Future<List<DaySchedule>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DayScheduleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DayScheduleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DayScheduleTable>? orderByList,
    _i1.Transaction? transaction,
    DayScheduleInclude? include,
  }) async {
    return session.db.find<DaySchedule>(
      where: where?.call(DaySchedule.t),
      orderBy: orderBy?.call(DaySchedule.t),
      orderByList: orderByList?.call(DaySchedule.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [DaySchedule] matching the given query parameters.
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
  Future<DaySchedule?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DayScheduleTable>? where,
    int? offset,
    _i1.OrderByBuilder<DayScheduleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DayScheduleTable>? orderByList,
    _i1.Transaction? transaction,
    DayScheduleInclude? include,
  }) async {
    return session.db.findFirstRow<DaySchedule>(
      where: where?.call(DaySchedule.t),
      orderBy: orderBy?.call(DaySchedule.t),
      orderByList: orderByList?.call(DaySchedule.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [DaySchedule] by its [id] or null if no such row exists.
  Future<DaySchedule?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    DayScheduleInclude? include,
  }) async {
    return session.db.findById<DaySchedule>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [DaySchedule]s in the list and returns the inserted rows.
  ///
  /// The returned [DaySchedule]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<DaySchedule>> insert(
    _i1.Session session,
    List<DaySchedule> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<DaySchedule>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [DaySchedule] and returns the inserted row.
  ///
  /// The returned [DaySchedule] will have its `id` field set.
  Future<DaySchedule> insertRow(
    _i1.Session session,
    DaySchedule row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DaySchedule>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DaySchedule]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DaySchedule>> update(
    _i1.Session session,
    List<DaySchedule> rows, {
    _i1.ColumnSelections<DayScheduleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DaySchedule>(
      rows,
      columns: columns?.call(DaySchedule.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DaySchedule]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DaySchedule> updateRow(
    _i1.Session session,
    DaySchedule row, {
    _i1.ColumnSelections<DayScheduleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DaySchedule>(
      row,
      columns: columns?.call(DaySchedule.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DaySchedule] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DaySchedule?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<DayScheduleUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DaySchedule>(
      id,
      columnValues: columnValues(DaySchedule.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DaySchedule]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DaySchedule>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<DayScheduleUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<DayScheduleTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DayScheduleTable>? orderBy,
    _i1.OrderByListBuilder<DayScheduleTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DaySchedule>(
      columnValues: columnValues(DaySchedule.t.updateTable),
      where: where(DaySchedule.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DaySchedule.t),
      orderByList: orderByList?.call(DaySchedule.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DaySchedule]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DaySchedule>> delete(
    _i1.Session session,
    List<DaySchedule> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DaySchedule>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DaySchedule].
  Future<DaySchedule> deleteRow(
    _i1.Session session,
    DaySchedule row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DaySchedule>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DaySchedule>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<DayScheduleTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DaySchedule>(
      where: where(DaySchedule.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DayScheduleTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DaySchedule>(
      where: where?.call(DaySchedule.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class DayScheduleAttachRepository {
  const DayScheduleAttachRepository._();

  /// Creates a relation between this [DaySchedule] and the given [Notification]s
  /// by setting each [Notification]'s foreign key `_dayScheduleNotificationsDayScheduleId` to refer to this [DaySchedule].
  Future<void> notifications(
    _i1.Session session,
    DaySchedule daySchedule,
    List<_i3.Notification> notification, {
    _i1.Transaction? transaction,
  }) async {
    if (notification.any((e) => e.id == null)) {
      throw ArgumentError.notNull('notification.id');
    }
    if (daySchedule.id == null) {
      throw ArgumentError.notNull('daySchedule.id');
    }

    var $notification = notification
        .map(
          (e) => _i3.NotificationImplicit(
            e,
            $_dayScheduleNotificationsDayScheduleId: daySchedule.id,
          ),
        )
        .toList();
    await session.db.update<_i3.Notification>(
      $notification,
      columns: [_i3.Notification.t.$_dayScheduleNotificationsDayScheduleId],
      transaction: transaction,
    );
  }
}

class DayScheduleAttachRowRepository {
  const DayScheduleAttachRowRepository._();

  /// Creates a relation between this [DaySchedule] and the given [Notification]
  /// by setting the [Notification]'s foreign key `_dayScheduleNotificationsDayScheduleId` to refer to this [DaySchedule].
  Future<void> notifications(
    _i1.Session session,
    DaySchedule daySchedule,
    _i3.Notification notification, {
    _i1.Transaction? transaction,
  }) async {
    if (notification.id == null) {
      throw ArgumentError.notNull('notification.id');
    }
    if (daySchedule.id == null) {
      throw ArgumentError.notNull('daySchedule.id');
    }

    var $notification = _i3.NotificationImplicit(
      notification,
      $_dayScheduleNotificationsDayScheduleId: daySchedule.id,
    );
    await session.db.updateRow<_i3.Notification>(
      $notification,
      columns: [_i3.Notification.t.$_dayScheduleNotificationsDayScheduleId],
      transaction: transaction,
    );
  }
}

class DayScheduleDetachRepository {
  const DayScheduleDetachRepository._();

  /// Detaches the relation between this [DaySchedule] and the given [Notification]
  /// by setting the [Notification]'s foreign key `_dayScheduleNotificationsDayScheduleId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> notifications(
    _i1.Session session,
    List<_i3.Notification> notification, {
    _i1.Transaction? transaction,
  }) async {
    if (notification.any((e) => e.id == null)) {
      throw ArgumentError.notNull('notification.id');
    }

    var $notification = notification
        .map(
          (e) => _i3.NotificationImplicit(
            e,
            $_dayScheduleNotificationsDayScheduleId: null,
          ),
        )
        .toList();
    await session.db.update<_i3.Notification>(
      $notification,
      columns: [_i3.Notification.t.$_dayScheduleNotificationsDayScheduleId],
      transaction: transaction,
    );
  }
}

class DayScheduleDetachRowRepository {
  const DayScheduleDetachRowRepository._();

  /// Detaches the relation between this [DaySchedule] and the given [Notification]
  /// by setting the [Notification]'s foreign key `_dayScheduleNotificationsDayScheduleId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> notifications(
    _i1.Session session,
    _i3.Notification notification, {
    _i1.Transaction? transaction,
  }) async {
    if (notification.id == null) {
      throw ArgumentError.notNull('notification.id');
    }

    var $notification = _i3.NotificationImplicit(
      notification,
      $_dayScheduleNotificationsDayScheduleId: null,
    );
    await session.db.updateRow<_i3.Notification>(
      $notification,
      columns: [_i3.Notification.t.$_dayScheduleNotificationsDayScheduleId],
      transaction: transaction,
    );
  }
}
