import 'package:isar/isar.dart';

//this line is needed to generate file
//then run: dart run builder_runner build
part 'note.g.dart';

@Collection()
class Note {
  //this will auto increment the id
  Id id = Isar.autoIncrement;

  //this late tag is there cause we are going to initialize it later
  late String text;
}
