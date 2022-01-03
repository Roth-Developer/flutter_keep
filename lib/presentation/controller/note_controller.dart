import 'package:flutter_keep_google/data/model/note_model.dart';
import 'package:flutter_keep_google/domain/entity/no_param.dart';
import 'package:flutter_keep_google/domain/usecase/note_usecase.dart';
import 'package:get/get.dart';

class NoteController extends GetxController {
  final GetAllNoteUseCase? getAllNoteUseCase;
  final AddNoteUseCase? addNoteUseCase;
  final UpdateNoteUseCase? updateNoteUseCase;
  final DeleteNoteUseCase? deleteNoteUseCase;

  var listNote = RxList<NoteModel>();
  late NoteModel selectedNote;
  var isLoading = false.obs;

  var blankNote = NoteModel(
    title: '',
    note: '',
  );

  NoteController({
    this.getAllNoteUseCase,
    this.addNoteUseCase,
    this.updateNoteUseCase,
    this.deleteNoteUseCase,
  });
  editNote(NoteModel model) {
    selectedNote = model;
  }

  selectNote(NoteModel model) {
    selectedNote = model;
    listNote.refresh();
  }

  loadNote() async {
    isLoading.value = true;
    selectedNote = blankNote;
    listNote.clear();
    var list = await getAllNoteUseCase!.call(NoParam());
    listNote.assignAll(list);
    isLoading.value = false;
  }

  Future<int> saveData(NoteModel model) async {
    var recordId = await addNoteUseCase!.call(model);

    listNote.add(model.copyWith(id: recordId));

    return recordId;
  }

  Future<int> updateData(NoteModel model) async {
    var recordId = await updateNoteUseCase!.call(model);

    var id = listNote.indexWhere((x) => x.id == model.id);
    listNote[id] = model;

    return recordId;
  }

  Future<int> deleteData(int recordId) async {
    var id = await deleteNoteUseCase!.call(recordId);

    listNote.removeWhere((x) => x.id == recordId);

    return id;
  }
}
