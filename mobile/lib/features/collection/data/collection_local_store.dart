import 'dart:convert';

import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import '../domain/collection_models.dart';

/// sqflite mirror of the user's collection for offline reads.
/// The API is the source of truth: every successful fetch overwrites this copy.
class CollectionLocalStore {
  CollectionLocalStore._(this._db);

  final Database _db;

  static Future<CollectionLocalStore> open() async {
    final path = p.join(await getDatabasesPath(), 'collection_cache.db');
    final db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, _) => db.execute('''
        CREATE TABLE collection_items (
          id INTEGER PRIMARY KEY,
          payload TEXT NOT NULL
        )
      '''),
    );
    return CollectionLocalStore._(db);
  }

  Future<void> replaceAll(List<CollectionItem> items) async {
    await _db.transaction((txn) async {
      await txn.delete('collection_items');
      for (final item in items) {
        await txn.insert('collection_items', {
          'id': item.id,
          'payload': jsonEncode(item.toJson()),
        });
      }
    });
  }

  Future<List<CollectionItem>> readAll() async {
    final rows = await _db.query('collection_items', orderBy: 'id DESC');
    return rows
        .map((r) =>
            CollectionItem.fromJson(jsonDecode(r['payload'] as String) as Map<String, dynamic>))
        .toList();
  }
}
