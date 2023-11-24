import '../app_database/app_databaseFirst.dart';
import '../modal/todo_modal.dart';

class ToDoService{

  static final ToDoService _toDoService=ToDoService._service();

  factory ToDoService(){
    return _toDoService;
  }

  ToDoService._service();

  late AppDatabase _appDatabase;

  Future initialDataBase()async{  // yaratish dayaBase
    _appDatabase=await $FloorAppDatabase.databaseBuilder('app_databaseFirst.db').build();
  }

  Future<List<ToDoModal>> findAllInformation() async{
    return await _appDatabase.toDoDao.selectedInfor();
  }

  Stream<List<ToDoModal>> findAllInforByStream()async*{
    yield*_appDatabase.toDoDao.selectedInforByStream();
  }

  Future<void> insertInformation(ToDoModal toDoModal)async{
    return await _appDatabase.toDoDao.insertInfor(toDoModal);
  }

  Future<void> deleteInformation(ToDoModal toDoModal)async{
    return await _appDatabase.toDoDao.deleteInfor(toDoModal);
  }

  Future<void> updateInformation(ToDoModal toDoModal)async{
    return await _appDatabase.toDoDao.updateInfor(toDoModal);
  }
}