import 'package:cdd_mobile_frontend/common/widget/widget.dart';
import 'package:flutter/material.dart';

enum BaseState {
  LOADING,
  EMPTY,
  ERROR,
  SUCCESS,
}

class StateLayout extends StatefulWidget {
  final BaseState state;
  final Widget successWidget;
  final VoidCallback errorRetry;
  final VoidCallback emptyRetry;

  const StateLayout(
      {Key key,
      this.state,
      this.successWidget,
      this.errorRetry,
      this.emptyRetry})
      : super(key: key);

  @override
  _StateLayoutState createState() => _StateLayoutState();
}

class _StateLayoutState extends State<StateLayout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: _buildWidget(),
    );
  }

  Widget _buildWidget() {
    switch (widget.state) {
      case BaseState.SUCCESS:
        return widget.successWidget;
        break;
      case BaseState.ERROR:
        return CddErrorWidget(
          errorRetry: widget.errorRetry,
        );
        break;
      case BaseState.LOADING:
        return CddLoadingWidget();
        break;
      case BaseState.EMPTY:
        return CddEmptyWidget(
          emptyRetry: widget.emptyRetry,
        );
        break;
      default:
        return null;
    }
  }
}
