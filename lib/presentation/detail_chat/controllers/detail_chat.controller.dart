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
import 'package:jetmarket/domain/core/model/params/chat/pinned_chat.dart';
import 'package:jetmarket/utils/app_preference/app_preferences.dart';

import '../../../domain/core/interfaces/file_repository.dart';
import '../../../infrastructure/theme/app_colors.dart';
import '../../../infrastructure/theme/app_text.dart';
import '../../../utils/network/status_response.dart';

class DetailChatController extends GetxController {
  final FileRepository _fileRepository;
  final ChatRepository _chatRepository;
  DetailChatController(this._fileRepository, this._chatRepository);
  ScrollController scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();
  FocusNode? focusNode;
  var isSlideChat = false.obs;
  var isChatDelet = false.obs;
  var selectedIndexDelete = 1000.obs;
  static const _pageSize = 10;
  Seller? seller;
  Variants? variants;
  bool isSendProduct = false;
  int maxLines = 1;
  String? imageUrl;
  PinnedChat? selectedPinnedMessage;
  final CollectionReference chatCollection =
      FirebaseFirestore.instance.collection('chat');
  PagingController<int, ChatModel> pagingController =
      PagingController(firstPageKey: 1);
  bool isScroolBottom = false;

  Future<void> getChat(int pageKey) async {
    int id = AppPreference().getUserData()?.user?.id ?? 0;
    String chatId = "2#1#1";
    var param =
        ChatParam(id: id, chatIdStore: chatId, page: pageKey, size: _pageSize);
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
    final now = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    final Map<String, dynamic> data = <String, dynamic>{};
    final Map<String, dynamic> dataProduct = <String, dynamic>{};
    final Map<String, dynamic> dataMessage = <String, dynamic>{};
    final Map<String, dynamic> dataOrder = <String, dynamic>{};

    data['created_at'] = formattedDate;
    data['deleted_at'] = null;
    data['from_id'] = 1;
    data['id'] = 2;
    data['image'] = imageUrl;
    data['read_at'] = null;
    data['text'] = messageController.text;
    data['to_id'] = 1;

    dataProduct['id'] = variants?.id;
    dataProduct['image'] = variants?.image;
    dataProduct['name'] = variants?.name;
    dataProduct['price'] = variants?.price;
    dataProduct['promo'] = variants?.promo;
    dataProduct.removeWhere((key, value) => value == null || value == '');
    // data['pinned_product'] = dataProduct;

    dataMessage['id'] = selectedPinnedMessage?.id;
    dataMessage['message'] = selectedPinnedMessage?.message;
    dataMessage.removeWhere((key, value) => value == null || value == '');
    data['pinned_message'] = dataMessage;

    dataOrder['address'] = null;
    dataOrder['address_id'] = null;
    dataOrder['customer_id'] = null;
    dataOrder['customer_name'] = null;
    dataOrder['lat'] = null;
    dataOrder['lng'] = null;
    dataOrder['order_id'] = null;
    dataOrder['status'] = null;
    dataOrder.removeWhere((key, value) => value == null || value == '');
    data['pinned_order'] = dataOrder;

    data.removeWhere((key, value) =>
        value == null || value == '' || (value is Map && value.isEmpty));
    send("2#1#1", data);
  }

  Future<void> send(String documentTitle, Map<String, dynamic> message) async {
    try {
      final docSnapshot = await chatCollection.doc(documentTitle).get();
      final now = DateTime.now();
      final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
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
      selectedPinnedMessage = null;
      maxLines = 1;
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500), // durasi animasi
        curve: Curves.easeOut, // kurva animasi
      );

      update();
    } catch (error) {
      throw Exception(error);
      // Handle error appropriately
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

  void selectMessage(PinnedChat chat) {
    if (selectedPinnedMessage?.message == chat.message) {
      selectedPinnedMessage = null;
      focusNode?.unfocus();
    } else {
      selectedPinnedMessage = chat;
      focusNode?.requestFocus();
    }
    update();
  }

  void cancelPinMessage() {
    selectedPinnedMessage = null;
    update();
  }

  void selectedChatDelet(int index) {
    isChatDelet.value = true;
    selectedIndexDelete.value = index;
    update();
    HapticFeedback.mediumImpact();
  }

  void selectedCancelChatDelet() {
    isChatDelet.value = false;
    selectedIndexDelete.value = 1000;
    update();
  }

  Future<void> deletedChat() async {
    final now = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    final response = await _chatRepository.deletedChat(
        fromStore: true,
        dataIndex: selectedIndexDelete.value,
        time: formattedDate);
    if (response.result == true) {
      selectedCancelChatDelet();
      pagingController.itemList?.clear();
      getChat(1);
    }
  }

  setData() {
    seller = Get.arguments[0];
    if (Get.arguments[1] != null) {
      variants = Get.arguments[1];
      isSendProduct = true;
      update();
      // sendNewMessage();
    }
  }

  var positionSlideChat = 0.0.obs;
  var indexSlide = 1000.obs;
  void slidePinChat(
      DragStartDetails detail, int index, bool sender, PinnedChat pinnedChat) {
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
        duration: 200.milliseconds, // durasi animasi
        curve: Curves.easeOut, // kurva animasi
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
