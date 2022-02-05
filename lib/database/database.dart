import 'package:moor_flutter/moor_flutter.dart';

part 'database.g.dart';

class Drinks extends Table{
  IntColumn get id => integer().autoIncrement().nullable()();
  TextColumn get noOfDrinks => text().withDefault(const Constant('0'))();
  DateTimeColumn get date => dateTime().withDefault(Constant(DateTime.now()))();

  @override
  Set<Column> get primaryKey => {id};
}

@UseMoor(tables: [Drinks])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super((FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true)));

  @override
  int get schemaVersion => 1;

  Future<List<Drink>> getAllDrinks() => select(drinks).get();

  Future<int> insertDrink(Drink drink) => into(drinks).insert(drink);

  Future<int> deleteDrink(Drink drink) => delete(drinks).delete(drink);

}
