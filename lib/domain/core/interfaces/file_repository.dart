import '../../../utils/network/data_state.dart';

abstract class FileRepository {
  Future<DataState<String>> uploadFile(
      {required String name, required String image});
}
