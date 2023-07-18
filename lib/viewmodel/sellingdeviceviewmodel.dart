import 'package:flutter/material.dart';
import 'package:rest_method_flutter/model/sellingdevice.dart';

class DeviceViewModel extends ChangeNotifier {
  List<Device> _availableDevices = [
    Device(name: 'Oro Gem', model: 'Gem001', imei: '1234567890'),
    Device(name: 'Oro Pump', model: 'Pump001', imei: '0987654321'),
    // Add more devices here
  ];

  List<Device> get availableDevices => _availableDevices;

  Device? _selectedDevice;

  Device? get selectedDevice => _selectedDevice;

  void selectDevice(Device device) {
    _selectedDevice = device;
    notifyListeners();
  }

  // Add methods for handling API calls and creating a new customer account here
}
