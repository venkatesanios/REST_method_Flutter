import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_method_flutter/model/faultmsg_Model.dart';
import 'package:rest_method_flutter/viewmodel/faultmessageViewModel.dart';

class FaultmessageView extends StatefulWidget {
  final FaultmessageViewModel faultViewModel;
  FaultmessageView({Key? key, required this.faultViewModel}) : super(key: key);

  @override
  State<FaultmessageView> createState() => _FaultmessageViewState();
}

class _FaultmessageViewState1 extends State<FaultmessageView> {
  List<FaultData> dataList = []; // List to store the fault data

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch the initial data
  }

  Future<void> fetchData() async {
    final viewModelfaultmsg =
        Provider.of<FaultmessageViewModel>(context, listen: false);
    final faultmessageModel = await viewModelfaultmsg.fetchFaultMessages();
    setState(() {
      dataList = faultmessageModel.data ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModelfaultmsg =
        Provider.of<FaultmessageViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Fault Messages'),
      ),
      body: ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          final faultData = dataList[index];
          // Access the fault data properties
          final userId = faultData.userId;
          final controllerId = faultData.controllerId;
          final messageCode = faultData.messageCode;
          final controllerMessage = faultData.controllerMessage;

          // Wrap the ListTile with Dismissible for swipe-to-delete functionality
          return Dismissible(
            key: Key(userId.toString()), // Unique key for each item
            background: Container(color: Colors.red),
            confirmDismiss: (direction) async {
              // Show a confirmation dialog before dismissing
              return await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Confirm'),
                  content: Text('Are you sure you want to delete this item?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context)
                          .pop(false), // Cancel the dismiss operation
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context)
                          .pop(true), // Confirm the dismiss operation
                      child: Text('Delete'),
                    ),
                  ],
                ),
              );
            },
            onDismissed: (direction) {
              // Perform the delete operation here
              // You can call a method from the ViewModel to handle deletion
              // For example: widget.faultViewModel.deleteFaultMessage(userId);
              setState(() {
                dataList.removeAt(index); // Remove the item from the list
              });
            },
            child: ListTile(
              title: Text('User ID: $userId'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Controller ID: $controllerId'),
                  Text('Message Code: $messageCode'),
                  Text('Controller Message: $controllerMessage'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FaultmessageViewState extends State<FaultmessageView> {
  List<FaultData> dataList = []; // List to store the fault data

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch the initial data
  }

  Future<void> fetchData() async {
    final viewModelfaultmsg =
        Provider.of<FaultmessageViewModel>(context, listen: false);
    final faultmessageModel = await viewModelfaultmsg.fetchFaultMessages();
    setState(() {
      dataList = faultmessageModel.data ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fault Messages'),
      ),
      body: ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          final faultData = dataList[index];
          // Access the fault data properties
          final userId = faultData.userId;
          final controllerId = faultData.controllerId;
          final messageCode = faultData.messageCode;
          final controllerMessage = faultData.controllerMessage;

          // Wrap the ListTile with Dismissible for swipe-to-delete functionality
          return Dismissible(
            key: Key(userId.toString()), // Unique key for each item
            background: Container(color: Colors.red),
            confirmDismiss: (direction) async {
              // Show a confirmation dialog before dismissing
              return await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Confirm'),
                  content: Text('Are you sure you want to delete this item?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context)
                          .pop(false), // Cancel the dismiss operation
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context)
                          .pop(true), // Confirm the dismiss operation
                      child: Text('Delete'),
                    ),
                  ],
                ),
              );
            },
            onDismissed: (direction) {
              // Perform the delete operation here
              // You can call a method from the ViewModel to handle deletion
              // For example: widget.faultViewModel.deleteFaultMessage(userId);
              setState(() {
                dataList.removeAt(index); // Remove the item from the list
              });
              ScaffoldMessenger.of(context)
                  .removeCurrentSnackBar(); // Remove the current snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Item deleted'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: ListTile(
              title: Text('User ID: $userId'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Controller ID: $controllerId'),
                  Text('Message Code: $messageCode'),
                  Text('Controller Message: $controllerMessage'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
