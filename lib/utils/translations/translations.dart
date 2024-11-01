
import 'package:get/get.dart';
import 'en_us.dart';
import 'bn_bd.dart';
import 'ar_sa.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': enUS,
        'bn': bnBD,
        'ar': arSA,
      };
}
