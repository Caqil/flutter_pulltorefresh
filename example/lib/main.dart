import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home());
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  final _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: SmartRefresher(
              controller: _refreshController,
              onRefresh: () {
                print("==================");
              },
              child: ListView(
                children: _listChildren(context),
              ),
            ),
          ),

          ElevatedButton(onPressed: _onClickButton, child: Text("refresh")),
        ],
      ),
    );
  }

  List<Widget> _listChildren(BuildContext context) {
    return List.generate(100, (index) {
      return Text("Hello world $index");
    });
  }

  void _onClickButton() {
    _refreshController.requestRefresh(needMove: false, needCallback: false);

    Future.delayed(Duration(seconds: 1)).then((value) => _refreshController.refreshCompleted());
  }
}
