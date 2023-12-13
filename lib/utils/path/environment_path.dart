class EnvironmentPath {
  static final EnvironmentPath _environmentPath = EnvironmentPath._internal();

  factory EnvironmentPath() {
    return _environmentPath;
  }
  EnvironmentPath._internal();

  String staging = "assets/env/.env";
}
