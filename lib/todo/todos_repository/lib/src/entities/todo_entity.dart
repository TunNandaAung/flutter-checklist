import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  final bool? complete;
  final String id;
  final String note;
  final String task;
  final String? userId;
  final int? time;

  const TodoEntity(
      this.task, this.id, this.note, this.complete, this.userId, this.time);

  Map<String, Object?> toJson() {
    return {
      "complete": complete ?? false,
      "task": task,
      "note": note,
      "id": id,
      "userId": userId,
      "time": time
    };
  }

  @override
  List<Object> get props => [id, note, task];

  @override
  String toString() {
    return 'TodoEntity { complete: $complete, task: $task, note: $note, id: $id ,userId: $userId ,time: $time}';
  }

  static TodoEntity fromJson(Map<String, Object> json) {
    return TodoEntity(
        json["task"] as String,
        json["id"] as String,
        json["note"] as String,
        json["complete"] as bool,
        json["userId"] as String,
        json["time"] as int);
  }

  static TodoEntity fromSnapshot(DocumentSnapshot snap) {
    dynamic data = snap.data();
    return TodoEntity(data['task'], snap.id, data['note'], data['complete'],
        data['userId'], data['time']);
  }

  Map<String, Object?> toDocument() {
    return {
      "complete": complete,
      "task": task,
      "note": note,
      "userId": userId,
      "time": time
    };
  }
}
