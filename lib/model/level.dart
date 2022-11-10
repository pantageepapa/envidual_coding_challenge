//name of the table
final String tableNotes = "levels";

class LevelFields {
  static final String id = "_id";
  static final String level = "level";
  static final String time = "time";

  static final List<String> values = [id, level, time];
}

class Level {
  final int? id;
  final int level;
  final int time;

  const Level({this.id, required this.level, required this.time});

  Level copy({int? id, int? level, int? time}) => Level(
      id: id ?? this.id, level: level ?? this.level, time: time ?? this.time);
  Map<String, Object?> toJson() =>
      {LevelFields.id: id, LevelFields.level: level, LevelFields.time: time};
  static Level fromJson(Map<String, Object?> json) => Level(
      id: json[LevelFields.id] as int?,
      level: json[LevelFields.level] as int,
      time: json[LevelFields.time] as int);
}
