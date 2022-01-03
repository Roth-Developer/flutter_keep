import 'package:flutter/material.dart';
import 'package:flutter_keep_google/core/enum/transaction_action_enum.dart';
import 'package:flutter_keep_google/data/model/note_model.dart';
import 'package:flutter_keep_google/presentation/controller/note_controller.dart';
import 'package:flutter_keep_google/presentation/widget/my_textfield.dart';
import 'package:get/get.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({
    Key? key,
    required this.transactionAction,
  }) : super(key: key);

  final TransactionAction transactionAction;

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final NoteController noteController = Get.find();
  late TextEditingController tecTitle;
  late TextEditingController tecNote;
  late FocusNode fnTitle;
  late FocusNode fnNote;

  @override
  void initState() {
    tecTitle = TextEditingController();
    tecNote = TextEditingController();
    fnTitle = FocusNode();
    fnNote = FocusNode();
    fnNote.requestFocus();

    if (widget.transactionAction == TransactionAction.add) {
      fnNote.requestFocus();
    } else {
      tecTitle.text = noteController.selectedNote.title!;
      tecNote.text = noteController.selectedNote.note!;
    }
    super.initState();
  }

  @override
  void dispose() {
    tecTitle.dispose();
    tecNote.dispose();
    fnTitle.dispose();
    fnNote.dispose();
    super.dispose();
  }

  bool isValid() {
    var b = true;
    if (tecTitle.text == '' && tecNote.text == '') {
      b = false;
    }
    return b;
  }

  saveData() async {
    if (isValid()) {
      var model = NoteModel(
        title: tecTitle.text,
        note: tecNote.text,
      );
      noteController.saveData(model);
    } else {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    saveData();

                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            MyTextField(
              focusNode: fnTitle,
              text: 'Title',
              controller: tecTitle,
            ),
            MyTextField(
              focusNode: fnNote,
              text: 'Note',
              controller: tecNote,
            ),
          ],
        ),
      ),
    );
  }
}
