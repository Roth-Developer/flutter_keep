class NoteModel {
  //field for table
  static const String tableName = 't_note';
  static const String columnId = 'id';
  static const String columnTitle = 'title';
  static const String columnNote = 'note';

  final int? id;
  final String? title;
  final String? note;

  //query string for create table
  static String createTable() {
    return """CREATE TABLE $tableName (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,  
        $columnTitle TEXT,  
        $columnNote TEXT)""";
  }

  NoteModel({
    this.id,
    this.title,
    this.note,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTitle: title,
      columnNote: note,
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
    );
  }

  NoteModel copyWith({
    int? id,
    String? title,
    String? note,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note,
    );
  }
}
