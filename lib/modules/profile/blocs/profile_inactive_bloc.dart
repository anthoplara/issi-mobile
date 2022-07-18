import 'dart:async';

import 'package:mobile/utils/networks/api_response.dart';

import '../models/user_delete_model.dart';
import '../repositories/profile_repository.dart';

class ProfileInactiveBloc {
  ProfileRepository _antProfileRepository = ProfileRepository();
  StreamController _antDataController = StreamController<ApiResponse<int>>();
  bool _isStreaming = false;

  StreamSink<dynamic> get antDataSink => _antDataController.sink;
  Stream<dynamic> get antDataStream => _antDataController.stream;

  ProfileInactiveBloc() {
    _antDataController = StreamController<dynamic>();
    _antProfileRepository = ProfileRepository();
    antDataSink.add(ApiResponse.initial(''));
  }

  setInitial() async {
    antDataSink.add(ApiResponse.initial(''));
  }

  fetchResponse(String username) async {
    _isStreaming = true;
    antDataSink.add(ApiResponse.loading(''));
    try {
      UserDeleteModel dataResponse = await _antProfileRepository.fetchIncative({
        'username': username,
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
