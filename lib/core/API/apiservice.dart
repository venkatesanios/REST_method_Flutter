import 'package:dio/dio.dart';
import 'package:rest_method_flutter/model/send_receivemodel.dart';

class ApiService {
  final String baseUrl = 'http://oroiot.net:8080/api/v1';

  Dio _dio = Dio();

  Future<dynamic> fetchSendAndReceiveData() async {
    final url =
        '$baseUrl/user/153/subuser/0/controller/1305/report?fromDate=%272023-04-29%27&toDate=%272023-05-29%27&type=sendrevmsg';

    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        final jsonData = response.data;
        // print('jsonData:$jsonData');
        return jsonData;
      } else {
        throw Exception('Failed to fetch send and receive data');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }

  // static fetchSendReceiveData() {}
}
