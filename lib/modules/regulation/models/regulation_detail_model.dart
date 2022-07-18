class RegulationDetailModel {
  int? status;
  bool? error;
  List<RegulationDetailData>? data;

  RegulationDetailModel({
    this.status,
    this.error,
    this.data,
  });

  RegulationDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] as int?;
    error = json['error'] as bool?;
    data = (json['data'] as List?)?.map((dynamic e) => RegulationDetailData.fromJson(e as Map<String, dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['status'] = status;
    json['error'] = error;
    json['data'] = data?.map((e) => e.toJson()).toList();
    return json;
  }
}

class RegulationDetailData {
  String? id;
  String? judulRegulasi;
  String? namaKategori;
  String? detailRegulasi;

  RegulationDetailData({
    this.id,
    this.judulRegulasi,
    this.namaKategori,
    this.detailRegulasi,
  });

  RegulationDetailData.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    judulRegulasi = json['judul_regulasi'] as String?;
    namaKategori = json['nama_kategori'] as String?;
    detailRegulasi = json['detail_regulasi'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['judul_regulasi'] = judulRegulasi;
    json['nama_kategori'] = namaKategori;
    json['detail_regulasi'] = detailRegulasi;
    return json;
  }
}
