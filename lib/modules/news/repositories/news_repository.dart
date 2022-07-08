import 'dart:async';

import 'package:mobile/utils/networks/constans/base_service.dart';

import '../models/news_detail_model.dart';
import '../models/news_list_model.dart';

class NewsRepository {
  final BaseService _wrapper = BaseService();

  Future<NewsListModel> fetchNewsList(query) async {
    final response = await _wrapper.apiRequest("get", _wrapper.getNewsList, {'params': query});
    return NewsListModel.fromJson(response);
  }

  Future<NewsDetailModel> fetchNewsDetail(query) async {
    final response = await _wrapper.apiRequest("get", _wrapper.getNewsDetail, {'params': query});
    return NewsDetailModel.fromJson(response);
  }
}
