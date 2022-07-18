import 'dart:async';

import 'package:mobile/utils/networks/api_response.dart';

import '../models/regulation_list_model.dart';
import '../repositories/regulation_repository.dart';

class RegulationListBloc {
  RegulationRepository _antRegulationRepository = RegulationRepository();
  StreamController _antDataController = StreamController<ApiResponse<int>>();
  bool _isStreaming = false;

  StreamSink<dynamic> get antDataSink => _antDataController.sink;
  Stream<dynamic> get antDataStream => _antDataController.stream;

  RegulationListBloc() {
    _antDataController = StreamController<dynamic>();
    _antRegulationRepository = RegulationRepository();
    antDataSink.add(ApiResponse.initial(''));
  }

  setInitial() async {
    antDataSink.add(ApiResponse.initial(''));
  }

  fetchResponse(String categoryId, int page, int limit) async {
    _isStreaming = true;
    antDataSink.add(ApiResponse.loading(''));
    try {
      RegulationListModel dataResponse = await _antRegulationRepository.fetchRegulationList({
        'kategori_id': categoryId,
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
