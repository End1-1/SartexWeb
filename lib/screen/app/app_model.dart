

abstract class AppModel<T> {
  late T datasource;

  String sql();

  createDatasource();

  String filterString() {
    return "";
  }
}
