class ProfileModel {
  int? status;
  bool? error;
  List<ProfileData>? data;

  ProfileModel({
    this.status,
    this.error,
    this.data,
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] as int?;
    error = json['error'] as bool?;
    data = (json['data'] as List?)?.map((dynamic e) => ProfileData.fromJson(e as Map<String, dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['status'] = status;
    json['error'] = error;
    json['data'] = data?.map((e) => e.toJson()).toList();
    return json;
  }
}

class ProfileData {
  String? nama;
  String? alamat;
  String? email;
  String? nomorHp;
  String? profilImages;
  String? aboutMe;

  ProfileData({
    this.nama,
    this.alamat,
    this.email,
    this.nomorHp,
    this.profilImages,
    this.aboutMe,
  });

  ProfileData.fromJson(Map<String, dynamic> json) {
    nama = json['nama'] as String?;
    alamat = json['alamat'] as String?;
    email = json['email'] as String?;
    nomorHp = json['nomor_hp'] as String?;
    profilImages = json['profil_images'] as String?;
    aboutMe = json['about_me'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['nama'] = nama;
    json['alamat'] = alamat;
    json['email'] = email;
    json['nomor_hp'] = nomorHp;
    json['profil_images'] = profilImages;
    json['about_me'] = aboutMe;
    return json;
  }
}
