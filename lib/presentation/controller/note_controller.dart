import 'package:flutter_keep_google/data/model/note_model.dart';
import 'package:flutter_keep_google/domain/entity/no_param.dart';
import 'package:flutter_keep_google/domain/usecase/note_usecase.dart';
import 'package:get/get.dart';

class NoteController extends GetxController {
  final GetAllNoteUseCase? getAllNoteUseCase;
  final AddNoteUseCase? addNoteUseCase;

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
  });

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
}
