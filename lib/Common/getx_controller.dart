import 'package:farm_flow_sales/Model/faqModel/faq_model.dart';
import 'package:get/get.dart';

class CommonGetXController extends GetxController {
  double? _discountValue = 0;

  double? get discountValue => _discountValue;
  FaqModel faqModel = FaqModel();

  changeValue(double value) {
    _discountValue = value;
    update();
  }
}
