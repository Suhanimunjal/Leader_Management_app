import 'package:internship_project/models/leaders.dart';
import 'package:internship_project/services/db_helper.dart';

class LeaderRepository {
  Future<List<Leaders>> getAll() async {
    final db = await DBHelper.database;
    final rows = await db.query('leaders', orderBy: 'id DESC');
    return rows.map((r) => Leaders.fromMap(r)).toList();
  }

  Future<int> insert(Leaders leader) async {
    final db = await DBHelper.database;
    final id = await db.insert('leaders', leader.toMap());
    return id;
  }

  Future<int> update(Leaders leader) async {
    final db = await DBHelper.database;
    return await db.update(
      'leaders',
      leader.toMap(),
      where: 'id = ?',
      whereArgs: [leader.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await DBHelper.database;
    return await db.delete('leaders', where: 'id = ?', whereArgs: [id]);
  }
}
