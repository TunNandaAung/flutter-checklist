import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class Todo {
  final bool complete;
  final String id;
  final String note;
  final String task;
  final String userId;

  Todo(this.task,
      {this.complete = false, String note = '', String id, String userId = ''})
      : this.note = note ?? '',
        this.id = id,
        this.userId = userId ?? '';

  Todo copyWith(
      {bool complete, String id, String note, String task, String userId}) {
    return Todo(task ?? this.task,
        complete: complete ?? this.complete,
        id: id ?? this.id,
        note: note ?? this.note,
        userId: userId ?? userId);
  }

  @override
  int get hashCode =>
      complete.hashCode ^
      task.hashCode ^
      note.hashCode ^
      id.hashCode ^
      userId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Todo &&
          runtimeType == other.runtimeType &&
          complete == other.complete &&
          task == other.task &&
          note == other.note &&
          id == other.id &&
          userId == other.userId;

  @override
  String toString() {
    return 'Todo{complete: $complete, task: $task, note: $note, id: $id, userId: $userId}';
  }

  TodoEntity toEntity() {
    return TodoEntity(task, id, note, complete, userId);
  }

  static Todo fromEntity(TodoEntity entity) {
    return Todo(entity.task,
        complete: entity.complete ?? false,
        note: entity.note,
        id: entity.id,
        userId: entity.userId ?? '');
  }
}
