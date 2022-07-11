import 'dart:async';

import 'package:mobile/utils/networks/constans/base_service.dart';

import '../models/past_list_model.dart';

class PastRepository {
  final BaseService _wrapper = BaseService();

  Future<PastListModel> fetchEventList(query) async {
    final response = await _wrapper.apiRequest("get", _wrapper.getPastList, {'params': query});
    return PastListModel.fromJson(response);
  }
}
