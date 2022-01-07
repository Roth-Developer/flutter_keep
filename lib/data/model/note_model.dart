import 'package:flutter/material.dart';
import 'package:flutter_keep_google/core/constant/app_color.dart';

class NoteModel {
  //field for table
  static const String tableName = 't_note';
  static const String columnId = 'id';
  static const String columnTitle = 'title';
  static const String columnNote = 'note';
  static const String columnDateTime = 'datetime';
  static const String columnColor = 'color';
  static const String columnTag = 'tag';
  static const String columnPin = 'pin';
  static const String columnStatus = 'status';

  final int? id;
  final String? title;
  final String? note;
  final DateTime dateTime;
  final String color;
  final Color? col;
  // final String? tag;
  final bool pin;
  // final String? status;

  //query string for create table
  static String createTable() {
    return """CREATE TABLE $tableName (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,  
        $columnTitle TEXT,  
        $columnNote TEXT,
        $columnDateTime TEXT,
        $columnColor TEXT,
        $columnTag TEXT,
        $columnPin INTERGER,
        $columnStatus TEXT)""";
  }

  NoteModel({
    this.id,
    this.title,
    this.note,
    required this.dateTime,
    required this.color,
    // this.tag,
    this.pin = false,
    this.col,
    // this.status,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTitle: title,
      columnNote: note,
      columnDateTime: dateTime.toIso8601String(),
      columnColor: color,
      // columnTag: tag,
      columnPin: pin == true ? 1 : 0,
      // columnStatus: status,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    var id = AppColor.listNoteBackGroundColor
        .indexWhere((x) => x.code == map[columnColor]);
    var coll = AppColor.listNoteBackGroundColor[id];
    return NoteModel(
      id: map[columnId],
      note: map[columnNote],
      title: map[columnTitle],
      dateTime: DateTime.parse(
        map[columnDateTime],
      ),
      color: map[columnColor],
      pin: map[columnPin] == 1 ? true : false,
      col: coll.color,
      // tag: map[columnTag],
      // status: map[columnStatus],
    );
  }

  NoteModel copyWith({
    int? id,
    String? title,
    String? note,
    required DateTime dateTime,
    required String color,
    // String? tag,
    required bool pin,
    Color? col,
    // String? status,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note,
      dateTime: dateTime,
      color: color,
      // tag: tag ?? this.tag,
      pin: pin,
      col: col,
      // status: status ?? this.status,
    );
  }
}
