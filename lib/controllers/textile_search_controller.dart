import 'package:get/get.dart';
import 'package:textile_markaz/data/dummy/dummy_data.dart';
import 'package:textile_markaz/data/models/textile_ad.dart';

class TextileSearchController extends GetxController {
  final selectedCategory = RxnString();
  final selectedAdType = RxString('Buyers Post');
  final selectedCity = RxnString();

  List<TextileAd> search() {
    final cat = selectedCategory.value;
    final type = selectedAdType.value;
    final city = selectedCity.value;

    return dummyAds.where((ad) {
      if (cat != null && cat.isNotEmpty && ad.category != cat) return false;
      if (city != null && city.isNotEmpty && ad.city != city) return false;
      if (type == 'Buyers Post' && ad.mode != 'buy') return false;
      if (type == 'Sellers Post' && ad.mode != 'sell') return false;
      return true;
    }).toList();
  }
}
