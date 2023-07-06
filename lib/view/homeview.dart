import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_method_flutter/view/groupview.dart';
import 'package:rest_method_flutter/view/send_receiveView.dart';

import '../viewmodel/groupviewmodel.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      home: HomePage(),
      routes: {
        '/item1': (context) => ItemPage('Item 1'),
        '/item2': (context) => ItemPage('Item 2'),
        '/item3': (context) => ItemPage('Item 3'),
        '/item4': (context) => ItemPage('Item 4'),
        '/item5': (context) => ItemPage('Item 5'),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Map<String, String>> items = [
    {
      'title': 'GroupPage',
      'subtitle': 'http://3.1.62.165:8080/api/v1/controller/user/153/cluster'
    },
    {
      'title': 'SendReceivePage',
      'subtitle':
          'http://3.1.62.165:8080/api/v1/user/153/subuser/0/controller/1305/report?fromDate=%272023-05-29%27&toDate=%272023-05-29%27&type=sendrevmsg'
    },
    {'title': 'Item 3', 'subtitle': 'Subtitle 3'},
    {'title': 'Item 4', 'subtitle': 'Subtitle 4'},
    {'title': 'Item 5', 'subtitle': 'Subtitle 5'},
  ];

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<GroupViewModel>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: ListView(
        children: items.map((item) {
          return GestureDetector(
            onTap: () {
              if (item['title'] == 'GroupPage') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GroupPage(
                        groupModel: viewModel,
                      ),
                    ));
              } else if (item['title'] == 'SendReceivePage') {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SendReceivePage()));
              } else {
                Navigator.pushNamed(context, '/${item['title']!}');
              }
            },
            child: ListTile(
              title: Text(item['title']!),
              subtitle: Text(item['subtitle']!),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class ItemPage extends StatelessWidget {
  final String title;

  ItemPage(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('This is the $title page.'),
      ),
    );
  }
}
