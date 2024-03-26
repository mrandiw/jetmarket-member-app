import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
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
import 'package:jetmarket/domain/core/model/params/chat/chat_update_param.dart';
import 'package:jetmarket/utils/app_preference/app_preferences.dart';
import '../../../../domain/core/interfaces/file_repository.dart';
import '../../../../domain/core/model/argument/chat_room_argument.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/network/status_response.dart';
import '../../../main_pages/controllers/main_pages.controller.dart';

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
  bool isFirst = true;
  bool isReverse = false;
  bool isNewChat = false;
  int lenghtDataStore = 0;

  StreamSubscription<List<ChatModel>>? chatStreamSubscription;

  PagingController<int, ChatModel> pagingController =
      PagingController(firstPageKey: 0);

  Future<void> getChat(int pageKey) async {
    try {
      List<ChatModel>? response;

      if (pageKey > 0) {
        _pageSize = 10;
        response = await getChatFromApi(pageKey);
        if (isFirst) {
          serReciveIfNull();
        }
      } else {
        await for (final data in getChatStream()) {
          response = data.reversed.toList();
        }

        _pageSize = response!.length;
      }

      final isLastPage = response.length < _pageSize;

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
    var param = ChatParam(
        id: dataArgument?.chatId ?? 0,
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
    final now = DateTime.now().toUtc();
    var firstReceiver = pagingController
        .itemList![pagingController.itemList!.length - 1].receiver;
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
        id: dataArgument?.toId ?? firstReceiver?.id,
        name: dataArgument?.name ?? firstReceiver?.name,
        image: dataArgument?.image ?? firstReceiver?.image,
        role: dataArgument?.toRole ?? firstReceiver?.role);
    var dataChat = ChatModel(
        createdAt: now.toString(),
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

    isNewChat = true;
    final response = await _chatRepository.sendMessage(
        documentTitle: "${dataArgument?.chatId}", message: dataChat.toMap());
    if (response.result == true) {
      var param = ChatUpdateParam(
          chatId: dataArgument?.chatId,
          senderName: sender.name,
          message: dataChat.text);
      isCurrnetPositionOnTop(false);
      messageController.clear();
      imageUrl = null;
      variants = null;
      pinnedMessage = null;
      maxLines = 1;
      update();
      log(param.toJson().toString());
      final updateChat = await _chatRepository.updateChat(param);
      if (updateChat.result == true) {
        scrollController.animateTo(
          0,
          duration: 300.milliseconds,
          curve: Curves.easeInOut,
        );
      }
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
    log("Sender S : ${chat?.senderId}");
    log("Pinned Message : ${pinnedMessage?.senderId}");
    pinnedMessage = chat;
    focusNode?.requestFocus();
    update();
  }

  void cancelPinMessage() {
    pinnedMessage = null;
    update();
  }

  void selectedChatDelet(ChatModel item) {
    if (item.sender?.role == 'customer') {
      isChatDelet.value = true;
      if (selectedItemDelete.contains(item)) {
        selectedItemDelete.remove(item);
      } else {
        selectedItemDelete.add(item);
      }
      update();
      HapticFeedback.mediumImpact();
    }
  }

  void selectedCancelChatDelet(ChatModel item) {
    isChatDelet.value = false;
    if (selectedItemDelete.contains(item)) {
      selectedItemDelete.remove(item);
    }
    update();
  }

  List<String> itemFromStore = [];
  List<int> itemDelete = [];

  Future<void> deletedChat() async {
    final now = DateTime.now().toUtc();

    for (var item in selectedItemDelete) {
      if (item.fromStore == true) {
        itemFromStore.add(item.createdAt ?? '');
      }
      if (item.fromStore == false) {
        itemDelete.add(item.id ?? 0);
      }
    }
    if (itemFromStore.isNotEmpty) {
      final response = await _chatRepository.deletedChatFromStore(
          id: "${dataArgument?.chatId}",
          itemCreatedAt: itemFromStore,
          time: now.toString());
      if (response.result == true) {
        selectedItemDelete.value = [];
        itemFromStore.clear();
        update();
      }
    }
    if (itemDelete.isNotEmpty) {
      final response = await _chatRepository.deletedChat(
          id: "${dataArgument?.chatId}",
          fromStore: false,
          itemId: itemDelete,
          time: now.toString());
      if (response.result == true) {
        selectedItemDelete.value = [];
        updateDeleted();
        update();
      }
    }
  }

  setData() {
    dataArgument = Get.arguments;
  }

  serReciveIfNull() {
    if (dataArgument?.toId == null) {
      var firstReceiver = pagingController
          .itemList![pagingController.itemList!.length - 1].receiver;
      dataArgument?.toId = firstReceiver?.id;
      dataArgument?.toRole = firstReceiver?.role;
      dataArgument?.name = firstReceiver?.name;
      dataArgument?.image = firstReceiver?.image;
      update();
    } else {}
    isFirst = false;
  }

  void slidePinChat(DragStartDetails detail, int index, bool sender,
      PinnedMessage pinnedChat) {
    indexSlide.value = index;
    positionSlideChat.value = (detail.globalPosition.dx / 7);
    HapticFeedback.mediumImpact();
    Future.delayed(200.milliseconds, () {
      selectMessage(pinnedChat);
      positionSlideChat.value = 0.0;
    });
  }

  void scrollToOriginalMessage(String originalText, String role, int id) {
    int originalIndex = pagingController.itemList!.indexWhere((message) =>
        message.text != null &&
        message.text == originalText &&
        message.sender?.role == role &&
        message.id == id);
    if (originalIndex != -1) {
      double totalHeight = 0;
      for (int i = 0; i < originalIndex; i++) {
        double itemHeight = 110;
        totalHeight += itemHeight;
      }
      double offset =
          totalHeight - (scrollController.position.viewportDimension / 2);
      indexScroll(originalIndex);
      isScroolReply(true);

      scrollController
          .animateTo(
        offset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      )
          .whenComplete(() {
        Future.delayed(300.milliseconds, () {
          isScroolReply(false);
          indexScroll(-1);
        });
      });
    }
  }

  DateTime returnDateAndTimeFormat(String time) {
    try {
      var dt = DateTime.parse(time);
      return DateTime(dt.year, dt.month, dt.day);
    } catch (e) {
      return DateTime.now();
    }
  }

  String groupMessageDateAndTime(String time) {
    try {
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
    } catch (e) {
      return time;
    }
  }

  void listenToChatStream(String id) {
    int beforeLengthStore = 0;
    chatStreamSubscription = _chatRepository
        .listenStore(id)
        .listen((List<ChatModel> chatList) async {
      int newLengthStore = chatList.length;
      lenghtDataStore = chatList.length;
      isNewChat = newLengthStore > beforeLengthStore;
      beforeLengthStore = newLengthStore;
      if (chatList.isNotEmpty) {
        ChatModel latestChat = chatList[chatList.length - 1];
        if (isNewChat) {
          isNewChat = false;
          pagingController.itemList?.insert(0, latestChat);
          _pageSize = chatList.length;
          update();
        } else if (!isNewChat) {
          pagingController.itemList
              ?.replaceRange(0, chatList.length, chatList.reversed.toList());
          update();
        }
      } else {
        _pageSize = 10;
        final response = await getChatFromApi(1);
        pagingController.appendPage(response, 2);
      }
      return;
    });
  }

  void updateDeleted() async {
    for (int i = 0; i < itemDelete.length; i++) {
      var deleteId = itemDelete[i];
      for (int index = lenghtDataStore;
          index < pagingController.itemList!.length;
          index++) {
        if (pagingController.itemList![index].id == deleteId) {
          final now = DateTime.now().toUtc();
          pagingController.itemList![index].deletedAt = now.toString();
          break;
        }
      }
    }
    itemDelete.clear();
    update();
  }

  Future<bool> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
      FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
      return true;
    } else {
      return false;
    }
  }

  void _handleMessage(RemoteMessage message) async {
    log("Data : ${message.data}");
    log("Pagelink : ${message.data['pagelink']}");
    log("Body : ${message.notification?.body}");
  }

  void backAction() {
    if (dataArgument?.lifecycle != null) {
      Get.offNamed(Routes.MAIN_PAGES);
      Get.put(MainPagesController());
    } else {
      Get.back();
    }
  }

  @override
  void onInit() {
    setupInteractedMessage();
    setData();
    pagingController.addPageRequestListener((page) {
      getChat(page);
    });
    listenToChatStream("${dataArgument?.chatId}");
    scrollController = ScrollController();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
    chatStreamSubscription?.cancel();
  }
}
