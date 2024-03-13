import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Utils/api_urls.dart';

class VerifyOtpController extends GetxController {
  resendOtpApi(String id) async {
    try {
      print(id);
      var headers = {

        'Authorization':
            'Basic KzIkcVBiSlIzNncmaGUoalMmV0R6ZkpqdEVoSlVLVXA6dCRCZHEmSnQmc3Y0eUdqY0VVcTg5aEVZZHVSalhIMnU='
      };
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
            ApiUrls.resendOtpApi,
          ));
      request.fields.addAll({'id': id});

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var resp = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "OTP resent successfully");
        print(resp);
      } else if (response.statusCode == 429) {
        print(resp);
        Fluttertoast.showToast(
            msg: "You can resend OTP only after a 2-minute interval");

      
      } else {
        print(response.reasonPhrase);
        Fluttertoast.showToast(msg: "Something went wrong");
      }

     
    } catch (e) {
      print(e);
     
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

}

