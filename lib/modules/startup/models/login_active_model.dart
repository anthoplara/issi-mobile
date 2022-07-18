class LoginActiveModel {
  int? status;
  bool? error;

  LoginActiveModel({
    this.status,
    this.error,
  });

  LoginActiveModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] as int?;
    error = json['error'] as bool?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['status'] = status;
    json['error'] = error;
    return json;
  }
}
