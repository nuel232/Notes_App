import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notw/components/my_drawer.dart';
import 'package:notw/components/note_tile.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../models/note_database.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  //text controller to access what the user typed
  final textController = TextEditingController();

  // create a note
  void createNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
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

  //update a note
  void updateNote(Note note) {
    //pre-fill the current note text
    textController.text = note.text;
    final noteDatabase = context.read<NoteDatabase>();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text('Update Note'),
        content: TextField(controller: textController),
        actions: [
          //update button
          MaterialButton(
            onPressed: () {
              final index = noteDatabase.getNoteIndex(note);
              //update note in db
              noteDatabase.updateNote(index, textController.text);
              //clear controller
              textController.clear();
              //pop dialog box
              Navigator.pop(context);
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }

  //delete a note
  void deleteNote(Note note) {
    final noteDatabase = context.read<NoteDatabase>();
    final index = noteDatabase.getNoteIndex(note);
    noteDatabase.deleteNote(index);
  }

  @override
  Widget build(BuildContext context) {
    //note database
    final noteDatabase = context.watch<NoteDatabase>();

    //current notes
    List<Note> currentNotes = noteDatabase.currentNotes;
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        shape: CircleBorder(),
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      drawer: MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //HEADING
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text('Notes', style: GoogleFonts.dmSerifText(fontSize: 48)),
          ),

          //LIST OF NOTES
          Expanded(
            child: ListView.builder(
              itemCount: currentNotes.length,
              itemBuilder: (context, index) {
                //get individual note
                final note = currentNotes[index];

                //list tile UI
                return NoteTile(
                  text: note.text,
                  onDeletePressed: () => deleteNote(note),
                  onEditPressed: () => updateNote(note),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
