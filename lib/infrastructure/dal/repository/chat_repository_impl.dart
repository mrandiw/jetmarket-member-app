import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:jetmarket/domain/core/interfaces/chat_repository.dart';
import 'package:jetmarket/domain/core/model/model_data/chat_model.dart';
import 'package:jetmarket/domain/core/model/params/chat/chat_param.dart';
import 'package:jetmarket/infrastructure/dal/daos/provider/endpoint/endpoint.dart';
import 'package:jetmarket/infrastructure/dal/daos/provider/remote/remote_provider.dart';
import 'package:jetmarket/utils/app_preference/app_preferences.dart';

import '../../../utils/network/code_response.dart';
import '../../../utils/network/custom_exception.dart';
import '../../../utils/network/data_state.dart';

class ChatRepositoryImpl implements ChatRepository {
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
  Future<DataState<List<ChatModel>>> getChat(ChatParam param) async {
    try {
      if (param.page == 1) {
        final responseStore = await getChatFromStore(param.chatIdStore);
        return DataState<List<ChatModel>>(result: responseStore.result);
      } else {
        final response = await RemoteProvider.get(
            path: '${Endpoint.chat}/${param.id}',
            queryParameters: param.toMap());
        List<dynamic> datas = response.data['data']['items'];
        return DataState<List<ChatModel>>(
            result: datas
                .map((e) => ChatModel.fromJson(e)..fromStore = false)
                .toList(),
            status: StatusCodeResponse.cek(response: response));
      }
    } on DioException catch (e) {
      return CustomException<List<ChatModel>>().dio(e);
    }
  }

  @override
  Future<DataState<bool>> deletedChat(
      {required bool fromStore,
      required int dataIndex,
      required String time}) async {
    try {
      if (fromStore) {
        final responseStore = await updateChatFromStore(
            id: '2#1#1', dataIndex: dataIndex, time: time);
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
  Future<DataState<List<ChatModel>>> getChatFromStore(String id) async {
    final CollectionReference chatCollection =
        FirebaseFirestore.instance.collection('chat');
    try {
      final querySnapshot = await chatCollection.doc(id).get();
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
    required int dataIndex,
    required String time,
  }) async {
    final CollectionReference chatCollection =
        FirebaseFirestore.instance.collection('chat');
    try {
      final docSnapshot = await chatCollection.doc(id).get();
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

        if (dataIndex >= 0 && dataIndex < resultList.length) {
          resultList[dataIndex]['deleted_at'] = time;
          await chatCollection.doc(id).update({
            firstKey: resultList,
          });
          return DataState(result: true);
        } else {
          return DataState(result: false);
        }
      }

      return DataState<bool>();
    } on DioException catch (e) {
      return CustomException<bool>().dio(e);
    }
  }
}
