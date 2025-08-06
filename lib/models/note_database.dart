import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'note.dart';

class NoteDatabase extends ChangeNotifier {
  static late Box<Note> _notesBox;

  // Initialize Hive and open the notes box
  static Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(NoteAdapter());
    _notesBox = await Hive.openBox<Note>('notes');
  }

  // Getter for current notes
  List<Note> get currentNotes => _notesBox.values.toList();

  // Create
  Future<void> addNote(String textFromUser) async {
    final newNote = Note(text: textFromUser);
    await _notesBox.add(newNote);
    notifyListeners();
  }

  // Update
  Future<void> updateNote(int index, String newText) async {
    final note = _notesBox.getAt(index);
    if (note != null) {
      note.text = newText;
      await note.save();
      notifyListeners();
    }
  }

  // Delete
  Future<void> deleteNote(int index) async {
    await _notesBox.deleteAt(index);
    notifyListeners();
  }

  // Helper to get note index
  int getNoteIndex(Note note) {
    return _notesBox.values.toList().indexOf(note);
  }

  // Fetch notes (for compatibility with previous code)
  void fetchNotes() {
    notifyListeners();
  }
}
