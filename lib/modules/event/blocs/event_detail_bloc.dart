import 'dart:async';

import 'package:mobile/utils/networks/api_response.dart';

import '../models/event_detail_model.dart';
import '../repositories/event_repository.dart';

class EventDetailBloc {
  EventRepository _antEventRepository = EventRepository();
  StreamController _antDataController = StreamController<ApiResponse<int>>();
  bool _isStreaming = false;

  StreamSink<dynamic> get antDataSink => _antDataController.sink;
  Stream<dynamic> get antDataStream => _antDataController.stream;

  EventDetailBloc() {
    _antDataController = StreamController<dynamic>();
    _antEventRepository = EventRepository();
    antDataSink.add(ApiResponse.initial(''));
  }

  setInitial() async {
    antDataSink.add(ApiResponse.initial(''));
  }

  fetchResponse(String id) async {
    _isStreaming = true;
    antDataSink.add(ApiResponse.loading(''));
    try {
      EventDetailModel dataResponse = await _antEventRepository.fetchEventDetail({
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
