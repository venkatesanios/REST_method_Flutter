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
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SendReceiveViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Send and Receive Data'),
      ),
      body: Container(
        color: Colors.grey[200], // Light gray background color
        child: ListView.separated(
          padding: EdgeInsets.all(16.0),
          itemCount: viewModel.sendReceiveData.length,
          separatorBuilder: (context, index) {
            final currentData = viewModel.sendReceiveData[index];
            final previousData =
                index > 0 ? viewModel.sendReceiveData[index - 1] : null;

            if (previousData != null && currentData.date == previousData.date) {
              return Divider();
            }

            return Column(
              children: [
                Divider(),
                Center(
                  child: Text(
                    currentData.date ?? '',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            );
          },
          itemBuilder: (context, index) {
            final data = viewModel.sendReceiveData.reversed.toList()[index];
            final isReceived = data.msgType == "RECEIVED";
            final alignment =
                isReceived ? MainAxisAlignment.start : MainAxisAlignment.end;
            final backgroundColor = isReceived ? Colors.white : Colors.blue;
            final textColor = isReceived ? Colors.black : Colors.white;
            final borderRadius = isReceived
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                  );

            return Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: borderRadius,
                border: Border.all(color: Colors.blueGrey),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: alignment,
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text(
                          data.ctrlMsg ?? '',
                          style: TextStyle(color: textColor),
                          textAlign:
                              isReceived ? TextAlign.start : TextAlign.center,
                        ),
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                      ),
                    ),
                    Text(
                      '${data.date ?? ''} \n ${data.time ?? ''}',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
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
