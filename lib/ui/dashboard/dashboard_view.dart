import 'package:flutter/material.dart';
import 'package:test_app/ui/dashboard/home_tab.dart';
import 'package:test_app/ui/dashboard/order_tab.dart';
import 'package:test_app/ui/dashboard/profile_tab.dart';
import 'package:test_app/services/locator.dart';
import 'package:test_app/services/sharedprefs_services.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final SharedPrefsService _sharedPrefsService = locator<SharedPrefsService>();
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    HomeTab(),
    OrderTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.purple.shade50,
        title: Text("Dashboard"),
        actions: [
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                  onTap: () {
                    _sharedPrefsService.write(
                        SharedPrefsService.IS_LOGGED, false);
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/registration', (route) => false);
                  },
                  child: Text("Logout",
                      style: TextStyle(fontSize: 16, color: Colors.red))))
        ],
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
