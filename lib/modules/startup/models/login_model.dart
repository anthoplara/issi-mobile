class LoginModel {
  int? status;
  bool? error;
  String? message;
  List<LoginData>? data;

  LoginModel({
    this.status,
    this.error,
    this.message,
    this.data,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] as int?;
    error = json['error'] as bool?;
    message = json['message'] as String?;
    data = (json['data'] as List?)?.map((dynamic e) => LoginData.fromJson(e as Map<String, dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['status'] = status;
    json['error'] = error;
    json['message'] = message;
    json['data'] = data?.map((e) => e.toJson()).toList();
    return json;
  }
}

class LoginData {
  String? id;
  String? username;
  String? nama;
  String? alamat;
  String? email;
  String? nomorHp;
  String? profilImages;

  LoginData({
    this.id,
    this.username,
    this.nama,
    this.alamat,
    this.email,
    this.nomorHp,
    this.profilImages,
  });

  LoginData.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    username = json['username'] as String?;
    nama = json['nama'] as String?;
    alamat = json['alamat'] as String?;
    email = json['email'] as String?;
    nomorHp = json['nomor_hp'] as String?;
    profilImages = json['profil_images'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['username'] = username;
    json['nama'] = nama;
    json['alamat'] = alamat;
    json['email'] = email;
    json['nomor_hp'] = nomorHp;
    json['profil_images'] = profilImages;
    return json;
  }
}
