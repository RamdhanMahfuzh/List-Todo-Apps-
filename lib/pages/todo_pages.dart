import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapps/bloc/todo_bloc.dart';
import 'package:todoapps/design/color_style.dart';
import 'package:todoapps/design/font_style.dart';
import 'package:todoapps/models/todo.dart';
import 'package:todoapps/widgets/simple_input.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  addTodo() {
    final edtTitle = TextEditingController();
    final edtDescription = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: [
            SimpleInput(
              edtTitle: edtTitle,
              edtDescription: edtDescription,
              onTap: () {
                Todo newTodo = Todo(
                  title: edtTitle.text,
                  description: edtDescription.text,
                );
                context.read<TodoBloc>().add(OnAddTodo(newTodo));
                Navigator.pop(context);
                DInfo.snackBarSuccess(context, 'Todo Added');
              },
              actionTitle: 'Add Todo',
            ),
          ],
        );
      },
    );
  }

  updateTodo(int index) {
    final edtTitle = TextEditingController();
    final edtDescription = TextEditingController();

    // ambil todo lama
    Todo todo = context.read<TodoBloc>().state.todos[index];

    // isi controller dengan data lama
    edtTitle.text = todo.title;
    edtDescription.text = todo.description;

    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: [
            SimpleInput(
              edtTitle: edtTitle,
              edtDescription: edtDescription,
              onTap: () {
                Todo newTodo = Todo(
                  title: edtTitle.text,
                  description: edtDescription.text,
                );
                context.read<TodoBloc>().add(OnUpdateTodo(newTodo, index));
                Navigator.pop(context);
                DInfo.snackBarSuccess(context, 'Todo Updated');
              },
              actionTitle: 'Update Todo',
            ),
          ],
        );
      },
    );
  }

  removeTodo(int index) {
    DInfo.dialogConfirmation(
      context,
      'Remove Todo',
      'Are you sure want to delete?',
    ).then((bool? yes) {
      if (yes ?? false) {
        context.read<TodoBloc>().add(OnRemoveTodo(index));
        DInfo.snackBarSuccess(context, 'Todo has been delete');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo Apps"),
        titleTextStyle: appbarTextStyle,
        backgroundColor: Blue,
      ),
      body: SafeArea(
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state is TodoInitial) return const SizedBox.shrink();
            if (state is TodoLoading)
              return const Center(child: CircularProgressIndicator());
            SizedBox.shrink();
            List<Todo> list = state.todos;
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                Todo todo = list[index];
                return ListTile(
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text(todo.title, style: titleTextStyle),
                  subtitle: Text(todo.description, style: descriptionTextStyle),
                  trailing: PopupMenuButton(
                    onSelected: (value) {
                      switch (value) {
                        case 'Update':
                          updateTodo(index);
                          break;

                        case 'Delete':
                          removeTodo(index);
                          break;

                        default:
                          DInfo.snackBarError(context, 'Invalid menu');
                          break;
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'Update',
                        child: Text('Update'),
                      ),
                      const PopupMenuItem(
                        value: 'Delete',
                        child: Text('Delete'),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Blue,
        child: Icon(Icons.add, color: White),
        onPressed: addTodo,
      ),
    );
  }
}
