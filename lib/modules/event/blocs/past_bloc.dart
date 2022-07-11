import 'dart:async';

import 'package:get_storage/get_storage.dart';
import 'package:mobile/utils/networks/api_response.dart';
import 'package:mobile/utils/networks/key_storage.dart';

import '../models/past_list_model.dart';
import '../repositories/past_repository.dart';

class PastBloc {
  PastRepository _antPastRepository = PastRepository();
  StreamController _antDataController = StreamController<ApiResponse<int>>();
  bool _isStreaming = false;

  GetStorage localData = GetStorage();

  StreamSink<dynamic> get antDataSink => _antDataController.sink;
  Stream<dynamic> get antDataStream => _antDataController.stream;

  PastBloc() {
    _antDataController = StreamController<dynamic>();
    _antPastRepository = PastRepository();
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
      PastListModel dataResponse = await _antPastRepository.fetchEventList({
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
