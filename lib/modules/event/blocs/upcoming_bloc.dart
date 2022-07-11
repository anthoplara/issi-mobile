import 'dart:async';

import 'package:get_storage/get_storage.dart';
import 'package:mobile/utils/networks/api_response.dart';
import 'package:mobile/utils/networks/key_storage.dart';

import '../models/upcoming_list_model.dart';
import '../repositories/upcoming_repository.dart';

class UpcomingBloc {
  UpcomingRepository _antUpcomingRepository = UpcomingRepository();
  StreamController _antDataController = StreamController<ApiResponse<int>>();
  bool _isStreaming = false;

  GetStorage localData = GetStorage();

  StreamSink<dynamic> get antDataSink => _antDataController.sink;
  Stream<dynamic> get antDataStream => _antDataController.stream;

  UpcomingBloc() {
    _antDataController = StreamController<dynamic>();
    _antUpcomingRepository = UpcomingRepository();
    antDataSink.add(ApiResponse.initial(''));
  }

  setInitial() async {
    antDataSink.add(ApiResponse.initial(''));
  }

  fetchResponse(int page, int limit) async {
    _isStreaming = true;
    antDataSink.add(ApiResponse.loading(''));
    String userId = localData.read(KeyStorage.userId) ?? "0";
    try {
      UpcomingListModel dataResponse = await _antUpcomingRepository.fetchEventList({
        'user_id': userId,
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
