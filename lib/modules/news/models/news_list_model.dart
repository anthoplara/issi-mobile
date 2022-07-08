class NewsListModel {
  int? status;
  bool? error;
  List<NewsListData>? data;

  NewsListModel({
    this.status,
    this.error,
    this.data,
  });

  NewsListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] as int?;
    error = json['error'] as bool?;
    data = (json['data'] as List?)?.map((dynamic e) => NewsListData.fromJson(e as Map<String, dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['status'] = status;
    json['error'] = error;
    json['data'] = data?.map((e) => e.toJson()).toList();
    return json;
  }
}

class NewsListData {
  String? id;
  String? kategori;
  String? namaKategori;
  String? judul;
  String? author;
  String? tglContent;
  String? contentDescription;
  dynamic images;
  dynamic tags;

  NewsListData({
    this.id,
    this.kategori,
    this.namaKategori,
    this.judul,
    this.author,
    this.tglContent,
    this.contentDescription,
    this.images,
    this.tags,
  });

  NewsListData.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    kategori = json['kategori'] as String?;
    namaKategori = json['nama_kategori'] as String?;
    judul = json['judul'] as String?;
    author = json['author'] as String?;
    tglContent = json['tgl_content'] as String?;
    contentDescription = json['content_description'] as String?;
    images = json['images'];
    tags = json['tags'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['kategori'] = kategori;
    json['nama_kategori'] = namaKategori;
    json['judul'] = judul;
    json['author'] = author;
    json['tgl_content'] = tglContent;
    json['content_description'] = contentDescription;
    json['images'] = images;
    json['tags'] = tags;
    return json;
  }
}
