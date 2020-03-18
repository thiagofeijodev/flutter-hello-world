import '../todo_api.dart';

class Todo extends ManagedObject<_Todo> implements _Todo {
  @override
  void willInsert() {
    createdAt = DateTime.now().toUtc();
  }
}

class _Todo {
  @primaryKey
  int id;


  @Column(indexed: true)
  String name;

  DateTime createdAt;
}
