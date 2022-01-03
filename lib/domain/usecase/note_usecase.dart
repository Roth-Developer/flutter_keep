import 'package:flutter_keep_google/data/model/note_model.dart';
import 'package:flutter_keep_google/domain/entity/no_param.dart';
import 'package:flutter_keep_google/domain/repository/note_repository_interface.dart';
import 'package:flutter_keep_google/domain/usecase/usecase.dart';

class GetAllNoteUseCase extends UseCaseFuture<List<NoteModel>, NoParam> {
  final INoteRepository? noteRepository;

  GetAllNoteUseCase({this.noteRepository});

  @override
  Future<List<NoteModel>> call(NoParam params) async {
    List<NoteModel> listNote = await noteRepository!.getAllNote();
    return listNote;
  }
}

class AddNoteUseCase extends UseCaseFuture<int, NoteModel> {
  final INoteRepository? noteRepository;

  AddNoteUseCase({this.noteRepository});

  @override
  Future<int> call(NoteModel params) async {
    var id = await noteRepository!.addNote(params);
    return id;
  }
}

class UpdateNoteUseCase extends UseCaseFuture<int, NoteModel> {
  final INoteRepository? noteRepository;

  UpdateNoteUseCase({this.noteRepository});

  @override
  Future<int> call(NoteModel params) async {
    var id = await noteRepository!.updateNote(params);
    return id;
  }
}

class DeleteNoteUseCase extends UseCaseFuture<int, int> {
  final INoteRepository? noteRepository;

  DeleteNoteUseCase({this.noteRepository});

  @override
  Future<int> call(int params) async {
    var id = await noteRepository!.deleteNote(params);
    return id;
  }
}
