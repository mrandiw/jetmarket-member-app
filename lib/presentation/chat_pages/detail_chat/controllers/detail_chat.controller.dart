import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:jetmarket/domain/core/interfaces/chat_repository.dart';
import 'package:jetmarket/domain/core/model/model_data/chat_model.dart';
import 'package:jetmarket/domain/core/model/model_data/detail_product.dart';
import 'package:jetmarket/domain/core/model/params/chat/chat_param.dart';
import 'package:jetmarket/utils/app_preference/app_preferences.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../domain/core/interfaces/file_repository.dart';
import '../../../../domain/core/model/argument/chat_room_argument.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/network/status_response.dart';

class DetailChatController extends GetxController {
  final FileRepository _fileRepository;
  final ChatRepository _chatRepository;
  DetailChatController(this._fileRepository, this._chatRepository);
  ScrollController scrollController = ScrollController();
  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  TextEditingController messageController = TextEditingController();

  ChatRoomArgument? dataArgument;

  FocusNode? focusNode;
  var isSlideChat = false.obs;
  var isChatDelet = false.obs;
  // var selectedIndexDelete = 1000.obs;
  var selectedItemDelete = <ChatModel>[].obs;
  static const _pageSize = 10;
  Seller? seller;
  Variants? variants;
  bool isSendProduct = false;
  int maxLines = 1;
  String? imageUrl;
  PinnedMessage? pinnedMessage;
  bool isScroolBottom = false;
  final CollectionReference chatCollection =
      FirebaseFirestore.instance.collection('chat');

  PagingController<int, ChatModel> pagingController =
      PagingController(firstPageKey: 1);

  Future<void> getChat(int pageKey) async {
    int id = AppPreference().getUserData()?.user?.id ?? 0;
    var param = ChatParam(
        id: id,
        chatIdStore: "${dataArgument?.chatId}",
        page: pageKey,
        size: _pageSize);
    try {
      final response = await _chatRepository.getChat(param);
      final isLastPage = response.result!.length < _pageSize;

      if (isLastPage) {
        pagingController.appendLastPage(response.result ?? []);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(response.result ?? [], nextPageKey);
      }
      if (!isScroolBottom) {
        scroolToNewChat();
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  void sendNewMessage() {
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
        id: dataArgument?.fromId,
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

    send("${dataArgument?.chatId}", dataChat.toMap());
  }

  Future<void> send(String documentTitle, Map<String, dynamic> message) async {
    try {
      final docSnapshot = await chatCollection.doc(documentTitle).get();
      final now = DateTime.now();
      final formattedDate = DateFormat('yyyy-MM-dd').format(now);
      final messages = [message];
      final document = docSnapshot.data() as Map<String, dynamic>;
      if (document.isEmpty) {
        await chatCollection.doc(documentTitle).set({
          formattedDate: messages,
        });
      } else {
        Map<String, dynamic> data =
            json.decode(json.encode(docSnapshot.data()));
        String key = data.keys.first;
        await chatCollection
            .doc(documentTitle)
            .update({key: FieldValue.arrayUnion(messages)});
      }
      pagingController.itemList?.clear();
      getChat(1);
      messageController.clear();
      imageUrl = null;
      variants = null;
      pinnedMessage = null;
      maxLines = 1;
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );

      update();
    } catch (error) {
      throw Exception(error);
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
    if (pinnedMessage?.senderId == chat?.senderId) {
      pinnedMessage = null;
      focusNode?.unfocus();
    } else {
      pinnedMessage = chat;

      focusNode?.requestFocus();
    }
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
      pagingController.itemList?.clear();
      getChat(1);
    }
  }

  setData() {
    dataArgument = Get.arguments;
  }

  var positionSlideChat = 0.0.obs;
  var indexSlide = 1000.obs;
  void slidePinChat(DragStartDetails detail, int index, bool sender,
      PinnedMessage pinnedChat) {
    indexSlide.value = index;

    positionSlideChat.value = (detail.globalPosition.dx / 7);
    HapticFeedback.mediumImpact();
    if (sender && positionSlideChat.value > 20 ||
        !sender && positionSlideChat.value > 8) {
      Future.delayed(100.milliseconds, () {
        selectMessage(pinnedChat);
        positionSlideChat.value = 0.0;
      });
    }
  }

  Future<void> scroolToNewChat() async {
    await Future.delayed(300.milliseconds, () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: 200.milliseconds,
        curve: Curves.easeOut,
      );
      isScroolBottom = true;
    });
  }

  @override
  void onInit() {
    setData();
    pagingController.addPageRequestListener((page) {
      getChat(page);
    });

    super.onInit();
  }
}
