import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/send_receiveviewmodel.dart';

class SendReceivePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SendReceiveViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Send and Receive Data'),
      ),
      body: ListView.builder(
        itemCount: viewModel.sendReceiveData.length,
        itemBuilder: (context, index) {
          final data = viewModel.sendReceiveData[index];

          return ListTile(
            title: Text(data.ctrlMsg ?? ''),
            subtitle: Text(data.date ?? '' + ' ' + data.time.toString() ?? ''),
          );
        },
      ),
    );
  }
}
