import 'dart:async';

import 'package:get_storage/get_storage.dart';
import 'package:mobile/utils/networks/api_response.dart';
import 'package:mobile/utils/networks/key_storage.dart';

import '../models/login_model.dart';
import '../models/profile_model.dart';
import '../repositories/login_repository.dart';

class LoginBloc {
  LoginRepository _antLoginRepository = LoginRepository();
  StreamController _antDataController = StreamController<ApiResponse<int>>();
  bool _isStreaming = false;

  GetStorage localData = GetStorage();

  StreamSink<dynamic> get antDataSink => _antDataController.sink;
  Stream<dynamic> get antDataStream => _antDataController.stream;

  LoginBloc() {
    _antDataController = StreamController<dynamic>();
    _antLoginRepository = LoginRepository();
    antDataSink.add(ApiResponse.initial(''));
  }

  setInitial() async {
    antDataSink.add(ApiResponse.initial(''));
  }

  fetchResponse(String username, String password) async {
    _isStreaming = true;
    antDataSink.add(ApiResponse.loading(''));
    String userId = localData.read(KeyStorage.userId) ?? "0";
    try {
      LoginModel dataResponse = await _antLoginRepository.fetchDefaultLogin({
        'username': username,
        'password': password,
      });
      if (_isStreaming) {
        if (!(dataResponse.error ?? true)) {
          if (dataResponse.data!.isNotEmpty) {
            LoginData data = dataResponse.data![0];
            await localData.write(KeyStorage.lastUserName, data.username);

            await localData.write(KeyStorage.userId, data.id);
            await localData.write(KeyStorage.userName, data.username);
            await localData.write(KeyStorage.userFullName, data.nama);
            await localData.write(KeyStorage.userAddress, data.alamat);
            await localData.write(KeyStorage.userEmail, data.email);
            await localData.write(KeyStorage.userPhone, data.nomorHp);
            await localData.write(KeyStorage.userImage, data.profilImages);
            try {
              ProfileModel dataResponse = await _antLoginRepository.fetchProfile({
                'user_id': data.id,
              });
              if (_isStreaming) {
                if (!(dataResponse.error ?? true)) {
                  if (dataResponse.data!.isNotEmpty) {
                    ProfileData data = dataResponse.data![0];
                    await localData.write(KeyStorage.userDescription, data.aboutMe);
                    antDataSink.add(ApiResponse.completed(dataResponse));
                  } else {
                    antDataSink.add(ApiResponse.error(
                      'Server error, hubungi tim teknis',
                    ));
                  }
                } else {
                  var message = "Server error, hubungi tim teknis x";
                  antDataSink.add(ApiResponse.error(message));
                }
              }
            } catch (e) {
              if (_isStreaming) {
                antDataSink.add(ApiResponse.error(
                  'Server error, hubungi tim teknis y',
                ));
              }
            }
          } else {
            antDataSink.add(ApiResponse.error(
              'Server error, hubungi tim teknis',
            ));
          }
        } else {
          var message = dataResponse.message ?? "Server error, hubungi tim teknis";
          antDataSink.add(ApiResponse.error(message));
        }
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
