part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

class OnAddTodo extends TodoEvent {
  final Todo newTodo;
  OnAddTodo(this.newTodo);
}

class OnRemoveTodo extends TodoEvent {
  final int index;
  OnRemoveTodo(this.index);
}

class OnUpdateTodo extends TodoEvent {
  final Todo newTodo;
  final int index;
  OnUpdateTodo(this.newTodo, this.index);
}
