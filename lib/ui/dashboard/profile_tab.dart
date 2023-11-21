import 'package:flutter/material.dart';
import 'package:test_app/services/locator.dart';
import 'package:test_app/services/sharedprefs_services.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final SharedPrefsService _sharedPrefsService = locator<SharedPrefsService>();
  String _username = '';
  String _email = '';

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  void _loadUserInfo() async {
    setState(() {
      _username = _sharedPrefsService.read(SharedPrefsService.USERNAME) ?? '';
      _email = _sharedPrefsService.read(SharedPrefsService.LOGIN_EMAIL) ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Username: $_username',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          Text(
            'Email: $_email',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}