import 'package:flutter/material.dart';
import 'package:rest_method_flutter/core/API/apiservice.dart';
import 'package:rest_method_flutter/model/faultmsg_Model.dart';

class FaultmessageViewModel extends ChangeNotifier {
  final ApiService apiService = ApiService();

  Future<FaultmessageModel> fetchFaultMessages() async {
    try {
      final Map<String, dynamic> jsonData =
          await apiService.fetchMessagesData();
      final faultmessageModel = FaultmessageModel.fromJson(jsonData);
      return faultmessageModel;
    } catch (e) {
      throw Exception('Failed to fetch fault messages: $e');
    }
  }
}
