import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/send_receiveviewmodel.dart';

class SendReceivePage extends StatefulWidget {
  final SendReceiveViewModel sendreceiveModel;
  SendReceivePage({Key? key, required this.sendreceiveModel}) : super(key: key);
  @override
  State<SendReceivePage> createState() => _SendReceivePageState();
}

class _SendReceivePageState extends State<SendReceivePage> {
  @override
  void initState() {
    super.initState();
    fun1();
  }

  void fun1() async {
    var data = await widget.sendreceiveModel.fetchSendReceiveData();
    print('here : ${data}');
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SendReceiveViewModel>(context);
    print(viewModel);

    return Scaffold(
      appBar: AppBar(
        title: Text('Send and Receive Data'),
      ),
      body: ListView.builder(
        itemCount: viewModel.sendReceiveData.length,
        itemBuilder: (context, index) {
          final data = viewModel.sendReceiveData[index];
          print('data: $data.data');

          return ListTile(
            title: Text(data.ctrlMsg ?? ''),
            subtitle:
                Text('${data.date ?? ''} \t ${data.time.toString() ?? ''}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var data = viewModel.fetchSendReceiveData();
          print(data);
          // viewModel.sendReceiveData();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
