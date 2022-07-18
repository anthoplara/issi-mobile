import 'dart:async';

import 'package:mobile/utils/networks/constans/base_service.dart';

import '../models/user_delete_model.dart';

class ProfileRepository {
  final BaseService _wrapper = BaseService();

  Future<UserDeleteModel> fetchIncative(query) async {
    final response = await _wrapper.apiRequest("get", _wrapper.inactiveUser, {'params': query});
    return UserDeleteModel.fromJson(response);
  }
}
