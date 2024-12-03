import 'package:get/get.dart';
import 'package:isotopeit_b2b/utils/translations/bn_BD.dart';
import 'package:isotopeit_b2b/utils/translations/en_US.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': enUS,
        'bn': bnBD,
      };
}
