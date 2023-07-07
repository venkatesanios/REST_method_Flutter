import 'package:flutter/material.dart';
import 'package:rest_method_flutter/model/send_receivemodel.dart';

import '../core/API/apiservice.dart';

class SendReceiveViewModel with ChangeNotifier {
  List<dynamic> sendReceiveData = [];
  bool isLoading = false;
  String error = '';

  Future<dynamic> fetchSendReceiveData() async {
    // isLoading = true;
    // error = '';

    try {
      dynamic response = await ApiService().fetchSendAndReceiveData();
      // print('responseviewmodel:$response');
      print('response : ${response.runtimeType}');
      final data = SendandReceiveData.fromJson(response);

      sendReceiveData = data.data;
      notifyListeners();
      // print('class of datat= ${data.data}');

      if (response.statusCode == 200) {
        final data = sendandReceiveDataFromJson(response.data);
        print('sendandReceiveDataFromJson:$data');

        notifyListeners();
        if (data != null) {
          sendReceiveData = data.data ?? [];
          return sendReceiveData;
        }
      } else {
        error = 'Error: ${response.statusCode}';
        return null;
      }
    } catch (e) {
      print(e.toString());
      // error = 'Error: $e';
    }

    isLoading = false;
    notifyListeners();
  }
}
