import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class onoffViewModel extends ChangeNotifier {
  Dio dio = Dio();
  bool isSwitched = false;

  Future<void> updateStatus(bool newValue) async {
    try {
      final status = newValue ? '1' : '0';
      final sentSms = newValue ? 'Motoron' : 'Motoroff';
      final response = await dio.put(
        'http://3.1.62.165:8080/api/v1/user/153/subuser/0/controller/1305/manualstatus',
        data: {"status": status, "sentSms": sentSms},
      );
      print(response.data);
      isSwitched = newValue;
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Error: $e');
    }
  }
}
