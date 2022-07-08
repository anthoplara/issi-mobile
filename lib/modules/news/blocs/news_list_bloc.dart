import 'dart:async';

import 'package:mobile/utils/networks/api_response.dart';

import '../models/news_list_model.dart';
import '../repositories/news_repository.dart';

class NewsListBloc {
  NewsRepository _antNewsRepository = NewsRepository();
  StreamController _antDataController = StreamController<ApiResponse<int>>();
  bool _isStreaming = false;

  StreamSink<dynamic> get antDataSink => _antDataController.sink;
  Stream<dynamic> get antDataStream => _antDataController.stream;

  NewsListBloc() {
    _antDataController = StreamController<dynamic>();
    _antNewsRepository = NewsRepository();
    antDataSink.add(ApiResponse.initial(''));
  }

  setInitial() async {
    antDataSink.add(ApiResponse.initial(''));
  }

  fetchResponse(int category, int page, int limit) async {
    _isStreaming = true;
    antDataSink.add(ApiResponse.loading(''));
    try {
      NewsListModel dataResponse = await _antNewsRepository.fetchNewsList({
        'kategori_id': category.toString(), //1.News, 2.Banner
        'page': page.toString(),
        'limit': limit.toString(),
      });
      if (_isStreaming) {
        antDataSink.add(ApiResponse.completed(dataResponse));
      }
    } catch (e) {
      if (_isStreaming) {
        antDataSink.add(ApiResponse.error(
          'Server error, hubungi tim teknis',
        ));
      }
    }
  }

  dispose() {
    _isStreaming = false;
    _antDataController.close();
  }
}
