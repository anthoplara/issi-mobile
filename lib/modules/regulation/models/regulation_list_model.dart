class RegulationListModel {
  int? status;
  bool? error;
  List<RegulationListData>? data;

  RegulationListModel({
    this.status,
    this.error,
    this.data,
  });

  RegulationListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] as int?;
    error = json['error'] as bool?;
    data = (json['data'] as List?)?.map((dynamic e) => RegulationListData.fromJson(e as Map<String, dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['status'] = status;
    json['error'] = error;
    json['data'] = data?.map((e) => e.toJson()).toList();
    return json;
  }
}

class RegulationListData {
  String? id;
  String? judulRegulasi;
  String? kategori;
  String? namaKategori;
  String? detailRegulasi;

  RegulationListData({
    this.id,
    this.judulRegulasi,
    this.kategori,
    this.namaKategori,
    this.detailRegulasi,
  });

  RegulationListData.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    judulRegulasi = json['judul_regulasi'] as String?;
    kategori = json['kategori'] as String?;
    namaKategori = json['nama_kategori'] as String?;
    detailRegulasi = json['detail_regulasi'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['judul_regulasi'] = judulRegulasi;
    json['kategori'] = kategori;
    json['nama_kategori'] = namaKategori;
    json['detail_regulasi'] = detailRegulasi;
    return json;
  }
}
