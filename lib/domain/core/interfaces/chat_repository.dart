import '../../../utils/network/data_state.dart';
import '../model/model_data/chat_model.dart';
import '../model/model_data/check_existing_model.dart';
import '../model/model_data/create_chat_model.dart';
import '../model/model_data/list_chat_model.dart';
import '../model/params/chat/chat_param.dart';
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
      required List<String> itemTextList,
      required String time});
  Future<DataState<bool>> updateChatFromStore(
      {required String id,
      required List<String> itemTextList,
      required String time});
  Future<DataState<CheckExistingModel>> checkExisting(CheckExisting param);
  Future<DataState<CreateChatModel>> createChat(CreateChatParam param);
  Future<DataState<bool>> createDocument(int id);
}
