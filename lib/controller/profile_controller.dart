import 'package:get/get.dart';

import '../Model/ProfileModel/profile_info_model.dart';

class ProfileController extends GetxController {
  bool onclickofpin = false;
  bool onclickoftouchid = false;
  Rx<ProfileInfoModel> profileInfoModel = ProfileInfoModel(
          data: Data(emailAddress: "", userName: "", phoneNumber: ""))
      .obs;
}
