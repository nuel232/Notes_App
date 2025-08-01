import 'package:flutter/material.dart';
import 'package:note_app/models/note_database.dart';
import 'package:note_app/pages/notes_page.dart';
import 'package:note_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  //initialize note isar database
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();

  runApp(
    MultiProvider(
      providers: [
        //Note Provider
        ChangeNotifierProvider(create: (context) => NoteDatabase()),

        //theme Provider
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotesPage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
