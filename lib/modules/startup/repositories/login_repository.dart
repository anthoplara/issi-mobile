import 'dart:async';

import 'package:mobile/utils/networks/constans/base_service.dart';

import '../models/login_model.dart';
import '../models/profile_model.dart';

class LoginRepository {
  final BaseService _wrapper = BaseService();

  Future<LoginModel> fetchDefaultLogin(query) async {
    final response = await _wrapper.apiRequest("post", _wrapper.loginDefault, {'body': query});
    return LoginModel.fromJson(response);
  }

  Future<LoginModel> fetchOtherLogin(query) async {
    final response = await _wrapper.apiRequest("post", _wrapper.loginOther, {'body': query});
    return LoginModel.fromJson(response);
  }

  Future<ProfileModel> fetchProfile(query) async {
    final response = await _wrapper.apiRequest("get", _wrapper.getProfile, {'params': query});
    return ProfileModel.fromJson(response);
  }
}
