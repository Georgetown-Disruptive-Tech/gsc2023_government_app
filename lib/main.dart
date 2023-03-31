import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Bill> futureBill1;
  late Future<Bill> futureBill2;
  late Future<Bill> futureBill3;

  @override
  void initState() {
    super.initState();
    futureBill1 = fetchBill(0);
    futureBill2 = fetchBill(1);
    futureBill3 = fetchBill(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Live Bill Updating"),
      ),
      
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(10.0),
          color: Color.fromARGB(255, 36, 106, 149),
          width: 1130.0,
          height: 400.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            FutureBuilder<Bill>(
              
              future: futureBill1,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    child: Column(children: [
                      Text(snapshot.data!.title,
                      style: Theme.of(context).textTheme.titleLarge,),

                      Text(snapshot.data!.action,
                      style: Theme.of(context).textTheme.titleLarge,),

                      Text(snapshot.data!.id,
                      style: Theme.of(context).textTheme.titleLarge,),
                      Text(""),
                      Text(""),


                    ]),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
            FutureBuilder<Bill>(
              future: futureBill2,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    child: Column(children: [
                      Text(snapshot.data!.title,
                      style: Theme.of(context).textTheme.titleLarge,),

                      Text(snapshot.data!.action,
                      style: Theme.of(context).textTheme.titleLarge,),

                      Text(snapshot.data!.id,
                      style: Theme.of(context).textTheme.titleLarge,),
                      Text(""),
                      Text(""),

                    ]),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
            FutureBuilder<Bill>(
              future: futureBill3,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    child: Column(children: [
                      Text(snapshot.data!.title,
                      style: Theme.of(context).textTheme.titleLarge,),

                      Text(snapshot.data!.action,
                      style: Theme.of(context).textTheme.titleLarge,),

                      Text(snapshot.data!.id,
                      style: Theme.of(context).textTheme.titleLarge,)
                    ]),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ]),
        ),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}

class Bill {
  final String title;
  final String action;
  final String id;

  const Bill({
    required this.id,
    required this.title,
    required this.action,
  });

  factory Bill.fromJson(Map<String, dynamic> json, int num) {
    return Bill(
      title: json["bills"][num]["title"],
      action: json["bills"][num]["latestAction"]["text"],
      id: json["bills"][num]["number"],
    );
  }
}

Future<Bill> fetchBill(int num) async {
  final response = await http.get(Uri.parse(
      'https://api.congress.gov/v3/bill?api_key=CqI23WOUucHVKgqkyFmTcio5UiReagjYGSuQR1pn'));

  print("HELP ME");

  if (response.statusCode == 200) {
    return Bill.fromJson(jsonDecode(response.body), num);
  } else {
    throw Exception("Failed to Load Bills");
  }
}

