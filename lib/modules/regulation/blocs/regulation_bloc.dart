import 'dart:async';

import 'package:mobile/utils/networks/api_response.dart';

import '../models/regulation_model.dart';
import '../repositories/regulation_repository.dart';

class RegulationBloc {
  RegulationRepository _antRegulationRepository = RegulationRepository();
  StreamController _antDataController = StreamController<ApiResponse<int>>();
  bool _isStreaming = false;

  StreamSink<dynamic> get antDataSink => _antDataController.sink;
  Stream<dynamic> get antDataStream => _antDataController.stream;

  RegulationBloc() {
    _antDataController = StreamController<dynamic>();
    _antRegulationRepository = RegulationRepository();
    antDataSink.add(ApiResponse.initial(''));
  }

  setInitial() async {
    antDataSink.add(ApiResponse.initial(''));
  }

  fetchResponse() async {
    _isStreaming = true;
    antDataSink.add(ApiResponse.loading(''));
    try {
      RegulationModel dataResponse = await _antRegulationRepository.fetchRegulation();
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
