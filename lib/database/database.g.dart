// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Drink extends DataClass implements Insertable<Drink> {
  final int? id;
  final String noOfDrinks;
  final DateTime date;
  Drink({this.id, required this.noOfDrinks, required this.date});
  factory Drink.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Drink(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      noOfDrinks: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}no_of_drinks'])!,
      date: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int?>(id);
    }
    map['no_of_drinks'] = Variable<String>(noOfDrinks);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  DrinksCompanion toCompanion(bool nullToAbsent) {
    return DrinksCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      noOfDrinks: Value(noOfDrinks),
      date: Value(date),
    );
  }

  factory Drink.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Drink(
      id: serializer.fromJson<int?>(json['id']),
      noOfDrinks: serializer.fromJson<String>(json['noOfDrinks']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'noOfDrinks': serializer.toJson<String>(noOfDrinks),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  Drink copyWith({int? id, String? noOfDrinks, DateTime? date}) => Drink(
        id: id ?? this.id,
        noOfDrinks: noOfDrinks ?? this.noOfDrinks,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('Drink(')
          ..write('id: $id, ')
          ..write('noOfDrinks: $noOfDrinks, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, noOfDrinks, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Drink &&
          other.id == this.id &&
          other.noOfDrinks == this.noOfDrinks &&
          other.date == this.date);
}

class DrinksCompanion extends UpdateCompanion<Drink> {
  final Value<int?> id;
  final Value<String> noOfDrinks;
  final Value<DateTime> date;
  const DrinksCompanion({
    this.id = const Value.absent(),
    this.noOfDrinks = const Value.absent(),
    this.date = const Value.absent(),
  });
  DrinksCompanion.insert({
    this.id = const Value.absent(),
    this.noOfDrinks = const Value.absent(),
    this.date = const Value.absent(),
  });
  static Insertable<Drink> custom({
    Expression<int?>? id,
    Expression<String>? noOfDrinks,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (noOfDrinks != null) 'no_of_drinks': noOfDrinks,
      if (date != null) 'date': date,
    });
  }

  DrinksCompanion copyWith(
      {Value<int?>? id, Value<String>? noOfDrinks, Value<DateTime>? date}) {
    return DrinksCompanion(
      id: id ?? this.id,
      noOfDrinks: noOfDrinks ?? this.noOfDrinks,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int?>(id.value);
    }
    if (noOfDrinks.present) {
      map['no_of_drinks'] = Variable<String>(noOfDrinks.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DrinksCompanion(')
          ..write('id: $id, ')
          ..write('noOfDrinks: $noOfDrinks, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $DrinksTable extends Drinks with TableInfo<$DrinksTable, Drink> {
  final GeneratedDatabase _db;
  final String? _alias;
  $DrinksTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _noOfDrinksMeta = const VerificationMeta('noOfDrinks');
  @override
  late final GeneratedColumn<String?> noOfDrinks = GeneratedColumn<String?>(
      'no_of_drinks', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant('0'));
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime?> date = GeneratedColumn<DateTime?>(
      'date', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  @override
  List<GeneratedColumn> get $columns => [id, noOfDrinks, date];
  @override
  String get aliasedName => _alias ?? 'drinks';
  @override
  String get actualTableName => 'drinks';
  @override
  VerificationContext validateIntegrity(Insertable<Drink> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('no_of_drinks')) {
      context.handle(
          _noOfDrinksMeta,
          noOfDrinks.isAcceptableOrUnknown(
              data['no_of_drinks']!, _noOfDrinksMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Drink map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Drink.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $DrinksTable createAlias(String alias) {
    return $DrinksTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $DrinksTable drinks = $DrinksTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [drinks];
}
