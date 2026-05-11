import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapps/bloc/todo_bloc.dart';
import 'package:todoapps/pages/todo_pages.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TodoPage(),
      ),
    );
  }
}
