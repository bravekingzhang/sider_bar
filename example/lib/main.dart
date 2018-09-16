import 'package:flutter/material.dart';
import 'package:sider_bar/sider_bar.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'SideBar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String content = "ABCDEFGHIGKLMNOPQRSTUVWXYZ";
  ScrollController _controller = ScrollController();
  List<String> mDataList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    mDataList =
        List<String>.generate(content.length, (index) => content[index]);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: new Text(widget.title),
        ),
        body: Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: <Widget>[
            ListView.builder(
              controller: _controller,
              itemCount: mDataList.length,
              itemBuilder: buildItem,
            ),
            SideBar(
                list: mDataList,
                textColor: Colors.blue,
                color: Colors.blue.withOpacity(0.2),
                valueChanged: (value) {
                  _controller
                      .jumpTo(mDataList.indexOf(value) * 44.0); //card 差不多44的高度
                })
          ],
        ),
    );
  }

  Widget buildItem(BuildContext context, int index) {
    return Card(
      child: ListTile(
        title: Text(mDataList[index]),
      ),
    );
  }
}
