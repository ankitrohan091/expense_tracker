import 'package:expense_tracker/models/expense.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';

class SqlHelper {
  static Future<void> createTable(Database database) async {
    await database.execute(
        'CREATE TABLE expenses(id text primary key,title Text not null,amount FLOAT ,date TEXT,category TEXT)');
  }

  static Future<Database> openingDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'cricket_scorer.db');
    Database db = await openDatabase(
      path,
      version: 1,
      onCreate: ((db, version) {
        createTable(db);
      }),
    );
    return db;
  }

  static Future<void> removeExpense({required Expense expense}) async {
    Database db = await openingDatabase();
    await db.delete('expenses', where: 'id = ?', whereArgs: [expense.id]);
  }

  static Future<void> insetingNewExpense({required Expense expense}) async {
    String cat = expense.category.toString();
    final formatter = DateFormat('yyyy-MM-dd');
    String date = formatter.format(expense.date);
    Database db = await openingDatabase();
    await db.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO expenses(id,title,amount,date,category) VALUES (?,?,?,?,?)',
          [expense.id, expense.title, expense.amount, date, cat]);
    });
  }

  static Future<List<Map<String, dynamic>>> getId() async {
    Database db = await openingDatabase();
    List<Map<String, dynamic>> list =
        await db.query('expenses', columns: ['id']);
    return list;
  }

  static Future<List<Expense>> queringExpenses() async {
    Database db = await openingDatabase();
    List<Map<String, dynamic>> map =
        await db.rawQuery('SELECT * FROM expenses ORDER BY id');
    return List.generate(map.length, (index) {
      return Expense(
          id: map[index]['id'],
          title: map[index]['title'],
          amount: map[index]['amount'],
          category: Category.values.firstWhere((element) =>
              element.toString() == (map[index]['category']).trim()),
          date: DateTime.parse(map[index]['date']));
    });
  }
}
