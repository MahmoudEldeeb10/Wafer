import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wafer/features/offers/data/models/offer_details_model.dart';

class OfferDetailsRepo {
  final Dio dio;

  OfferDetailsRepo(this.dio);

  Future<OfferDetailsModel> getOfferDetails(String offerId) async {
    try {
      final response = await dio.get(
        'https://waffer.runasp.net/api/v1/public/offers/$offerId',
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        return OfferDetailsModel.fromJson(response.data['data']);
      } else {
        throw Exception('فشل تحميل تفاصيل العرض');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<int> applyOffer(String offerId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    final response = await dio.post(
      'https://waffer.runasp.net/api/v1/charity/offers/$offerId/apply',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    return response.statusCode ?? 0;
  }
}