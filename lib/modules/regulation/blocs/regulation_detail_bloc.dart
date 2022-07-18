import 'dart:async';

import 'package:mobile/utils/networks/api_response.dart';

import '../models/regulation_detail_model.dart';
import '../repositories/regulation_repository.dart';

class RegulationDetailBloc {
  RegulationRepository _antRegulationRepository = RegulationRepository();
  StreamController _antDataController = StreamController<ApiResponse<int>>();
  bool _isStreaming = false;

  StreamSink<dynamic> get antDataSink => _antDataController.sink;
  Stream<dynamic> get antDataStream => _antDataController.stream;

  RegulationDetailBloc() {
    _antDataController = StreamController<dynamic>();
    _antRegulationRepository = RegulationRepository();
    antDataSink.add(ApiResponse.initial(''));
  }

  setInitial() async {
    antDataSink.add(ApiResponse.initial(''));
  }

  fetchResponse(String regulationId) async {
    _isStreaming = true;
    antDataSink.add(ApiResponse.loading(''));
    try {
      RegulationDetailModel dataResponse = await _antRegulationRepository.fetchRegulationDetail({
        'regulasi_id': regulationId,
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
