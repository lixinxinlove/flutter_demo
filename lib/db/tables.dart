import 'package:drift/drift.dart';

class TodoItem extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(min: 6, max: 32)();

  TextColumn get content => text().named('body')();

  IntColumn get category =>
      integer().nullable().references(TodoCategory, #id)();

  DateTimeColumn get createdAt => dateTime().nullable()();
}

class TodoCategory extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get description => text()();
}

class User extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get uid => integer()();

  TextColumn get name => text()();

  IntColumn get sex => integer()();
}
