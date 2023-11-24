import 'dart:async';

import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:floor/floor.dart';

import '../dao/todo_dao.dart';
import '../modal/todo_modal.dart';
part 'app_databaseFirst.g.dart';  // bu paketxam muxim

@Database(version: 1, entities: [ToDoModal])
abstract class AppDatabase extends FloorDatabase{
  ToDoDao get toDoDao;
}