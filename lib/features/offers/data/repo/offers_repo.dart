import 'package:dio/dio.dart';
import 'package:wafer/features/offers/data/models/offer_model.dart';

class OffersRepo {
  final Dio dio;

  OffersRepo(this.dio);

  Future<List<OfferModel>> getOffers() async {
    try {
      final response = await dio.get(
        'https://waffer.runasp.net/api/v1/public/offers',
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final List data = response.data['data'];
        return data.map((e) => OfferModel.fromJson(e)).toList();
      } else {
        throw Exception('فشل تحميل العروض');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}