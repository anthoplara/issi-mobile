import 'dart:async';

import 'package:mobile/utils/networks/constans/base_service.dart';

import '../models/login_active_model.dart';
import '../models/login_check_model.dart';
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

  Future<LoginCheckModel> fetchLoginCheck(query) async {
    final response = await _wrapper.apiRequest("get", _wrapper.checkUser, {'params': query});
    return LoginCheckModel.fromJson(response);
  }

  Future<LoginActiveModel> fetchLoginActive(query) async {
    final response = await _wrapper.apiRequest("get", _wrapper.reactiveUser, {'params': query});
    return LoginActiveModel.fromJson(response);
  }
}
