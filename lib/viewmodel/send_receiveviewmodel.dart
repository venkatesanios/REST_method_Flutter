import 'package:flutter/material.dart';
import 'package:rest_method_flutter/model/send_receivemodel.dart';

import '../core/API/apiservice.dart';

class SendReceiveViewModel with ChangeNotifier {
  List<Datum> sendReceiveData = [];
  bool isLoading = false;
  String error = '';

  Future<void> fetchSendReceiveData() async {
    isLoading = true;
    error = '';

    try {
      // Make API call to fetch send and receive data
      final response = await ApiService.fetchSendReceiveData();

      if (response.statusCode == 200) {
        final data = sendandReceiveDataFromJson(response.data);

        if (data != null) {
          sendReceiveData = data.data ?? [];
        }
      } else {
        error = 'Error: ${response.statusCode}';
      }
    } catch (e) {
      error = 'Error: $e';
    }

    isLoading = false;
    notifyListeners();
  }
}
