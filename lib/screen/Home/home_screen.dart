import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'components/body.dart';

class HomeScreen extends StatefulWidget {
  final String id;
  HomeScreen({this.id});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static final storage = new FlutterSecureStorage();
  String id;
  String pw;
  String userInfo = '';
  @override
  void initState() {
    super.initState();
    id = widget.id;
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    // _asyncMethod();
    // });
    print("요거요거 : $id");
  }

  _asyncMethod() async {
    userInfo = await storage.read(key: "login");
    id = userInfo;
    print(userInfo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        id: id,
      ),
    );
  }
}
