class JoinEventModel {
  int? status;
  bool? error;
  String? message;

  JoinEventModel({
    this.status,
    this.error,
    this.message,
  });

  JoinEventModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] as int?;
    error = json['error'] as bool?;
    message = json['message'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['status'] = status;
    json['error'] = error;
    json['message'] = message;
    return json;
  }
}
