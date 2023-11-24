import 'package:floor/floor.dart';
import 'package:todo_homework/modal/todo_modal.dart';

@dao
abstract class ToDoDao{
  @Query("SELECT * FROM ToDoModal") Future<List<ToDoModal>> selectedInfor();

  @Query("SELECT * FROM ToDoModal") Stream<List<ToDoModal>> selectedInforByStream();

  @insert
  Future<void>insertInfor(ToDoModal toDoModal);

  @delete
  Future<void> deleteInfor(ToDoModal toDoModal);

  @update
  Future<void> updateInfor(ToDoModal toDoModal);

}