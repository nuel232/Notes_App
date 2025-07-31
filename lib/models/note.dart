import 'package:isar/isar.dart';

//this line is needed to generate file
//then run: dart run builder_runner build
part 'note.g.dart';

@Collection()
class Note {
  Id id = Isar.autoIncrement;
  late String
  text; //this late tag is there cause we are going to initialize it later
}
