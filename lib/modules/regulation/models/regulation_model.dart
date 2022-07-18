class RegulationModel {
  int? status;
  bool? error;
  List<RegulationData>? data;

  RegulationModel({
    this.status,
    this.error,
    this.data,
  });

  RegulationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] as int?;
    error = json['error'] as bool?;
    data = (json['data'] as List?)?.map((dynamic e) => RegulationData.fromJson(e as Map<String, dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['status'] = status;
    json['error'] = error;
    json['data'] = data?.map((e) => e.toJson()).toList();
    return json;
  }
}

class RegulationData {
  String? id;
  String? namaKategori;
  String? deskripsi;

  RegulationData({
    this.id,
    this.namaKategori,
    this.deskripsi,
  });

  RegulationData.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    namaKategori = json['nama_kategori'] as String?;
    deskripsi = json['deskripsi'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['nama_kategori'] = namaKategori;
    json['deskripsi'] = deskripsi;
    return json;
  }
}
