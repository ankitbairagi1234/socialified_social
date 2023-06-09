import 'package:foap/model/faq_model.dart';
import 'package:get/get.dart';

import '../apiHandler/api_controller.dart';

class FAQController extends GetxController {

  RxList<FAQModel> faqs = <FAQModel>[].obs;

  loadFAQs() {
    ApiController().getFAQ().then((response) {
      faqs.value = response.faqs;
      update();
    });
  }
}
