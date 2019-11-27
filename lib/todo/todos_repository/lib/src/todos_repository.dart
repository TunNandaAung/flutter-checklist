// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import '../todos_barrel.dart';

abstract class TodosRepository {
  Future<void> addNewTodo(Todo todo);

  Future<void> deleteTodo(Todo todo);

  Stream<List<Todo>> todos(String userId);

  Future<void> updateTodo(Todo todo);
}
