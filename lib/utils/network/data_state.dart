import 'status_response.dart';

class DataState<T> {
  final String? path;
  final String? message;
  final StatusResponse? status;
  final T? result;

  DataState({this.path, this.message, this.status, this.result});
}
