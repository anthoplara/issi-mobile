import 'dart:async';

import 'package:get_storage/get_storage.dart';
import 'package:mobile/utils/networks/api_response.dart';
import 'package:mobile/utils/networks/key_storage.dart';

import '../models/race_detail_model.dart';
import '../repositories/race_repository.dart';

class RaceDetailBloc {
  RaceRepository _antRaceRepository = RaceRepository();
  StreamController _antDataController = StreamController<ApiResponse<int>>();
  bool _isStreaming = false;

  GetStorage localData = GetStorage();

  StreamSink<dynamic> get antDataSink => _antDataController.sink;
  Stream<dynamic> get antDataStream => _antDataController.stream;

  RaceDetailBloc() {
    _antDataController = StreamController<dynamic>();
    _antRaceRepository = RaceRepository();
    antDataSink.add(ApiResponse.initial(''));
  }

  setInitial() async {
    antDataSink.add(ApiResponse.initial(''));
  }

  fetchResponse(String id) async {
    _isStreaming = true;
    antDataSink.add(ApiResponse.loading(''));
    String userId = localData.read(KeyStorage.userId) ?? "0";
    try {
      RaceDetailModel dataResponse = await _antRaceRepository.fetchRaceDetail({
        'user_id': userId,
        'event_id': id,
      });
      if (_isStreaming) {
        antDataSink.add(ApiResponse.completed(dataResponse));
      }
    } catch (e) {
      if (_isStreaming) {
        antDataSink.add(ApiResponse.error(
          'Server error, hubungi tim teknis',
        ));
      }
    }
  }

  dispose() {
    _isStreaming = false;
    _antDataController.close();
  }
}
