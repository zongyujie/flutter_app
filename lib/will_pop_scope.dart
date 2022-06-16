import 'package:flutter/material.dart';

class WillPopScopeTestRoute extends StatefulWidget {
  const WillPopScopeTestRoute({Key? key}) : super(key: key);

  @override
  State<WillPopScopeTestRoute> createState() => _WillPopScopeTestRouteState();
}

class _WillPopScopeTestRouteState extends State<WillPopScopeTestRoute> {
  late DateTime _lastPressedAt;

  @override
  void initState() {
    super.initState();
    _lastPressedAt = DateTime.now().subtract(const Duration(minutes: 1));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Container(
          alignment: Alignment.center,
          child: const Text("1秒内连续按两次返回键退出"),
        ),
        onWillPop: () async {
          if (DateTime.now().difference(_lastPressedAt) >
              Duration(seconds: 1)) {
            print('=======再按一次 Back 按钮退出');
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text("再按一次 Back 按钮退出")));
            _lastPressedAt = DateTime.now();
            return false;
          }
          print('=======退出');
          return true;
        });
  }
}
