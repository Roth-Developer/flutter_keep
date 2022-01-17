import 'package:flutter/material.dart';
import 'package:flutter_keep_google/app.dart';
import 'package:flutter_keep_google/core/constant/app_color.dart';
import 'package:flutter_keep_google/core/enum/transaction_action_enum.dart';
import 'package:flutter_keep_google/data/model/colors_model.dart';
import 'package:flutter_keep_google/data/model/note_model.dart';
import 'package:flutter_keep_google/presentation/controller/note_controller.dart';
import 'package:flutter_keep_google/presentation/widget/my_textfield.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
      noteController.selectedColor.value = Colors.white;
    } else {
      tecTitle.text = noteController.selectedNote.title!;
      tecNote.text = noteController.selectedNote.note!;
      isPin = noteController.selectedNote.pin;

      noteController.selectedColor.value =
          Color(noteController.selectedNote.colorInt);
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
          colorInt: noteController.selectedColor.value.value,
        );

        noteController.saveData(model);
      } else {
        var model = NoteModel(
          id: noteController.selectedNote.id,
          title: tecTitle.text,
          note: tecNote.text,
          dateTime: DateTime.now(),
          pin: isPin,
          colorInt: noteController.selectedColor.value.value,
        );
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
    return Obx(
      () => Scaffold(
        backgroundColor: noteController.selectedColor.value,
        appBar: AppBar(
          backgroundColor: noteController.selectedColor.value,
          leading: IconButton(
            onPressed: () {
              saveData();
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                setPin();
              },
              icon: isPin == false
                  ? const Icon(
                      Icons.push_pin_outlined,
                      color: Colors.black,
                    )
                  : const Icon(
                      Icons.push_pin,
                      color: Colors.black,
                    ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.alarm_add,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.download_for_offline_outlined,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
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
        ),
        bottomSheet: Container(
          color: noteController.selectedColor.value,
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add_box_outlined),
              ),
              IconButton(
                onPressed: () {
                  showMaterialModalBottomSheet(
                    context: context,
                    builder: (context) => Obx(
                      () => Container(
                        height: 200,
                        color: noteController.selectedColor.value,
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
                                              noteController.selectColor(x);
                                            },
                                            child: CircleAvatar(
                                              radius: 17,
                                              backgroundColor: noteController
                                                          .selectedColor
                                                          .value ==
                                                      x
                                                  ? Colors.purple
                                                  : Colors.transparent,
                                              child: CircleAvatar(
                                                  foregroundColor: Colors.black,
                                                  radius: 15,
                                                  backgroundColor: x,
                                                  child: noteController
                                                              .selectedColor
                                                              .value ==
                                                          x
                                                      ? const Icon(Icons.done)
                                                      : const SizedBox
                                                          .shrink()),
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
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
          ),
        ),
      ),
    );
  }
}

// Row(
//                   children: [
//                     IconButton(
//                       onPressed: () {},
//                       icon: const Icon(Icons.add_box_outlined),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         showMaterialModalBottomSheet(
//                           context: context,
//                           builder: (context) => Obx(
//                             () => Container(
//                               height: 200,
//                               color: noteController.selectedColor.value,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(10.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const Text('Color'),
//                                     Row(
//                                       children: AppColor.listNoteBackGroundColor
//                                           .map((x) => Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(8.0),
//                                                 child: GestureDetector(
//                                                   onTap: () {
//                                                     noteController
//                                                         .selectColor(x);
//                                                   },
//                                                   child: CircleAvatar(
//                                                       radius: 15,
//                                                       backgroundColor: x,
//                                                       child: noteController
//                                                                   .selectedColor
//                                                                   .value ==
//                                                               x
//                                                           ? const Text('a')
//                                                           : const SizedBox
//                                                               .shrink()),
//                                                 ),
//                                               ))
//                                           .toList(),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                       icon: const Icon(Icons.av_timer_outlined),
//                     ),
//                     const Spacer(),
//                     widget.transactionAction == TransactionAction.add
//                         ? Text(formatted)
//                         : Text(DateFormat('hh:mm')
//                             .format(noteController.selectedNote.dateTime)),
//                     const Spacer(),
//                     IconButton(
//                       onPressed: () {},
//                       icon: const Icon(Icons.menu),
//                     ),
//                   ],
//                 // )
