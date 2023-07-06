import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/groupviewmodel.dart';

class GroupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<GroupViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Group List'),
      ),
      body: ListView.builder(
        itemCount: viewModel.groups.length,
        itemBuilder: (context, index) {
          final group = viewModel.groups[index];
          return ListTile(
            title: Text(group['groupName'].toString()),
            subtitle: Text(group['userId'].toString()),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var data = viewModel.fetchGroups();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
