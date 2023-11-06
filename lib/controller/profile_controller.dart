import 'package:get/get.dart';

import '../Model/ProfileModel/profile_info_model.dart';

class ProfileController extends GetxController {
  Rx<ProfileInfoModel> profileInfoModel = ProfileInfoModel(
          data: Data(emailAddress: "", userName: "", phoneNumber: ""))
      .obs;
}
