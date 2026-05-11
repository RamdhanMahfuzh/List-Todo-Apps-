import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapps/models/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial(const [])) {
    on<OnAddTodo>((event, emit) async {
      emit(TodoLoading(state.todos));
      await Future.delayed(Duration(milliseconds: 1500));
      Todo newTodo = event.newTodo;
      emit(TodoAdded([...state.todos, newTodo]));
    });

    on<OnUpdateTodo>((event, emit) async {
      emit(TodoLoading(state.todos));
      await Future.delayed(Duration(milliseconds: 1500));
      Todo newTodo = event.newTodo;
      int index = event.index;
      List<Todo> todosUpdate = state.todos;
      todosUpdate[index] = newTodo;
      emit(TodoUpdated(todosUpdate));
    });

    on<OnRemoveTodo>((event, emit) async {
      emit(TodoLoading(state.todos));
      await Future.delayed(Duration(milliseconds: 1500));
      int index = event.index;
      List<Todo> todosRemoved = state.todos;
      todosRemoved.removeAt(index);
      emit(TodoRemoved(todosRemoved));
    });
  }
}
