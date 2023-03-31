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
  late Future<BillList> futureBills;

  @override
  void initState() {
    super.initState();
    futureBills = fetchBillList();
  }

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
  late Future<BillList> futureBillList;

  @override
  void initState() {
    super.initState();
    futureBillList = fetchBillList();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Live Bill Updating"),
      ),
      body: Center(

        child: FutureBuilder<BillList>(


            future: futureBillList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.title);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },

        ),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
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

  factory BillList.fromJson(Map<String, dynamic> json) {
    return BillList(
      title: json["bills"][0]["title"],
      action: json["bills"][0]["latestAction"]["text"],
      id: json["bills"][0]["number"],
    );
  }
}

Future<BillList> fetchBillList() async {
  final response = await http.get(Uri.parse(
      'https://api.congress.gov/v3/bill?api_key=CqI23WOUucHVKgqkyFmTcio5UiReagjYGSuQR1pn'));

  if (response.statusCode == 200) {
    return BillList.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to Load Bills");
  }
}