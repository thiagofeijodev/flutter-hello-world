import 'todo_api.dart';
import 'model/todo.dart';
import 'controller/todo_controller.dart';

class TodoApiChannel extends ApplicationChannel {
  ManagedContext context;

  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final config = TodoApiConfiguration(options.configurationFilePath);
    context = contextWithConnectionInfo(config.database);
  }

  @override
  Controller get entryPoint {
    final router = Router();

    router.route("/todo/[:id]").link(() => ManagedObjectController<Todo>(context));
    router.route("/ctrl_todo/[:id]").link(() => TodoController(context));

    return router;
  }

  /*
   * Helper methods
   */
  ManagedContext contextWithConnectionInfo(DatabaseConfiguration connectionInfo) {
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final psc = PostgreSQLPersistentStore(connectionInfo.username, connectionInfo.password, connectionInfo.host,
        connectionInfo.port, connectionInfo.databaseName);

    return ManagedContext(dataModel, psc);
  }
}

class TodoApiConfiguration extends Configuration {
  TodoApiConfiguration(String fileName) : super.fromFile(File(fileName));

  DatabaseConfiguration database;
}
