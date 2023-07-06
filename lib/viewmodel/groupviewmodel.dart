import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../model/groupmodel.dart';

class GroupViewModel extends ChangeNotifier {
  List<dynamic> groups = [];
  bool isLoading = false;
  String? error;

  dynamic fetchGroups() async {
    isLoading = true;
    error = null;
    try {
      final response = await Dio()
          .get('http://3.1.62.165:8080/api/v1/controller/user/153/cluster');
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = response.data['data'];
        print("jsonData in viewmodel : $jsonData");
        // groups = jsonData;
        print('runtime type${jsonData.runtimeType}');
        groups = jsonData;
        return jsonData;
        // jsonData.forEach((group) {
        //   groups.add(GroupData.fromJson(group));
        // });
        // print("groups in viewmodel : $groups");
      } else {
        error = 'Failed to fetch groups';
        return null;
      }
    } catch (e) {
      error = 'An error occurred';
    }

    isLoading = false;
    notifyListeners();
  }

  savedata(dynamic data) {
    for (var i in data) {
      groups.add(i);
    }
    isLoading = false;
    notifyListeners();
  }
}
