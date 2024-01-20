import '../../../utils/network/data_state.dart';
import '../model/model_data/chat_model.dart';
import '../model/params/chat/chat_param.dart';

abstract class ChatRepository {
  Future<DataState<List<dynamic>>> getProviousChat();
  Future<DataState<List<ChatModel>>> getChat(ChatParam param);
  Future<DataState<List<ChatModel>>> getChatFromStore(String id);
  Future<DataState<bool>> deletedChat(
      {required bool fromStore, required int dataIndex, required String time});
  Future<DataState<bool>> updateChatFromStore(
      {required String id, required int dataIndex, required String time});
}
