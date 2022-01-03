import 'package:flutter_keep_google/data/datasource/sqflite/sqflite_instance.dart';
import 'package:flutter_keep_google/data/model/note_model.dart';

abstract class INoteDataSource {
  Future<List<NoteModel>> readNote();
  Future<int> createNote(NoteModel model);
  Future<int> updateNote(NoteModel model);
  Future<int> deleteNote(int recordId);
}

class NoteDataSource extends INoteDataSource {
  @override
  Future<int> createNote(NoteModel model) async {
    var id = await SqfliteInstance.instance
        .create(map: model.toMap(), tableName: NoteModel.tableName);
    return id;
  }

  @override
  Future<int> deleteNote(int recordId) async {
    return 1;
  }

  @override
  Future<List<NoteModel>> readNote() async {
    var json =
        await SqfliteInstance.instance.read(tableName: NoteModel.tableName);
    List<NoteModel> list = [];
    for (var x in json) {
      list.add(NoteModel.fromMap(x));
    }
    return list;
  }

  @override
  Future<int> updateNote(NoteModel model) async {
    return 1;
  }
  // List<NoteModel> listNote = [
  //   NoteModel(
  //       title: 'study',
  //       description: 'sssssssssssssssssssssssssssssssssssssssssssssssssss',
  //       id: 1),
  //   NoteModel(
  //       id: 2,
  //       title: 'study',
  //       description: 'sssssssssssssssssssssssssssssssssssssssssssssssssss'),
  //   NoteModel(
  //       id: 3,
  //       title: 'study',
  //       description: 'sssssssssssssssssssssssssssssssssssssssssssssssssss'),
  //   NoteModel(
  //       id: 4,
  //       title: 'study',
  //       description: 'sssssssssssssssssssssssssssssssssssssssssssssssssss'),
  //   NoteModel(
  //       id: 5,
  //       title: 'study',
  //       description: 'sssssssssssssssssssssssssssssssssssssssssssssssssss'),
  //   NoteModel(
  //       id: 6,
  //       title: '33232',
  //       description:
  //           'sssssaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaassssssssssssssssssssssssssssssssssssssssssssss'),
  //   NoteModel(
  //       id: 7,
  //       title: '123',
  //       description:
  //           'sssssssswwwwwwwwwwwwweeeeeeeeeeeeesssssssssssssssssssssssssssssssssssssssssss'),
  //   NoteModel(
  //       id: 8,
  //       title: 'tests',
  //       description:
  //           'ssssssssssssssssssssssssssssssssssddddddddddddddddddddddddddd'),
  // ];

}
