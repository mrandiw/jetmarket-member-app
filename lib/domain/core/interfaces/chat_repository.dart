import '../../../utils/network/data_state.dart';
import '../model/model_data/chat_model.dart';
import '../model/model_data/check_existing_model.dart';
import '../model/model_data/create_chat_model.dart';
import '../model/model_data/list_chat_model.dart';
import '../model/params/chat/chat_param.dart';
import '../model/params/chat/chat_update_param.dart';
import '../model/params/chat/check_existing_param.dart';
import '../model/params/chat/create_chat_param.dart';

abstract class ChatRepository {
  Future<DataState<List<dynamic>>> getProviousChat();
  Future<DataState<List<ListChatModel>>> getListChat(
      {required int page, required int size});
  Future<DataState<List<ChatModel>>> getChat(ChatParam param);
  Future<DataState<List<ChatModel>>> getChatFromStore(String id);
  Future<DataState<bool>> deletedChat(
      {required String id,
      required bool fromStore,
      required List<int> itemId,
      required String time});
  Future<DataState<bool>> deletedChatFromStore(
      {required String id,
      required List<String> itemCreatedAt,
      required String time});
  Future<DataState<CheckExistingModel>> checkExisting(CheckExisting param);
  Future<DataState<CreateChatModel>> createChat(CreateChatParam param);
  Future<DataState<bool>> createDocument(int id);
  Stream<List<ChatModel>> streamChatFromStore(String id);
  Future<DataState<bool>> sendMessage(
      {required String documentTitle, required Map<String, dynamic> message});
  Stream<List<ChatModel>> listenStore(String id);
  Future<DataState<int>> getUnreadChat();
  Future<DataState<bool>> updateChat(ChatUpdateParam param);
}
