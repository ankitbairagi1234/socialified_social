import 'package:foap/apiHandler/api_controller.dart';
import 'package:foap/helper/imports/common_import.dart';
import 'package:foap/model/live_model.dart';
import 'package:foap/util/app_util.dart';
import 'package:get/get.dart';

class LiveHistoryController extends GetxController {
  RxList<LiveModel> lives = <LiveModel>[].obs;

  bool isLoading = false;
  int currentPage = 1;
  bool canLoadMore = true;

  clear() {
    isLoading = false;
    currentPage = 1;
    canLoadMore = true;
  }

  getLiveHistory() {
    if (canLoadMore == true) {
      AppUtil.checkInternet().then((value) async {
        if (value) {
          isLoading = true;
          ApiController().getLiveHistory().then((response) {
            lives.addAll(response.lives);
            isLoading = false;
            currentPage += 1;

            if (response.posts.length == response.metaData?.pageCount) {
              canLoadMore = true;
            } else {
              canLoadMore = false;
            }
            update();
          });
        }
      });
    }
  }
}
