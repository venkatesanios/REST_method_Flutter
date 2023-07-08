import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_method_flutter/viewmodel/onoffviewmodel.dart';

class MotorView extends StatefulWidget {
  final onoffViewModel viewModelonff;
  MotorView({Key? key, required this.viewModelonff}) : super(key: key);
  @override
  State<MotorView> createState() => _MotorViewState();
}

class _MotorViewState extends State<MotorView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<onoffViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('MOtor View'),
      ),
      body: Center(
        child: Switch(
          value: viewModel.isSwitched,
          onChanged: (newValue) {
            viewModel.updateStatus(newValue);
          },
        ),
      ),
    );
  }
}
