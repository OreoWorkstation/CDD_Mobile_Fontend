import 'package:cdd_mobile_frontend/common/router/router_init.dart';
import 'package:cdd_mobile_frontend/demo/button_demo.dart';
import 'package:cdd_mobile_frontend/demo/color_demo.dart';
import 'package:cdd_mobile_frontend/demo/dialog_demo.dart';
import 'package:cdd_mobile_frontend/demo/state_demo.dart';
import 'package:fluro/fluro.dart';
import 'package:fluro/src/router.dart';

class DemoRouter implements IRouterProvider {
  static String colorDemoPage = '/demo/color';
  static String buttonDemoPage = '/demo/button';
  static String dialogDemoPage = '/demo/dialog';
  static String stateDemoPage = '/demo/state';

  @override
  void initRouter(Router router) {
    router.define(colorDemoPage,
        handler: Handler(handlerFunc: (_, params) => ColorDemoPage()));
    router.define(buttonDemoPage,
        handler: Handler(handlerFunc: (_, params) => ButtonDemoPage()));
    router.define(dialogDemoPage,
        handler: Handler(handlerFunc: (_, params) => DialogDemoPage()));
    router.define(stateDemoPage,
        handler: Handler(handlerFunc: (_, params) => StateDemoPage()));
  }
}
