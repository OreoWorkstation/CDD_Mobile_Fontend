import 'package:cdd_mobile_frontend/common/router/router_init.dart';
import 'package:cdd_mobile_frontend/view/application/application_page.dart';
import 'package:cdd_mobile_frontend/view/sign/sign_in_page.dart';
import 'package:cdd_mobile_frontend/view/sign/sign_up_page.dart';
import 'package:fluro/fluro.dart';
import 'package:fluro/src/router.dart';

class UserRouter implements IRouterProvider {
  static String LOGIN = "/login";
  static String REGISTER = "/register";
  static String APPLICATION = "/application";

  @override
  void initRouter(Router router) {
    router.define(LOGIN,
        handler: Handler(handlerFunc: (_, params) => SignInPage()));
    router.define(REGISTER,
        handler: Handler(handlerFunc: (_, params) => SignUpPage()));
    router.define(APPLICATION,
        handler: Handler(handlerFunc: (_, params) => ApplicationPage()));
  }
}
