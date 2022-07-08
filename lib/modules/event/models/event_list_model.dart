class EventListModel {
  int? status;
  bool? error;
  List<EventListData>? data;

  EventListModel({
    this.status,
    this.error,
    this.data,
  });

  EventListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] as int?;
    error = json['error'] as bool?;
    data = (json['data'] as List?)?.map((dynamic e) => EventListData.fromJson(e as Map<String, dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['status'] = status;
    json['error'] = error;
    json['data'] = data?.map((e) => e.toJson()).toList();
    return json;
  }
}

class EventListData {
  String? id;
  String? kategori;
  String? namaKategori;
  String? namaEvent;
  String? tglEvent;
  String? jamAwal;
  String? jamAkhir;
  String? lokasi;
  dynamic organizer;
  dynamic deskripsi;
  dynamic images;
  String? totalOrangMendaftar;
  dynamic userFoto;

  EventListData({
    this.id,
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
    this.totalOrangMendaftar,
    this.userFoto,
  });

  EventListData.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    kategori = json['kategori'] as String?;
    namaKategori = json['nama_kategori'] as String?;
    namaEvent = json['nama_event'] as String?;
    tglEvent = json['tgl_event'] as String?;
    jamAwal = json['jam_awal'] as String?;
    jamAkhir = json['jam_akhir'] as String?;
    lokasi = json['lokasi'] as String?;
    organizer = json['organizer'];
    deskripsi = json['deskripsi'];
    images = json['images'];
    totalOrangMendaftar = json['total_orang_mendaftar'] as String?;
    userFoto = json['user_foto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
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
    json['total_orang_mendaftar'] = totalOrangMendaftar;
    json['user_foto'] = userFoto;
    return json;
  }
}
