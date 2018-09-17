import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

///列表右侧的滑块
///textColor 文字颜色
///color 按住之后的颜色
///valueChanged 回调
///
class SideBar extends StatefulWidget {
  final List<String> list;
  final Color textColor;
  final Color color;
  final ValueChanged<String> valueChanged;

  SideBar(
      {Key key,
      @required this.list,
      @required this.textColor,
      @required this.color,
      @required this.valueChanged})
      : assert(list != null || list.length > 0),
        assert(valueChanged != null),
        super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  List<Widget> _widgetList;
  bool _isTaped = false;
  String _selectStr = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _widgetList = List<Widget>.generate(widget.list.length, (index) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 2.0),
        child: Text(
          widget.list[index],
          style: TextStyle(color: widget.textColor, fontSize: 14.0),
        ),
      );
    });
  }

  _onDragStart(BuildContext context, DragStartDetails start) {
    RenderBox getBox = context.findRenderObject();
    var local = getBox.globalToLocal(start.globalPosition);
    setState(() {
      _selectStr = _getCurrentStr(local.dy);
      widget.valueChanged(_selectStr);
      _isTaped = true;
    });
  }

  _onDragUpdate(BuildContext context, DragUpdateDetails update) {
    RenderBox getBox = context.findRenderObject();
    var local = getBox.globalToLocal(update.globalPosition);
    setState(() {
      _selectStr = _getCurrentStr(local.dy);
      widget.valueChanged(_selectStr);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: (DragStartDetails start) {
        _onDragStart(context, start);
      },
      onVerticalDragUpdate: (DragUpdateDetails update) =>
          _onDragUpdate(context, update),
      onVerticalDragEnd: (DragEndDetails end) {
        setState(() {
          _isTaped = false;
        });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _isTaped
              ? Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width / 2 - 70 + 15),
                  width: 70.0,
                  height: 70.0,
                  decoration: BoxDecoration(
                      color: widget.color,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Text(
                    _selectStr,
                    style: Theme.of(context)
                        .textTheme
                        .display1
                        .copyWith(color: widget.textColor),
                  ),
                )
              : SizedBox(),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
                color: _isTaped ? widget.color : Colors.transparent,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            width: 26.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: _widgetList,
            ),
          ),
        ],
      ),
    );
  }

  String _getCurrentStr(double dy) {
    int index = (dy / 19.0).round();
    if (index <= 0) {
      return widget.list.first;
    } else if (index >= widget.list.length) {
      return widget.list.last;
    } else {
      return widget.list[index];
    }
  }
}
