import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wafer/features/offers/data/models/charity_need_model.dart';

class CharityNeedsRepo {
  final Dio dio;

  CharityNeedsRepo(this.dio);

  Future<List<CharityNeedModel>> getCharityNeeds() async {
    try {
      final response = await dio.get(
        'https://waffer.runasp.net/api/v1/public/charity-needs',
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final List data = response.data['data'];
        return data.map((e) => CharityNeedModel.fromJson(e)).toList();
      } else {
        throw Exception('فشل تحميل احتياجات الجمعيات');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<CharityNeedModel> getCharityNeedDetails(String charityNeedId) async {
    try {
      final response = await dio.get(
        'https://waffer.runasp.net/api/v1/public/charity-needs/$charityNeedId',
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        return CharityNeedModel.fromJson(response.data['data']);
      } else {
        throw Exception('فشل تحميل تفاصيل الاحتياج');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<int> applyCharityNeed(String charityNeedId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    final response = await dio.post(
      'https://waffer.runasp.net/api/v1/donor-organization/charity-needs/$charityNeedId/apply',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    return response.statusCode ?? 0;
  }
}
