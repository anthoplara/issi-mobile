import 'dart:async';

import 'package:mobile/utils/networks/api_response.dart';

import '../models/login_check_model.dart';
import '../repositories/login_repository.dart';

class LoginCheckBloc {
  LoginRepository _antLoginRepository = LoginRepository();
  StreamController _antDataController = StreamController<ApiResponse<int>>();
  bool _isStreaming = false;

  StreamSink<dynamic> get antDataSink => _antDataController.sink;
  Stream<dynamic> get antDataStream => _antDataController.stream;

  LoginCheckBloc() {
    _antDataController = StreamController<dynamic>();
    _antLoginRepository = LoginRepository();
    antDataSink.add(ApiResponse.initial(''));
  }

  setInitial() async {
    antDataSink.add(ApiResponse.initial(''));
  }

  fetchResponse(String username) async {
    _isStreaming = true;
    antDataSink.add(ApiResponse.loading(''));
    try {
      LoginCheckModel dataResponse = await _antLoginRepository.fetchLoginCheck({
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
