import 'dart:async';

import 'package:mobile/utils/networks/constans/base_service.dart';

import '../models/race_detail_model.dart';
import '../models/race_list_model.dart';

class RaceRepository {
  final BaseService _wrapper = BaseService();

  Future<RaceListModel> fetchRaceList(query) async {
    final response = await _wrapper.apiRequest("get", _wrapper.getRaceList, {'params': query});
    return RaceListModel.fromJson(response);
  }

  Future<RaceDetailModel> fetchRaceDetail(query) async {
    final response = await _wrapper.apiRequest("get", _wrapper.getRaceDetail, {'params': query});
    return RaceDetailModel.fromJson(response);
  }
}
