# sider_bar

sider bar for listview like ios contact list

## Usage

### Import the package
First, add sider_bar as a dependency in your pubspec.yaml

Then, import it:
```dart
import 'package:sider_bar/sider_bar.dart';
```
#### wrap ListView in a Stack,and SideBar over ListView with AlignmentDirectional.centerEnd
```dart
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
```

