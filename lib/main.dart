import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/app_init.dart';
import 'package:flutter_app/http/http_manager.dart';
import 'package:flutter_app/tab_navigation.dart';
import 'package:flutter_app/utils/toast_util.dart';

import 'config/string.dart';

void main() {
  runApp(MyApp());
  //Flutter沉浸式状态栏，Platform.isAndroid 判断是否是Android手机
  if (Platform.isAndroid) {
    // setSystemUIOverlayStyle:用来设置状态栏顶部和底部样式
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   DateTime? lastTime;
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: WillPopScope(
//         onWillPop: _onWillPop,
//         child: Scaffold(
//           body: Container(
//             color: Colors.blue,
//           ),
//           bottomNavigationBar: BottomNavigationBar(
//             currentIndex: _currentIndex,
//             type: BottomNavigationBarType.fixed,
//             selectedItemColor: Color(0xff000000),
//             unselectedItemColor: Color(0xff9a9a9a),
//             items: _item(),
//             onTap: _onTap,
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     AppInit.init();
//   }
//
//   Future<bool> _onWillPop() async {
//     if (lastTime == null ||
//         DateTime.now().difference(lastTime!) > Duration(seconds: 2)) {
//       lastTime = DateTime.now();
//       LeoToast.showTip(LeoString.exit_tip);
//       return false;
//     } else {
//       // 自动出栈
//       return true;
//     }
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 异步UI更新
    return FutureBuilder(
      future: AppInit.init(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        HttpManager.getData(
          "http://baobab.kaiyanapp.com/api/v2/feed?num=1",
          success: (result) {
            print(result);
          },
        );
        print(snapshot.connectionState);
        var widget = snapshot.connectionState == ConnectionState.done
            ? TabNavigation()
            : Scaffold(
                body: Center(
                  // 圈
                  child: CircularProgressIndicator(),
                ),
              );

        return GetMaterialAppWidget(child: widget);
      },
    );
  }
}


class GetMaterialAppWidget extends StatefulWidget {
  final Widget? child;

  GetMaterialAppWidget({Key? key, this.child}) : super(key: key);

  @override
  _GetMaterialAppWidgetState createState() => _GetMaterialAppWidgetState();
}

class _GetMaterialAppWidgetState extends State<GetMaterialAppWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EyePetizer',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => widget.child!,
      },
    );
  }
}
