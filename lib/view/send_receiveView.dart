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
      body: ListView.separated(
        padding: EdgeInsets.all(16.0),
        itemCount: viewModel.sendReceiveData.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          final data = viewModel.sendReceiveData[index];
          final isReceived = data.msgType == "RECEIVED";
          final alignment =
              isReceived ? MainAxisAlignment.start : MainAxisAlignment.end;
          final backgroundColor = isReceived ? Colors.white : Colors.blue;
          final textColor = isReceived ? Colors.black : Colors.white;
          final borderRadius = isReceived
              ? BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                )
              : BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                );

          return Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: borderRadius,
              border: Border.all(color: Colors.grey),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: alignment,
                children: [
                  Flexible(
                    child: ListTile(
                      title: Text(
                        data.ctrlMsg ?? '',
                        style: TextStyle(color: textColor),
                        textAlign: isReceived ? TextAlign.start : TextAlign.end,
                      ),
                      subtitle: Text(
                        '${data.date ?? ''} \t ${data.time.toString() ?? ''}',
                        style: TextStyle(color: textColor),
                        textAlign: isReceived ? TextAlign.start : TextAlign.end,
                      ),
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                    ),
                  ),
                ],
              ),
            ),
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
