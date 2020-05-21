import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:flutter/material.dart';

class InputBottomSheet extends StatelessWidget {
  final ValueChanged onEditingCompleteText;
  final TextEditingController controller = TextEditingController();
  final hintText;

  InputBottomSheet({Key key, this.onEditingCompleteText, this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              child: Container(
                color: Colors.transparent,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Container(
            color: Color(0xFFF4F4F4),
            padding: EdgeInsets.only(
              left: sWidth(16),
              top: sHeight(8),
              bottom: sHeight(8),
              right: sHeight(16),
            ),
            child: TextField(
              controller: controller,
              autocorrect: true,
              autofocus: true,
              style: TextStyle(
                fontSize: sSp(16),
              ),
              textInputAction: TextInputAction.send,
              keyboardType: TextInputType.multiline,
              onEditingComplete: () {
                //点击发送调用
                print('onEditingComplete');
                onEditingCompleteText(controller.text);
                Navigator.pop(context);
              },
              decoration: InputDecoration(
                hintText: hintText == null ? '请输入评论的内容' : "回复: $hintText",
                isDense: true,
                contentPadding:
                    EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
                border: const OutlineInputBorder(
                  gapPadding: 0,
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
              minLines: 1,
              maxLines: 5,
            ),
          ),
        ],
      ),
    );
  }
}

class ReplayTextFiefd extends StatelessWidget {
  final ValueChanged onEditingCompleteText;
  final TextEditingController controller = TextEditingController();

  ReplayTextFiefd({Key key, this.onEditingCompleteText}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Color(0xFFF4F4F4),
        padding: EdgeInsets.only(
          left: sWidth(16),
          top: sHeight(8),
          bottom: sHeight(8),
          right: sHeight(16),
        ),
        child: TextField(
          controller: controller,
          autocorrect: true,
          style: TextStyle(
            fontSize: sSp(16),
          ),
          textInputAction: TextInputAction.send,
          keyboardType: TextInputType.multiline,
          onEditingComplete: () {
            //点击发送调用
            print('onEditingComplete');
            onEditingCompleteText(controller.text);
            Navigator.pop(context);
          },
          decoration: InputDecoration(
            hintText: '请输入评论的内容',
            isDense: true,
            contentPadding:
                EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
            border: const OutlineInputBorder(
              gapPadding: 0,
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
          ),
          minLines: 1,
          maxLines: 5,
        ),
      ),
    );
  }
}

//过度路由
class PopRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 300);
  Widget child;

  PopRoute({@required this.child});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}
