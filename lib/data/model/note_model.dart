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
  static const String columnColorInt = 'colorint';

  final int? id;
  final String? title;
  final String? note;
  final DateTime dateTime;

  // final String? tag;
  final bool pin;
  // final String? status;
  final int colorInt;

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
        $columnColorInt INTERGER,
        $columnStatus TEXT)""";
  }

  NoteModel({
    this.id,
    this.title,
    this.note,
    required this.dateTime,

    // this.tag,
    this.pin = false,
    required this.colorInt,

    // this.status,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTitle: title,
      columnNote: note,
      columnDateTime: dateTime.toIso8601String(),

      // columnTag: tag,
      columnPin: pin == true ? 1 : 0,
      columnColorInt: colorInt,
      // columnStatus: status,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map[columnId],
      note: map[columnNote],
      title: map[columnTitle],
      dateTime: DateTime.parse(
        map[columnDateTime],
      ),

      pin: map[columnPin] == 1 ? true : false,

      colorInt: map[columnColorInt],
      // tag: map[columnTag],
      // status: map[columnStatus],
    );
  }

  NoteModel copyWith({
    int? id,
    String? title,
    String? note,
    required DateTime dateTime,

    // String? tag,
    required bool pin,
    int? colorint,
    // String? status,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note,
      dateTime: dateTime,

      // tag: tag ?? this.tag,
      pin: pin,

      colorInt: colorint ?? colorInt,
      // status: status ?? this.status,
    );
  }
}
