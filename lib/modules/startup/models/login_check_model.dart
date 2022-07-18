class LoginCheckModel {
  int? status;
  bool? error;
  List<LoginCheckData>? data;

  LoginCheckModel({
    this.status,
    this.error,
    this.data,
  });

  LoginCheckModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] as int?;
    error = json['error'] as bool?;
    data = (json['data'] as List?)?.map((dynamic e) => LoginCheckData.fromJson(e as Map<String, dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['status'] = status;
    json['error'] = error;
    json['data'] = data?.map((e) => e.toJson()).toList();
    return json;
  }
}

class LoginCheckData {
  String? statusUser;

  LoginCheckData({
    this.statusUser,
  });

  LoginCheckData.fromJson(Map<String, dynamic> json) {
    statusUser = json['status_user'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['status_user'] = statusUser;
    return json;
  }
}
