import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:jetmarket/components/snackbar/app_snackbar.dart';
import 'package:jetmarket/domain/core/interfaces/chat_repository.dart';
import 'package:jetmarket/domain/core/model/model_data/chat_model.dart';
import 'package:jetmarket/domain/core/model/model_data/detail_product.dart';
import 'package:jetmarket/domain/core/model/params/chat/chat_param.dart';
import 'package:jetmarket/utils/app_preference/app_preferences.dart';
import '../../../../domain/core/interfaces/file_repository.dart';
import '../../../../domain/core/model/argument/chat_room_argument.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/network/status_response.dart';

class DetailChatController extends GetxController {
  final FileRepository _fileRepository;
  final ChatRepository _chatRepository;
  DetailChatController(this._fileRepository, this._chatRepository);
  late ScrollController scrollController;
  TextEditingController messageController = TextEditingController();

  ChatRoomArgument? dataArgument;

  FocusNode? focusNode;
  var isSlideChat = false.obs;
  var isChatDelet = false.obs;
  var selectedItemDelete = <ChatModel>[].obs;
  int _pageSize = 10;
  Seller? seller;
  Variants? variants;
  bool isSendProduct = false;
  int maxLines = 1;
  String? imageUrl;
  PinnedMessage? pinnedMessage;
  bool isScroolBottom = false;
  var isCurrnetPositionOnTop = false.obs;
  var chatFromStore = false.obs;
  var positionSlideChat = 0.0.obs;
  var indexSlide = 1000.obs;
  var isScroolReply = false.obs;
  var indexScroll = (-0).obs;

  PagingController<int, ChatModel> pagingController =
      PagingController(firstPageKey: 0);

  Future<void> getChat(int pageKey) async {
    log("Page : $pageKey");
    try {
      List<ChatModel>? response;

      if (pageKey > 0) {
        _pageSize = 10;
        response = await getChatFromApi(pageKey);
      } else {
        await for (final data in getChatStream()) {
          response = data.reversed.toList();
        }

        _pageSize = response?.length ?? 0;
      }

      final isLastPage = response!.length < _pageSize;

      if (isLastPage) {
        pagingController.appendLastPage(response);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(response, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<List<ChatModel>> getChatFromApi(int pageKey) async {
    int id = AppPreference().getUserData()?.user?.id ?? 0;
    var param = ChatParam(
        id: id,
        chatIdStore: "${dataArgument?.chatId}",
        page: pageKey,
        size: _pageSize);
    final apiResponse = await _chatRepository.getChat(param);
    return apiResponse.result?.reversed.toList() ?? [];
  }

  Stream<List<ChatModel>> getChatStream() {
    final response =
        _chatRepository.streamChatFromStore("${dataArgument?.chatId}");

    return response;
  }

  Future<void> sendNewMessage() async {
    var userData = AppPreference().getUserData()?.user;
    final now = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    var product = PinnedProduct(
      image: dataArgument?.variants?.image,
      name: dataArgument?.variants?.name,
      price: dataArgument?.variants?.price,
      promo: dataArgument?.variants?.promo,
      productId: dataArgument?.variants?.id,
    );
    var message = pinnedMessage;
    var order = PinnedOrder();
    var sender = Sender(
        id: userData?.id,
        name: userData?.name,
        image: userData?.image,
        role: dataArgument?.fromRole);
    var receiver = Receiver(
        id: dataArgument?.toId,
        name: dataArgument?.name,
        image: dataArgument?.image,
        role: dataArgument?.toRole);
    var dataChat = ChatModel(
        createdAt: formattedDate,
        deletedAt: null,
        readAt: null,
        sender: sender,
        receiver: receiver,
        image: imageUrl,
        text: messageController.text,
        pinnedProduct: product,
        pinnedMessage: message,
        pinnedOrder: order);
// send message
    final response = await _chatRepository.sendMessage(
        documentTitle: "${dataArgument?.chatId}", message: dataChat.toMap());
    if (response.result == true) {
      pagingController.itemList?.clear();
      await getChat(0);
      isCurrnetPositionOnTop(false);
      messageController.clear();
      imageUrl = null;
      variants = null;
      pinnedMessage = null;
      maxLines = 1;
      update();

      // add scroll to top
      scrollController.animateTo(
        0,
        duration: 300.milliseconds,
        curve: Curves.easeInOut,
      );
    } else {
      AppSnackbar.show(
          message: response.message, type: SnackType.error, onTop: true);
    }
  }

  void listenMessageLenght(String value) {
    maxLines = (value.length ~/ 30) + 1;
    update();
  }

  String? imagesPath;
  File? userFile;
  Future getImageMenu() async {
    Get.back();
    final ImagePicker picker1 = ImagePicker();
    final imagePicked1 =
        await picker1.pickImage(source: ImageSource.camera, imageQuality: 30);

    imagesPath = imagePicked1!.path;
    userFile = File(imagePicked1.path);
    imageUrl = null;

    update();
    final urlImage = await uploadFile('chats', userFile?.path ?? '');
    if (urlImage != null) {
      imageUrl = urlImage;
      update();
      sendNewMessage();
    }
  }

  Future getImageGalery() async {
    Get.back();
    final ImagePicker picker1 = ImagePicker();
    final imagePicked1 =
        await picker1.pickImage(source: ImageSource.gallery, imageQuality: 30);

    imagesPath = imagePicked1!.path;
    userFile = File(imagePicked1.path);
    imageUrl = null;
    update();
    final urlImage = await uploadFile('chats', imagePicked1.path);
    if (urlImage != null) {
      imageUrl = urlImage;
      update();
      sendNewMessage();
    }
  }

  Future<String?> uploadFile(String name, String image) async {
    final response = await _fileRepository.uploadFile(name: name, image: image);
    if (response.status == StatusResponse.success) {
      return response.result ?? '';
    } else {
      Get.showSnackbar(GetSnackBar(
        margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 88.h),
        backgroundColor: kPrimaryColor,
        duration: 2.seconds,
        borderRadius: 8.r,
        messageText: Text(response.message ?? 'Gagal upload image',
            style: text12WhiteRegular),
      ));
      return null;
    }
  }

  void selectMessage(PinnedMessage? chat) {
    log("Pin Id : ${pinnedMessage?.senderId}");
    log("Sender Id : ${chat?.senderId}");

    if (pinnedMessage?.senderId == chat?.senderId) {
      pinnedMessage = null;
      focusNode?.unfocus();
    } else {
      pinnedMessage = chat;
      focusNode?.requestFocus();
    }
    log("Pesan TerPin : ${pinnedMessage?.text}");
    update();
  }

  void cancelPinMessage() {
    pinnedMessage = null;
    update();
  }

  void selectedChatDelet(ChatModel item) {
    isChatDelet.value = true;
    if (selectedItemDelete.contains(item)) {
      selectedItemDelete.remove(item);
    } else {
      selectedItemDelete.add(item);
    }
    update();
    HapticFeedback.mediumImpact();
  }

  void selectedCancelChatDelet(ChatModel item) {
    isChatDelet.value = false;
    if (selectedItemDelete.contains(item)) {
      selectedItemDelete.remove(item);
    }
    update();
  }

  Future<void> deletedChat() async {
    final now = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    List<String> itemTextList = [];
    for (var item in selectedItemDelete) {
      itemTextList.add(item.text ?? '');
    }
    final response = await _chatRepository.deletedChat(
        id: "${dataArgument?.chatId}",
        fromStore: true,
        itemTextList: itemTextList,
        time: formattedDate);
    if (response.result == true) {
      // selectedCancelChatDelet();
      selectedItemDelete.value = [];
      update();
      pagingController.itemList?.clear();
      getChat(0);
    }
  }

  setData() {
    dataArgument = Get.arguments;
  }

  void slidePinChat(DragStartDetails detail, int index, bool sender,
      PinnedMessage pinnedChat) {
    indexSlide.value = index;
    positionSlideChat.value = (detail.globalPosition.dx / 7);
    HapticFeedback.mediumImpact();
    log("Sender : $sender");
    log("Position Slide Chat : ${positionSlideChat.value}");
    Future.delayed(200.milliseconds, () {
      selectMessage(pinnedChat);
      positionSlideChat.value = 0.0;
    });
  }

  void scrollToOriginalMessage(
      String originalText, String role, bool isSender) {
    int originalIndex = pagingController.itemList!.indexWhere(
      (message) =>
          message.text != null &&
          message.text == originalText &&
          message.sender?.role == role,
    );
    if (originalIndex != -1) {
      double totalHeight = 0;
      for (int i = 0; i < originalIndex; i++) {
        double itemHeight = 100;
        totalHeight += itemHeight;
      }
      double offset =
          totalHeight - (scrollController.position.viewportDimension / 2);
      indexScroll(originalIndex);
      isScroolReply(true);

      scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      Future.delayed(800.milliseconds, () {
        isScroolReply(false);
        indexScroll(-1);
      });
    }
  }

  DateTime returnDateAndTimeFormat(String time) {
    var dt = DateTime.parse(time);
    return DateTime(dt.year, dt.month, dt.day);
  }

  String groupMessageDateAndTime(String time) {
    DateTime createdAt = DateTime.parse(time);

    final todayDate = DateTime.now();

    final today = DateTime(todayDate.year, todayDate.month, todayDate.day);
    final yesterday =
        DateTime(todayDate.year, todayDate.month, todayDate.day - 1);
    String difference = '';
    final aDate = DateTime(createdAt.year, createdAt.month, createdAt.day);

    if (aDate == today) {
      difference = "Today";
    } else if (aDate == yesterday) {
      difference = "Yesterday";
    } else {
      difference = DateFormat.yMMMd().format(createdAt).toString();
    }

    return difference;
  }

  @override
  void onInit() {
    setData();
    pagingController.addPageRequestListener((page) {
      getChat(page);

      log(page.toString());
      log(_pageSize.toString());
    });
    scrollController = ScrollController();

    super.onInit();
  }
}
