  import 'dart:io';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:firebase_database/firebase_database.dart';
  import 'package:flutter/foundation.dart';
  import 'package:sqflite/sqflite.dart' as sql;
  import 'package:final_project/pages/profile_page.dart';

  class DatabaseHelper {


    static Future<sql.Database> db() async {
      return sql.openDatabase(
        'users.db',
        version: 1,
        onCreate: (sql.Database database, int version) async {
          await createTables(database);
        },
      );
    }

    static Future<void> createTables(sql.Database database) async {
      await database.execute('''CREATE TABLE users(
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          Name TEXT,
          Email TEXT,
          Phone TEXT,
          Cartype TEXT,
          
          createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        )
        ''');
    }

    static Future<int> createItem(String? Name, String? Email, String? Phone, String? Cartype) async {
      final db = await DatabaseHelper.db();

      final data = {'Name': Name, 'Email': Email, 'Phone': Phone, 'Cartype': Cartype };
      final id = await db.insert('users', data.cast<String, Object?>(),
          conflictAlgorithm: sql.ConflictAlgorithm.replace);
      return id;

    }

    static Future<List<Map<String, dynamic>>> getItems() async {
      final db = await DatabaseHelper.db();
      return db.query('users', orderBy: "id");
    }

    static Future<List<Map<String, dynamic>>> getUser(String email) async {
      final db = await DatabaseHelper.db();
      return db.query('users', where: "Email = ?", whereArgs: [email], limit: 1);
    }

    static Future<int> updateUser(
        String Name, String Email, String? Phone, String? Cartype) async {
      final db = await DatabaseHelper.db();

      final data = {
        'Name': Name,
        'Email': Email,
        'Phone': Phone,
        'Cartype':Cartype,

        'createdAt': DateTime.now().toString()
      };

      final result =
      await db.update('users', data, where: "Email = ?", whereArgs: [Email]);
      return result;
    }

    static Future<void> deleteItem(int id) async {
      final db = await DatabaseHelper.db();
      try {
        await db.delete("users", where: "id = ?", whereArgs: [id]);
      } catch (err) {
        debugPrint("Something went wrong when deleting a user: $err");
      }
    }

  }