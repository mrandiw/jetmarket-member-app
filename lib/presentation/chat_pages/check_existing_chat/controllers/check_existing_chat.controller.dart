import 'package:get/get.dart';
import 'package:jetmarket/domain/core/interfaces/chat_repository.dart';
import 'package:jetmarket/domain/core/model/params/chat/create_chat_param.dart';
import 'package:jetmarket/domain/core/model/model_data/detail_product.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import '../../../../domain/core/model/argument/chat_room_argument.dart';
import '../../../../domain/core/model/params/chat/check_existing_param.dart';
import '../../../../utils/network/status_response.dart';

class CheckExistingChatController extends GetxController {
  final ChatRepository _chatRepository;
  CheckExistingChatController(this._chatRepository);
  CheckExisting? checkExisting;
  Seller? seller;
  // Variants? variants;
  int? productId;
  ChatRoomArgument? dataArgument;

  Future<void> checkExistingChat() async {
    var param = CheckExisting(
      fromId: checkExisting?.fromId ?? 0,
      toId: checkExisting?.toId ?? 0,
      fromRole: checkExisting?.fromRole ?? '',
      toRole: checkExisting?.toRole ?? '',
    );
    final response = await _chatRepository.checkExisting(param);
    if (response.status == StatusResponse.success) {
      if (response.result?.isExist == false) {
        createChat();
      } else {
        dataArgument = ChatRoomArgument(
          chatId: response.result?.chat?.id ?? 0,
          fromId: checkExisting?.fromId,
          toId: checkExisting?.toId,
          fromRole: checkExisting?.fromRole,
          toRole: checkExisting?.toRole,
          image: response.result?.chat?.image ?? '',
          name: response.result?.chat?.name ?? '',
          createdAt: response.result?.chat?.createdAt ?? '',
          unreadCount: response.result?.chat?.unreadCount ?? 0,
        );
        Get.offNamed(Routes.DETAIL_CHAT, arguments: dataArgument);
      }
    }
  }

  Future<void> createChat() async {
    var param = CreateChatParam(
        fromId: checkExisting?.fromId,
        toId: checkExisting?.toId,
        fromRole: checkExisting?.fromRole,
        toRole: checkExisting?.toRole,
        productId: productId,
        orderId: 0);
    final response = await _chatRepository.createChat(param);
    if (response.status == StatusResponse.success) {
      dataArgument = ChatRoomArgument(
        chatId: response.result?.id ?? 0,
        fromId: checkExisting?.fromId,
        toId: checkExisting?.toId,
        fromRole: checkExisting?.fromRole,
        toRole: checkExisting?.toRole,
        image: response.result?.image ?? '',
        name: response.result?.name ?? '',
        createdAt: response.result?.createdAt ?? '',
        unreadCount: response.result?.unreadCount ?? 0,
      );
      createDocument(response.result?.id ?? 0);
    }
  }

  Future<void> createDocument(int id) async {
    final response = await _chatRepository.createDocument(id);
    if (response.result == true) {
      Get.offNamed(Routes.DETAIL_CHAT, arguments: dataArgument);
    }
  }

  setData() {
    checkExisting = Get.arguments[0];
    seller = Get.arguments[1];
    productId = Get.arguments[2];
    checkExistingChat();
  }

  @override
  void onInit() {
    setData();

    super.onInit();
  }
}
