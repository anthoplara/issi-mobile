import 'package:get_storage/get_storage.dart';

import '../api_wrapper.dart';
import '../config/constant_config.dart';

class BaseService {
  GetStorage localData = GetStorage();

  final String initial = "mobileBaseService";
  final String baseUrl = ConstantConfig().baseEndpoint;

  final String loginDefault = "login_default";
  final String loginOther = "social_media_auth";
  final String getProfile = "profil_detail";

  final String getEventList = "get_event_all";
  final String getEventDetail = "get_event_detail";
  final String getRaceList = "get_event_race";

  final String getRaceDetail = "get_event_detail";
  final String joinEvent = "join_event";

  final String getUpcomingList = "list_upcoming_event";
  final String getPastList = "list_past_event";

  final String getNewsList = "get_content";
  final String getNewsDetail = "get_content_detail";

  final String getRegulation = "get_kategori_regulasi_all";
  final String getRegulationList = "get_regulasi_all";
  final String getRegulationDetail = "get_regulasi_detail";

  final String inactiveUser = "non_aktif_user";
  final String checkUser = "cek_status_user";
  final String reactiveUser = "reaktif_user";

  Future<dynamic> apiRequest(String method, String route, Map<String, dynamic> data) async {
    ApiWrapper apiWrapper = ApiWrapper();
    return await apiWrapper.request(baseUrl, initial, method, route, data);
  }
}
