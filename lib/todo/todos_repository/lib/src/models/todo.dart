import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class Todo {
  final bool complete;
  final String id;
  final String note;
  final String task;
  final String userId;
  final int? time;

  const Todo(
    this.task, {
    this.complete = false,
    String? note,
    String? id,
    String? userId,
    int? time,
  })  : note = note ?? '',
        id = id ?? '',
        userId = userId ?? '',
        time = time ?? 0;

  Todo copyWith({
    bool? complete,
    String? id,
    String? note,
    String? task,
    String? userId,
    int? time,
  }) {
    return Todo(task ?? this.task,
        complete: complete ?? this.complete,
        id: id ?? this.id,
        note: note ?? this.note,
        userId: userId ?? this.userId,
        time: time ?? this.time);
  }

  @override
  int get hashCode =>
      complete.hashCode ^
      task.hashCode ^
      note.hashCode ^
      id.hashCode ^
      userId.hashCode ^
      time.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Todo &&
          runtimeType == other.runtimeType &&
          complete == other.complete &&
          task == other.task &&
          note == other.note &&
          id == other.id &&
          userId == other.userId &&
          time == other.time;

  @override
  String toString() {
    return 'Todo{complete: $complete, task: $task, note: $note, id: $id, userId: $userId, time: $time}';
  }

  TodoEntity toEntity() {
    return TodoEntity(task, id, note, complete, userId, time);
  }

  static Todo fromEntity(TodoEntity entity) {
    return Todo(entity.task,
        complete: entity.complete ?? false,
        note: entity.note,
        id: entity.id,
        userId: entity.userId ?? '',
        time: entity.time ?? 0);
  }
}
