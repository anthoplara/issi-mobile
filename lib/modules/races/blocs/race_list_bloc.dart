import 'dart:async';

import 'package:mobile/utils/networks/api_response.dart';

import '../models/race_list_model.dart';
import '../repositories/race_repository.dart';

class RaceListBloc {
  RaceRepository _antRaceRepository = RaceRepository();
  StreamController _antDataController = StreamController<ApiResponse<int>>();
  bool _isStreaming = false;

  StreamSink<dynamic> get antDataSink => _antDataController.sink;
  Stream<dynamic> get antDataStream => _antDataController.stream;

  RaceListBloc() {
    _antDataController = StreamController<dynamic>();
    _antRaceRepository = RaceRepository();
    antDataSink.add(ApiResponse.initial(''));
  }

  setInitial() async {
    antDataSink.add(ApiResponse.initial(''));
  }

  fetchResponse(int page, int limit) async {
    _isStreaming = true;
    antDataSink.add(ApiResponse.loading(''));
    try {
      RaceListModel dataResponse = await _antRaceRepository.fetchRaceList({
        'page': page.toString(),
        'limit': limit.toString(),
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
