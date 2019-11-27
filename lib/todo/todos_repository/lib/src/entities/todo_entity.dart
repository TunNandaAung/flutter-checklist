import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  final bool complete;
  final String id;
  final String note;
  final String task;
  final String userId;

  const TodoEntity(this.task, this.id, this.note, this.complete, this.userId);

  Map<String, Object> toJson() {
    return {
      "complete": complete,
      "task": task,
      "note": note,
      "id": id,
      "userId": userId
    };
  }

  @override
  List<Object> get props => [complete, id, note, task];

  @override
  String toString() {
    return 'TodoEntity { complete: $complete, task: $task, note: $note, id: $id ,userId: $userId }';
  }

  static TodoEntity fromJson(Map<String, Object> json) {
    return TodoEntity(
      json["task"] as String,
      json["id"] as String,
      json["note"] as String,
      json["complete"] as bool,
      json["userId"] as String,
    );
  }

  static TodoEntity fromSnapshot(DocumentSnapshot snap) {
    return TodoEntity(snap.data['task'], snap.documentID, snap.data['note'],
        snap.data['complete'], snap.data['userId']);
  }

  Map<String, Object> toDocument() {
    return {"complete": complete, "task": task, "note": note, "userId": userId};
  }
}
