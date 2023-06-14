import 'package:get/get.dart';

class CommonGetXController extends GetxController {
  double? _discountValue = 0;

  double? get discountValue => _discountValue;

  changeValue(double value) {
    _discountValue = value;
    update();
  }
}
