/*import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class BillList {
  final String title;
  final String action;
  final int id;

  const BillList({
    required this.id,
    required this.title,
    required this.action,
  });

  factory BillList.fromJson(Map<String, dynamic> json){
    return BillList(
      //fill in later
    )
  }
  */
  
  /////////////////////////NEW CODE///////////////////
  
  /*
  import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends NoStateWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'US Government Bills',
      home: BillList(),
    );
  }
}


class BillList extends StateWidget {
  @override
  _BillListState createState() => _BillListState();
}

class _BillListState extends State<BillList> {
  List<dynamic> _bills = [];

  @override
  void initState() {
    super.initState();
    _getBills();
  }

  Future<void> _getBills() async {
    final response = await http.get(Uri.parse(
        'https://openstates.org/api/v1/bills/?state=us&search_window=session&order=updated_at&page=1&per_page=10'));

    if (response.statusCode == 200) {
      setState(() {
        _bills = jsonDecode(response.body) as List<dynamic>;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('US Government Bills'),
      ),
      body: ListView.builder(
        itemCount: _bills.length,
        itemBuilder: (context, index) {
          final bill = _bills[index];
          return ListTile(
            title: Text(bill['title']),
            subtitle: Text('Sponsor: ${bill['sponsor']['name']}'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Navigate to bill details screen
            },
          );
        },
      ),
    );
  }
}

////new new code

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'New US Government Bills',
      initialRoute: '/',
      routes: {
        '/': (context) => BillList(),
        '/bill_details': (context) => BillDetails(),
      },
    );
  }
}

class BillList extends StatefulWidget {
  @override
  _BillListState createState() => _BillListState();
}

class _BillListState extends State<BillList> {
  List<dynamic> _bills = [];

  @override
  void initState() {
    super.initState();
    _fetchBills();
  }

  Future<void> _fetchBills() async {
    final response = await http.get(Uri.parse(
        'https://openstates.org/api/v1/bills/?state=us&search_window=session&order=updated_at&page=1&per_page=10'));

    if (response.statusCode == 200) {
      setState(() {
        _bills = jsonDecode(response.body) as List<dynamic>;
      });
    }
  }

  void _navigateToBillDetails(BuildContext context, dynamic bill) {
    Navigator.pushNamed(context, '/bill_details', arguments: bill);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New US Government Bills'),
      ),
      body: ListView.builder(
        itemCount: _bills.length,
        itemBuilder: (context, index) {
          final bill = _bills[index];
          return ListTile(
            title: Text(bill['title']),
            subtitle: Text('Sponsor: ${bill['sponsor']['name']}'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => _navigateToBillDetails(context, bill),
          );
        },
      ),
    );
  }
}

class BillDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dynamic bill = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(bill['title']),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sponsor: ${bill['sponsor']['name']}'),
            SizedBox(height: 16.0),
            Text(bill['description']),
          ],
        ),
      ),
    );
  }
}

*/


//NEW NEW CODE WITH NOTHING MISSING 
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp( MyApp());

 class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<BillList> futureBillList;
  @override
  void initState() {
    super.initState();
    futureBillList = fetchBillList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Government Live Bill Updating',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Live Bill Updating'),
        ),
        body: Center(
          child: FutureBuilder<BillList>(
            future: futureBillList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                //return (
                  Text(snapshot.data!.title);
                  Text(snapshot.data!.id);
                  return Text(snapshot.data!.action);
                //);

              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

class BillList {
  final String title;
  final String action;
  final String id;

  const BillList({
    required this.id,
    required this.title,
    required this.action,
  });

  factory BillList.fromJson(Map<String, dynamic> json){
    return BillList(

      id: json['userId'],
      action: json['action'],
      title: json['title'],
      //fill in later
    );
  }
}

Future<BillList> fetchBillList() async {
  final response = await http.get(Uri.parse(
      'https://openstates.org/api/v1/bills/?state=us&search_window=session&order=updated_at&page=1&per_page=10'));

  if (response.statusCode == 200) {

    return BillList.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Data');
  }
}



//}



