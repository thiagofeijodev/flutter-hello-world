
import '../todo_api.dart';
import '../model/todo.dart';

abstract class TodoBody {
  String name;
}

class TodoController extends ResourceController {
  TodoController(this.context);

  final ManagedContext context;

  @Operation.get('id')
  Future<Response> getTodoById(@Bind.path("id") int id) async {
    var query = Query<Todo>(context)
      ..where((u) => u.id).equalTo(id);

    var u = await query.fetchOne();
    if (u == null) {
      return  Response.notFound();
    }

    return Response.ok(u);
  }

  @Operation.delete('id')
  Future<Response> updateTodo(@Bind.path("id") int id) async {
    var query = Query<Todo>(context)
      ..where((n) => n.id).equalTo(id);

    if (await query.delete() > 0) {
      return Response.ok(null);
    }

    return Response.notFound();
  }

  @Operation.put('id')
  Future<Response> deleteTodo(@Bind.path("id") int id, @Bind.body() Todo todo) async {
    var query = Query<Todo>(context)
      ..where((n) => n.id).equalTo(id)
      ..values = todo;

    var u = await query.updateOne();
    if (u == null) {
      return Response.notFound();
    }

    return Response.ok(u);
  }

  @Operation.post()
  Future<Response> createTodo(@Bind.body() Todo todo) async {
    return Response.ok(await Query.insertObject(context, todo));
  }

  @Operation.get()
  Future<Response> getAllTodos({
    @Bind.query("page") int page: 1,
    @Bind.query("limit") int limit: 10,
    @Bind.query("created_after") DateTime createdAfter,
    }) async {
    var query =  Query<Todo>(context)
      ..fetchLimit = limit
      ..offset = (page - 1) * limit;

    if (createdAfter != null) {
      query.where((n) => n.createdAt).greaterThan(createdAfter);
    }

    return Response.ok(await query.fetch());
  }
}