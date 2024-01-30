import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:jetmarket/domain/core/interfaces/chat_repository.dart';
import 'package:jetmarket/domain/core/model/model_data/chat_model.dart';
import 'package:jetmarket/domain/core/model/model_data/list_chat_model.dart';
import 'package:jetmarket/domain/core/model/params/chat/chat_param.dart';
import 'package:jetmarket/infrastructure/dal/daos/provider/endpoint/endpoint.dart';
import 'package:jetmarket/infrastructure/dal/daos/provider/remote/remote_provider.dart';
import 'package:jetmarket/utils/app_preference/app_preferences.dart';

import '../../../domain/core/model/model_data/check_existing_model.dart';
import '../../../domain/core/model/model_data/create_chat_model.dart';
import '../../../domain/core/model/params/chat/check_existing_param.dart';
import '../../../domain/core/model/params/chat/create_chat_param.dart';
import '../../../utils/network/code_response.dart';
import '../../../utils/network/custom_exception.dart';
import '../../../utils/network/data_state.dart';

class ChatRepositoryImpl implements ChatRepository {
  late final CollectionReference _chatCollection;

  ChatRepositoryImpl() {
    _chatCollection = FirebaseFirestore.instance.collection('chat');
  }

  @override
  Future<DataState<List<dynamic>>> getProviousChat() async {
    try {
      final response = await Dio().get('http://192.168.129.236:3002/chat',
          options: Options(headers: {
            'Authorization': 'Bearer ${AppPreference().getAccessToken()}'
          }));
      // List<dynamic> datas = response.data['data']['items'];
      return DataState<List<dynamic>>(
          result: response.data['data']['items'],
          status: StatusCodeResponse.cek(response: response));
    } on DioException catch (e) {
      return CustomException<List<dynamic>>().dio(e);
    }
  }

  @override
  Future<DataState<List<ListChatModel>>> getListChat(
      {required int page, required int size}) async {
    try {
      final response = await RemoteProvider.get(
          path: Endpoint.chat, queryParameters: {'page': page, 'size': size});
      List<dynamic> datas = response.data['data']['items'];
      return DataState<List<ListChatModel>>(
          result: datas.map((e) => ListChatModel.fromJson(e)).toList(),
          status: StatusCodeResponse.cek(response: response));
    } on DioException catch (e) {
      return CustomException<List<ListChatModel>>().dio(e);
    }
  }

  @override
  Future<DataState<List<ChatModel>>> getChat(ChatParam param) async {
    try {
      final response = await RemoteProvider.get(
        path: '${Endpoint.chat}/${param.id}',
        queryParameters: param.toMap(),
      );
      List<dynamic> datas = response.data['data']['items'];
      return DataState<List<ChatModel>>(
          result: datas
              .map((e) => ChatModel.fromJson(e)..fromStore = false)
              .toList());
    } on DioException catch (e) {
      return CustomException<List<ChatModel>>().dio(e);
    }
  }

  @override
  Future<DataState<bool>> deletedChat(
      {required bool fromStore,
      required String id,
      required List<String> itemTextList,
      required String time}) async {
    try {
      if (fromStore) {
        final responseStore = await updateChatFromStore(
            id: id, itemTextList: itemTextList, time: time);
        return DataState<bool>(result: responseStore.result);
      } else {
        return DataState<bool>(result: false);

        // final response = await RemoteProvider.get(
        //     path: '${Endpoint.chat}/${param.id}',
        //     queryParameters: param.toMap());
        // List<dynamic> datas = response.data['data']['items'];
        // return DataState<bool>(
        //     result: datas.map((e) => ChatModel.fromJson(e)).toList(),
        //     status: StatusCodeResponse.cek(response: response));
      }
    } on DioException catch (e) {
      return CustomException<bool>().dio(e);
    }
  }

  @override
  Future<DataState<CheckExistingModel>> checkExisting(
      CheckExisting param) async {
    try {
      final response = await RemoteProvider.get(
          path: Endpoint.chatCheckExisting, queryParameters: param.toMap());
      return DataState<CheckExistingModel>(
          result: CheckExistingModel.fromJson(response.data['data']),
          status: StatusCodeResponse.cek(response: response, showLogs: true));
    } on DioException catch (e) {
      return CustomException<CheckExistingModel>().dio(e);
    }
  }

  @override
  Future<DataState<CreateChatModel>> createChat(CreateChatParam param) async {
    try {
      final response =
          await RemoteProvider.post(path: Endpoint.chat, data: param.toMap());
      return DataState<CreateChatModel>(
          result: CreateChatModel.fromJson(response.data['data']),
          status: StatusCodeResponse.cek(response: response, showLogs: true));
    } on DioException catch (e) {
      return CustomException<CreateChatModel>().dio(e);
    }
  }

  // From Firestore

  @override
  Future<DataState<List<ChatModel>>> getChatFromStore(String id) async {
    try {
      final querySnapshot = await _chatCollection.doc(id).get();
      final data = querySnapshot.data();
      String? firstKey;
      Map<String, dynamic>? dataMap;
      if (data != null && data is Map) {
        dataMap = Map<String, dynamic>.from(data);
        if (dataMap.isNotEmpty) {
          firstKey = dataMap.keys.first;
        }
      }
      List<Map<String, dynamic>> resultList;
      if (firstKey != null) {
        resultList = dataMap?[firstKey]!.cast<Map<String, dynamic>>() ?? [];
      } else {
        resultList = [];
      }
      return DataState<List<ChatModel>>(
        result: resultList
            .map((e) => ChatModel.fromJson(e)..fromStore = true)
            .toList(),
      );
    } on DioException catch (e) {
      return CustomException<List<ChatModel>>().dio(e);
    }
  }

  @override
  Future<DataState<bool>> updateChatFromStore({
    required String id,
    required List<String> itemTextList,
    required String time,
  }) async {
    try {
      final docSnapshot = await _chatCollection.doc(id).get();
      final data = docSnapshot.data();
      String? firstKey;
      Map<String, dynamic>? dataMap;
      if (data != null && data is Map) {
        dataMap = Map<String, dynamic>.from(data);
        if (dataMap.isNotEmpty) {
          firstKey = dataMap.keys.first;
        }
      }

      if (firstKey != null) {
        List<Map<String, dynamic>> resultList =
            dataMap?[firstKey]!.cast<Map<String, dynamic>>() ?? [];
        for (String itemText in itemTextList) {
          int foundIndex =
              resultList.indexWhere((element) => element['text'] == itemText);

          if (foundIndex != -1) {
            resultList[foundIndex]['deleted_at'] = time;
          }
        }
        await _chatCollection.doc(id).update({
          firstKey: resultList,
        });

        return DataState(result: true);
      }

      return DataState<bool>();
    } on DioException catch (e) {
      return CustomException<bool>().dio(e);
    }
  }

  @override
  Future<DataState<bool>> createDocument(int id) async {
    try {
      final DocumentReference docRef = _chatCollection.doc(id.toString());
      Map<String, dynamic> data = {};
      await docRef.set(data);
      return DataState(result: true);
    } on DioException catch (e) {
      return CustomException<bool>().dio(e);
    }
  }

  @override
  Stream<List<ChatModel>> streamChatFromStore(String id) async* {
    try {
      final querySnapshot = await _chatCollection.doc(id).get();
      final data = querySnapshot.data();
      String? firstKey;
      Map<String, dynamic>? dataMap;
      if (data != null && data is Map) {
        dataMap = Map<String, dynamic>.from(data);
        if (dataMap.isNotEmpty) {
          firstKey = dataMap.keys.first;
        }
      }
      List<Map<String, dynamic>> resultList;
      if (firstKey != null) {
        resultList = dataMap?[firstKey]!.cast<Map<String, dynamic>>() ?? [];
      } else {
        resultList = [];
      }
      log("Panjang Chat : ${resultList.length}");
      yield resultList
          .map((e) => ChatModel.fromJson(e)..fromStore = true)
          .toList();
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<DataState<bool>> sendMessage(
      {required String documentTitle,
      required Map<String, dynamic> message}) async {
    try {
      final docSnapshot = await _chatCollection.doc(documentTitle).get();
      final now = DateTime.now();
      final formattedDate = DateFormat('yyyy-MM-dd').format(now);
      final messages = [message];
      final document = docSnapshot.data() as Map<String, dynamic>;
      if (document.isEmpty) {
        await _chatCollection.doc(documentTitle).set({
          formattedDate: messages,
        });
      } else {
        Map<String, dynamic> data =
            json.decode(json.encode(docSnapshot.data()));
        String key = data.keys.first;
        await _chatCollection
            .doc(documentTitle)
            .update({key: FieldValue.arrayUnion(messages)});
      }
      return DataState(result: true, message: 'Success');
    } on FirebaseException catch (e) {
      return DataState(result: false, message: e.message.toString());
    }
  }
}
