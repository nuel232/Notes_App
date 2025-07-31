import 'package:flutter/material.dart';
import 'package:note_app/models/note_database.dart';
import 'package:note_app/pages/notes_page.dart';
import 'package:provider/provider.dart';

void main() async {
  //initialize note isar database
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();

  runApp(
    ChangeNotifierProvider(
      create: (context) => NoteDatabase(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotesPage(),
    );
  }
}
