import 'dart:async';

import 'package:get_storage/get_storage.dart';
import 'package:mobile/utils/networks/api_response.dart';
import 'package:mobile/utils/networks/key_storage.dart';

import '../models/join_event_model.dart';
import '../repositories/joint_event_repository.dart';

class JoinEventBloc {
  JoinEventRepository _antJoinEventRepository = JoinEventRepository();
  StreamController _antDataController = StreamController<ApiResponse<int>>();
  bool _isStreaming = false;

  GetStorage localData = GetStorage();

  StreamSink<dynamic> get antDataSink => _antDataController.sink;
  Stream<dynamic> get antDataStream => _antDataController.stream;

  JoinEventBloc() {
    _antDataController = StreamController<dynamic>();
    _antJoinEventRepository = JoinEventRepository();
    antDataSink.add(ApiResponse.initial(''));
  }

  setInitial() {
    _isStreaming = false;
    antDataSink.add(ApiResponse.initial(''));
  }

  fetchResponse(String id) async {
    _isStreaming = true;
    antDataSink.add(ApiResponse.loading(''));
    String userId = localData.read(KeyStorage.userId) ?? "0";
    try {
      JoinEventModel dataResponse = await _antJoinEventRepository.fetchJoinEvent({
        'user_id': userId,
        'event_id': id,
      });
      if (_isStreaming) {
        if (dataResponse.error ?? true) {
          antDataSink.add(ApiResponse.completed("0"));
        } else {
          antDataSink.add(ApiResponse.completed("1"));
        }
      } else {
        antDataSink.add(ApiResponse.initial(''));
      }
    } catch (e) {
      if (_isStreaming) {
        antDataSink.add(ApiResponse.completed("0"));
      }
    }
  }

  dispose() {
    _isStreaming = false;
    antDataSink.close();
    _antDataController.close();
  }
}
