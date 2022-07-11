class UpcomingListModel {
  int? status;
  bool? error;
  List<UpcomingListData>? data;

  UpcomingListModel({
    this.status,
    this.error,
    this.data,
  });

  UpcomingListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] as int?;
    error = json['error'] as bool?;
    data = (json['data'] as List?)?.map((dynamic e) => UpcomingListData.fromJson(e as Map<String, dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['status'] = status;
    json['error'] = error;
    json['data'] = data?.map((e) => e.toJson()).toList();
    return json;
  }
}

class UpcomingListData {
  String? idUser;
  String? idEvent;
  String? kategori;
  String? namaKategori;
  String? namaEvent;
  String? tglEvent;
  String? jamAwal;
  String? jamAkhir;
  String? lokasi;
  String? organizer;
  String? deskripsi;
  String? images;

  UpcomingListData({
    this.idUser,
    this.idEvent,
    this.kategori,
    this.namaKategori,
    this.namaEvent,
    this.tglEvent,
    this.jamAwal,
    this.jamAkhir,
    this.lokasi,
    this.organizer,
    this.deskripsi,
    this.images,
  });

  UpcomingListData.fromJson(Map<String, dynamic> json) {
    idUser = json['id_user'] as String?;
    idEvent = json['id_event'] as String?;
    kategori = json['kategori'] as String?;
    namaKategori = json['nama_kategori'] as String?;
    namaEvent = json['nama_event'] as String?;
    tglEvent = json['tgl_event'] as String?;
    jamAwal = json['jam_awal'] as String?;
    jamAkhir = json['jam_akhir'] as String?;
    lokasi = json['lokasi'] as String?;
    organizer = json['organizer'] as String?;
    deskripsi = json['deskripsi'] as String?;
    images = json['images'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id_user'] = idUser;
    json['id_event'] = idEvent;
    json['kategori'] = kategori;
    json['nama_kategori'] = namaKategori;
    json['nama_event'] = namaEvent;
    json['tgl_event'] = tglEvent;
    json['jam_awal'] = jamAwal;
    json['jam_akhir'] = jamAkhir;
    json['lokasi'] = lokasi;
    json['organizer'] = organizer;
    json['deskripsi'] = deskripsi;
    json['images'] = images;
    return json;
  }
}
