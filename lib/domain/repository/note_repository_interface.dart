import 'package:flutter_keep_google/data/model/note_model.dart';

abstract class INoteRepository {
  Future<List<NoteModel>> getAllNote();
  Future<int> addNote(NoteModel model);
  Future<int> updateNote(NoteModel model);
  Future<int> deleteNote(int recordId);
}
