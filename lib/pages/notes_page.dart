import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/models/note_database.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  //text controller to access what the user typed
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //on app startup we can fetch the existing note
    readNotes();
  }

  // create a note
  void createNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(controller: textController),
        actions: [
          //create button
          MaterialButton(
            onPressed: () {
              //add to db
              context.read<NoteDatabase>().addNote(textController.text);

              //clear controller
              textController.clear();
              //pop dialog box
              Navigator.pop(context);
            },
            child: Text('Create'),
          ),
        ],
      ),
    );
  }

  //R E A D
  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  //update a note
  void updateNote(Note note) {
    //pre-fill the current note text
    textController.text = note.text;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Note'),
        content: TextField(controller: textController),

        actions: [
          //update button
          MaterialButton(
            onPressed: () {
              //update note in db
              context.read<NoteDatabase>().updateNote(
                note.id,
                textController.text,
              );

              //clear controller
              textController.clear();

              //pop dialog box
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  //delete a note
  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    //note database
    final noteDatabase = context.watch<NoteDatabase>();

    //current notes
    List<Note> currentNotes = noteDatabase.currentNotes;
    return Scaffold(
      appBar: AppBar(title: Text('Notes')),
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //HEADING
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text('Notes', style: GoogleFonts.dmSerifText()),
          ),

          //LIST OF NOTES
          Expanded(
            child: ListView.builder(
              itemCount: currentNotes.length,
              itemBuilder: (context, index) {
                //get individual note
                final note = currentNotes[index];

                //list tile UI
                return ListTile(
                  title: Text('note.text'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //edit button
                      IconButton(
                        onPressed: () => updateNote(note),
                        icon: Icon(Icons.edit),
                      ),

                      //delete button
                      IconButton(
                        onPressed: () => deleteNote(note.id),
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
