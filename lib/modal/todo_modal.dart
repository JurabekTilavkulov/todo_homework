import 'package:floor/floor.dart';

@entity
class ToDoModal{
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String textAny;
  final String status;
  final String dataTime;
 // { }-- that, it is not be required
  ToDoModal( this.textAny, this.status, this.dataTime,{this.id});
}