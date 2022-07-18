import 'dart:async';

import 'package:mobile/utils/networks/constans/base_service.dart';

import '../models/regulation_detail_model.dart';
import '../models/regulation_list_model.dart';
import '../models/regulation_model.dart';

class RegulationRepository {
  final BaseService _wrapper = BaseService();

  Future<RegulationModel> fetchRegulation() async {
    final response = await _wrapper.apiRequest("get", _wrapper.getRegulation, {});
    return RegulationModel.fromJson(response);
  }

  Future<RegulationListModel> fetchRegulationList(query) async {
    final response = await _wrapper.apiRequest("get", _wrapper.getRegulationList, {'params': query});
    return RegulationListModel.fromJson(response);
  }

  Future<RegulationDetailModel> fetchRegulationDetail(query) async {
    final response = await _wrapper.apiRequest("get", _wrapper.getRegulationDetail, {'params': query});
    return RegulationDetailModel.fromJson(response);
  }
}
