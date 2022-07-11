import 'dart:async';

import 'package:mobile/utils/networks/constans/base_service.dart';

import '../models/upcoming_list_model.dart';

class UpcomingRepository {
  final BaseService _wrapper = BaseService();

  Future<UpcomingListModel> fetchEventList(query) async {
    final response = await _wrapper.apiRequest("get", _wrapper.getUpcomingList, {'params': query});
    return UpcomingListModel.fromJson(response);
  }
}
