import 'dart:async';

import 'package:mobile/utils/networks/api_response.dart';

import '../models/race_detail_model.dart';
import '../repositories/race_repository.dart';

class RaceDetailBloc {
  RaceRepository _antRaceRepository = RaceRepository();
  StreamController _antDataController = StreamController<ApiResponse<int>>();
  bool _isStreaming = false;

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
    try {
      RaceDetailModel dataResponse = await _antRaceRepository.fetchRaceDetail({
        'user_id': "0",
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
