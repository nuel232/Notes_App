import 'package:flutter/material.dart';

class NoteSettings extends StatelessWidget {
  void Function()? onDeleteTap;
  void Function()? onEditTap;
  NoteSettings({super.key, required this.onDeleteTap, required this.onEditTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //edit option
        GestureDetector(
          onTap: () {
            Navigator.pop(context);

            onEditTap!();
          },
          child: Container(
            height: 50,
            color: Theme.of(context).colorScheme.surface,
            child: Center(
              child: Text(
                'Edit',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),

        //delete option
        GestureDetector(
          onTap: () {
            onDeleteTap!();

            Navigator.pop(context);
          },
          child: Container(
            height: 50,
            color: Theme.of(context).colorScheme.surface,
            child: Center(
              child: Text(
                'delete',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
