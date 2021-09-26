
import 'package:flutter_app/repsitory.dart';

import 'note.dart';

class TodoService{
   final  Repository _repository=Repository();


   saveTodo(Todo todo) async{
     return await _repository.insertData('todos', todo.todoMap());

   }

    readTodos() async{
     return await _repository.readData('todos');
    }
}