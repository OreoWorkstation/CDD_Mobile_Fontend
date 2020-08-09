import 'package:cdd_mobile_frontend/common/router/404.dart';
import 'package:cdd_mobile_frontend/common/router/router_init.dart';
import 'package:cdd_mobile_frontend/common/router/user_router.dart';
import 'package:cdd_mobile_frontend/demo/demo_router.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

class Routes {
  static String HOME = "/home";
  static String LOGIN = "/login";
  static String REGISTER = "/register";

  static List<IRouterProvider> _routerList = [];

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      debugPrint("The widget is not found");
      return WidgetNotFound();
    });

    router.define(
      HOME,
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, List> params) {

        },
      ),
    );

    _routerList.clear();

    // TODO: Add Page router
    _routerList.add(DemoRouter());
    _routerList.add(UserRouter());

    _routerList.forEach((routerProvider) {
      routerProvider.initRouter(router);
    });
  }
}
