import 'package:flutter_keep_google/data/datasource/sqflite/note_datasource.dart';
import 'package:flutter_keep_google/data/model/note_model.dart';
import 'package:flutter_keep_google/domain/repository/note_repository_interface.dart';

class NoteRepository extends INoteRepository {
  final INoteDataSource? noteDataSource;

  NoteRepository({this.noteDataSource});

  @override
  Future<int> addNote(NoteModel model) async {
    var id = await noteDataSource!.createNote(model);
    return id;
  }

  @override
  Future<List<NoteModel>> getAllNote() async {
    List<NoteModel> listCustomer = await noteDataSource!.readNote();
    return listCustomer;
  }
}
