import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/sellingdeviceviewmodel.dart';

class SellingDevicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceViewModel = Provider.of<DeviceViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Selling Device'),
      ),
      body: ListView.builder(
        itemCount: deviceViewModel.availableDevices.length,
        itemBuilder: (context, index) {
          final device = deviceViewModel.availableDevices[index];
          return ListTile(
            title: Text(device.name),
            subtitle: Text('Model: ${device.model}\nIMEI: ${device.imei}'),
            onTap: () {
              deviceViewModel.selectDevice(device);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SellToCustomerPage()));
            },
          );
        },
      ),
    );
  }
}

class SellToCustomerPage extends StatelessWidget {
  final TextEditingController _mobileNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceViewModel = Provider.of<DeviceViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Sell to Customer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _mobileNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: 'Mobile Number'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle the "Check Existing Customer Account" and "Create New Customer Account" logic here
                // deviceViewModel.checkExistingCustomer(_mobileNumberController.text);
              },
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
