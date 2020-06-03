import 'package:cdd_mobile_frontend/common/provider/provider_manage.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/global.dart';
import 'package:cdd_mobile_frontend/view/index.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

void main() {
  Global.init().then((e) => runApp(MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return OKToast(
        child: MultiProvider(
          providers: providers,
          child: MaterialApp(
            title: "Cat & Dog Diary",
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: AppColor.testBgColor3,
              // primaryColor: AppColor.testBgColor3,
            ),
            home: IndexPage(),
//            onGenerateRoute: Application.router.generator,
//            localizationsDelegates: const [
//              GlobalMaterialLocalizations.delegate,
//              GlobalWidgetsLocalizations.delegate,
//              GlobalCupertinoLocalizations.delegate,
//            ],
//            supportedLocales: const [Locale('zh', 'CH'), Locale('en', 'US')],
            builder: (context, child) {
              /// 保证文字大小不受手机系统设置影响 https://www.kikt.top/posts/flutter/layout/dynamic-text/
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaleFactor: 1.0,
                ), // 或者 MediaQueryData.fromWindow(WidgetsBinding.instance.window).copyWith(textScaleFactor: 1.0),
                child: child,
              );
            },
          ),
        ),

        /// Toast 配置
        backgroundColor: Colors.black54,
        textPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        radius: 20.0,
        position: ToastPosition.bottom);
  }
}
