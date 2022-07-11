import 'dart:async';

import 'package:mobile/utils/networks/constans/base_service.dart';

import '../models/join_event_model.dart';

class JoinEventRepository {
  final BaseService _wrapper = BaseService();

  Future<JoinEventModel> fetchJoinEvent(query) async {
    final response = await _wrapper.apiRequest("get", _wrapper.joinEvent, {'params': query});
    return JoinEventModel.fromJson(response);
  }
}
