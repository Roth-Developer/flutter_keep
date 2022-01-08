import 'package:flutter/material.dart';
import 'package:flutter_keep_google/core/constant/app_color.dart';
import 'package:flutter_keep_google/core/enum/transaction_action_enum.dart';
import 'package:flutter_keep_google/data/model/colors_model.dart';
import 'package:flutter_keep_google/data/model/note_model.dart';
import 'package:flutter_keep_google/presentation/controller/note_controller.dart';
import 'package:flutter_keep_google/presentation/widget/my_textfield.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({
    Key? key,
    required this.transactionAction,
  }) : super(key: key);

  final TransactionAction transactionAction;

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final NoteController noteController = Get.find();
  late TextEditingController tecTitle;
  late TextEditingController tecNote;
  late FocusNode fnTitle;
  late FocusNode fnNote;
  late bool isPin;
  late ColorModel selectedColor;

  String formatted = DateFormat('hh:mm').format(DateTime.now());

  @override
  void initState() {
    tecTitle = TextEditingController();
    tecNote = TextEditingController();
    fnTitle = FocusNode();
    fnNote = FocusNode();
    fnNote.requestFocus();

    if (widget.transactionAction == TransactionAction.add) {
      fnNote.requestFocus();
      isPin = false;
      selectedColor = ColorModel(code: 'w', color: Colors.white);
    } else {
      tecTitle.text = noteController.selectedNote.title!;
      tecNote.text = noteController.selectedNote.note!;
      isPin = noteController.selectedNote.pin;

      var id = AppColor.listNoteBackGroundColor
          .indexWhere((x) => x.code == noteController.selectedNote.color);

      selectedColor = AppColor.listNoteBackGroundColor[id];
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
      if (widget.transactionAction == TransactionAction.add) {
        var model = NoteModel(
            title: tecTitle.text,
            note: tecNote.text,
            dateTime: DateTime.now(),
            pin: isPin,
            color: selectedColor.code,
            col: selectedColor.color);
        noteController.saveData(model);
      } else {
        var model = NoteModel(
            id: noteController.selectedNote.id,
            title: tecTitle.text,
            note: tecNote.text,
            dateTime: DateTime.now(),
            pin: isPin,
            color: selectedColor.code);
        noteController.updateData(model);
      }
    }
  }

  setPin() {
    setState(() {
      isPin = !isPin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedColor.color,
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
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    setPin();
                  },
                  icon: isPin == false
                      ? const Icon(
                          Icons.push_pin_outlined,
                        )
                      : const Icon(Icons.push_pin),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.alarm_add,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.download_for_offline_outlined),
                ),
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
            const Spacer(),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_box_outlined),
                ),
                IconButton(
                  onPressed: () {
                    Get.bottomSheet(
                        Container(
                          height: 200,
                          color: selectedColor.color,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Color'),
                                Row(
                                  children: AppColor.listNoteBackGroundColor
                                      .map((x) => Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedColor = ColorModel(
                                                      code: x.code,
                                                      color: x.color);
                                                });
                                              },
                                              child: CircleAvatar(
                                                  radius: 15,
                                                  backgroundColor: x.color,
                                                  child: selectedColor.code ==
                                                          x.code
                                                      ? const Text('a')
                                                      : const SizedBox
                                                          .shrink()),
                                            ),
                                          ))
                                      .toList(),
                                )
                              ],
                            ),
                          ),
                        ),
                        barrierColor: selectedColor.color,
                        persistent: false,
                        elevation: 8);
                  },
                  icon: const Icon(Icons.av_timer_outlined),
                ),
                const Spacer(),
                widget.transactionAction == TransactionAction.add
                    ? Text(formatted)
                    : Text(DateFormat('hh:mm')
                        .format(noteController.selectedNote.dateTime)),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.menu),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
