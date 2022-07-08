import 'package:get_storage/get_storage.dart';

import '../api_wrapper.dart';
import '../config/constant_config.dart';

class BaseService {
  GetStorage localData = GetStorage();

  final String initial = "mobileBaseService";
  final String baseUrl = ConstantConfig().baseEndpoint;

  final String getEventList = "get_event_all";
  final String getEventDetail = "get_event_detail";
  final String getRaceList = "get_event_race";
  final String getRaceDetail = "get_event_detail";

  final String getNewsList = "get_content";
  final String getNewsDetail = "get_content_detail";

  Future<dynamic> apiRequest(String method, String route, Map<String, dynamic> data) async {
    ApiWrapper apiWrapper = ApiWrapper();
    return await apiWrapper.request(baseUrl, initial, method, route, data);
  }
}
