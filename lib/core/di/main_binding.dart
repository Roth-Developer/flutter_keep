import 'package:flutter_keep_google/data/datasource/sqflite/note_datasource.dart';
import 'package:flutter_keep_google/data/repository/note_repository.dart';
import 'package:flutter_keep_google/domain/repository/note_repository_interface.dart';
import 'package:flutter_keep_google/domain/usecase/note_usecase.dart';
import 'package:flutter_keep_google/presentation/controller/note_controller.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<INoteDataSource?>(
      NoteDataSource(),
      permanent: true,
    );
    Get.put<INoteRepository?>(
      NoteRepository(noteDataSource: Get.find()),
      permanent: true,
    );
    Get.put<GetAllNoteUseCase?>(
      GetAllNoteUseCase(noteRepository: Get.find()),
      permanent: true,
    );
    Get.put<AddNoteUseCase?>(
      AddNoteUseCase(noteRepository: Get.find()),
      permanent: true,
    );

    Get.put(
      NoteController(
        getAllNoteUseCase: Get.find(),
        addNoteUseCase: Get.find(),
      ),
      permanent: true,
    );
  }
}
