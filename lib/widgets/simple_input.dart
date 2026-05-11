import 'package:d_input/d_input.dart';
import 'package:flutter/material.dart';

class SimpleInput extends StatelessWidget {
  const SimpleInput({
    super.key,
    required this.edtTitle,
    required this.edtDescription,
    required this.onTap,
    required this.actionTitle,
  });
  final TextEditingController edtTitle;
  final TextEditingController edtDescription;
  final VoidCallback onTap;
  final String actionTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          DInput(
            titleSpec: TitleSpec(text: 'Title'),
            inputSpec: InputSpec(controller: edtTitle),
          ),
          const SizedBox(height: 16),
          DInput(
            titleSpec: TitleSpec(text: 'Description'),
            inputSpec: InputSpec(controller: edtDescription),
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: onTap, child: Text(actionTitle)),
        ],
      ),
    );
  }
}
