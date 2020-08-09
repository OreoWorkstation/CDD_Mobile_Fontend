import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:flutter/material.dart';

class CddLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(sWidth(10)),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: sWidth(200),
            height: sHeight(200),
            child: Image.asset(
              "assets/images/state/loading.png",
              fit: BoxFit.cover,
            ),
          ),
          CircularProgressIndicator(),
          SizedBox(height: sHeight(20)),
          Text(
            "拼命加载中...",
            style: TextStyle(
              color: Colors.black.withOpacity(.5),
              fontSize: sSp(18),
            ),
          ),
        ],
      ),
    );
  }
}

class CddErrorWidget extends StatelessWidget {
  final VoidCallback errorRetry;

  const CddErrorWidget({Key key, @required this.errorRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: errorRetry,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: sWidth(200),
            height: sHeight(200),
            child: Image.asset(
              "assets/images/state/error.png",
              fit: BoxFit.cover,
            ),
          ),
          Text(
            "加载失败，轻触重试",
            style: TextStyle(
              color: Colors.black.withOpacity(.5),
              fontSize: sSp(18),
            ),
          ),
        ],
      ),
    );
  }
}

class CddEmptyWidget extends StatelessWidget {
  final VoidCallback emptyRetry;

  const CddEmptyWidget({Key key, @required this.emptyRetry}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: emptyRetry,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: sWidth(200),
            height: sHeight(200),
            child: Image.asset("assets/images/state/empty.png"),
          ),
          Text(
            "暂无相关数据，轻触重试",
            style: TextStyle(
              color: Colors.black.withOpacity(.5),
              fontSize: sSp(18),
            ),
          ),
        ],
      ),
    );
  }
}
