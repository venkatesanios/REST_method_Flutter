import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/groupviewmodel.dart';

class GroupPage extends StatefulWidget {
  final GroupViewModel groupModel;
  GroupPage({Key? key, required this.groupModel}) : super(key: key);
  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  @override
  void initState() {
    super.initState();
    widget.groupModel.fetchGroups();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<GroupViewModel>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text('Group List'),
      ),
      body: ListView.builder(
        itemCount: viewModel.groups.length,
        itemBuilder: (context, index) {
          final group = viewModel.groups[index];
          print(group);
          return ListTile(
            title: Text(group['groupName'].toString()),
            subtitle: Text(group['userGroupId'].toString()),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          viewModel.fetchGroups();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
