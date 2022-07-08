import 'dart:async';

import 'package:mobile/utils/networks/constans/base_service.dart';

import '../models/event_detail_model.dart';
import '../models/event_list_model.dart';

class EventRepository {
  final BaseService _wrapper = BaseService();

  Future<EventListModel> fetchEventList(query) async {
    final response = await _wrapper.apiRequest("get", _wrapper.getEventList, {'params': query});
    return EventListModel.fromJson(response);
  }

  Future<EventDetailModel> fetchEventDetail(query) async {
    final response = await _wrapper.apiRequest("get", _wrapper.getEventDetail, {'params': query});
    return EventDetailModel.fromJson(response);
  }
}
