/*
import 'package:gsc2023_government_app/main.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const LBUmain());
}
class LBUmain extends StatelessWidget {
  const LBUmain ({super.key})
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'government app',
      home: MyHomePage(),
    );
  }
} 

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex=0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
  ];

    void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Bill Updating'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Live Bills',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Profile',
          ),

        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 69, 51, 134),
        onTap: _onItemTapped,
      ),
    );
  }
}



class HomeSection extends StatelessWidget{
  const HomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text('Home'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text('Home'),
            ),
          ],
        ),
      ),
    );
  }
}
*/