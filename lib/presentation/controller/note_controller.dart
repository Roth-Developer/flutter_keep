import 'package:flutter/material.dart';
import 'package:flutter_keep_google/data/model/colors_model.dart';
import 'package:flutter_keep_google/data/model/note_model.dart';
import 'package:flutter_keep_google/domain/entity/no_param.dart';
import 'package:flutter_keep_google/domain/usecase/note_usecase.dart';
import 'package:get/get.dart';

class NoteController extends GetxController {
  final GetAllNoteUseCase? getAllNoteUseCase;
  final AddNoteUseCase? addNoteUseCase;
  final UpdateNoteUseCase? updateNoteUseCase;
  final DeleteNoteUseCase? deleteNoteUseCase;
  var selectedColor = Rx<Color>(Colors.white);
  var listNotePin = RxList<NoteModel>();
  var listNoteUnPin = RxList<NoteModel>();
  var listNoteAll = RxList<NoteModel>();
  var listColor = RxList<ColorModel>();
  late NoteModel selectedNote;
  var isLoading = false.obs;

  var listSearchNote = RxList<NoteModel>();
  var listSearchNoteWithColor = RxList<NoteModel>();

  var blankNote = NoteModel(
    title: '',
    note: '',
    dateTime: DateTime.now(),

    colorInt: 0,
    // tag: '',
    // pin: false,
    // status: '',
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
    listNoteAll.refresh();
  }

  selectColor(Color color) {
    selectedColor.value = color;
    selectedColor.refresh();
  }

  loadNoteAll() async {
    isLoading.value = true;
    selectedNote = blankNote;
    listNoteAll.clear();
    var list = await getAllNoteUseCase!.call(NoParam());
    listNoteAll.assignAll(list);
    listNotePin.assignAll(listNoteAll.where((x) => x.pin == true));
    listNoteUnPin.assignAll(listNoteAll.where((x) => x.pin == false));
    isLoading.value = false;
  }

  Future<int> saveData(NoteModel model) async {
    var recordId = await addNoteUseCase!.call(model);

    listNoteAll.add(model.copyWith(
      id: recordId,
      dateTime: DateTime.now(),
      pin: model.pin,
      colorint: model.colorInt,
    ));
    if (model.pin == true) {
      listNotePin.add(model.copyWith(
        id: recordId,
        dateTime: DateTime.now(),
        pin: model.pin,
        colorint: model.colorInt,
      ));
    } else {
      listNoteUnPin.add(model.copyWith(
        id: recordId,
        dateTime: DateTime.now(),
        pin: model.pin,
        colorint: model.colorInt,
      ));
    }

    return recordId;
  }

  Future<int> updateData(NoteModel model) async {
    var recordId = await updateNoteUseCase!.call(model);

    var id = listNoteAll.indexWhere((x) => x.id == model.id);
    listNoteAll[id] = model;

    listNotePin.assignAll(listNoteAll.where((x) => x.pin == true));
    listNoteUnPin.assignAll(listNoteAll.where((x) => x.pin == false));

    return recordId;
  }

  Future<int> deleteData(int recordId) async {
    var id = await deleteNoteUseCase!.call(recordId);

    listNoteAll.removeWhere((x) => x.id == recordId);

    return id;
  }

  searchNote(String textSearch) {
    if (textSearch.trim() == '') {
      listSearchNote.clear();
    } else {
      listSearchNote.assignAll(
        listNoteAll.where(
          (x) => (x.note!.toLowerCase().contains(
                    textSearch.toLowerCase(),
                  ) ||
              x.title!.toLowerCase().contains(
                    textSearch.toLowerCase(),
                  )),
        ),
      );
    }
  }

  searchColorNote(int color) {
    listSearchNote.clear();

    listSearchNote.assignAll(
      listNoteAll.where(
        (x) => (x.colorInt == color),
      ),
    );
  }

  searchNoteWithColor(
      {required int color, required String textSearchWithColor}) {
    if (textSearchWithColor.trim() == '') {
      listSearchNoteWithColor
          .assignAll(listNoteAll.where((x) => (x.colorInt == color)));
    } else {
      listSearchNoteWithColor.assignAll(
        listNoteAll.where(
          (x) => ((x.note!.toLowerCase().contains(
                        textSearchWithColor.toLowerCase(),
                      ) &&
                  x.colorInt == color) ||
              (x.title!.toLowerCase().contains(
                        textSearchWithColor.toLowerCase(),
                      ) &&
                  x.colorInt == color)),
        ),
      );
    }
  }
}
