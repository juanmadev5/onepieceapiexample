import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model/response_model.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const Scaffold(
        body: Center(
          child: Home(),
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String data = "Fetching data...";
  bool isReady = false;
  List<Character> characters = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url = Uri.parse('https://api.api-onepiece.com/v2/characters/en/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        isReady = true;
        final List<dynamic> lResponse = json.decode(response.body);
        characters = lResponse
            .map((characterJson) => Character.fromJson(characterJson))
            .toList();
        data = "Ready";
      });
    } else {
      setState(() {
        data = "Error fetching data :(";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OnePiece API (${characters.length} elements)'),
      ),
      body: isReady
          ? ListView.builder(
              itemCount: characters.length,
              itemBuilder: (context, index) {
                return showData(index);
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget showData(int i) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        elevation: 8.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name: ${characters[i].name}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text('Age: ${characters[i].job ?? "Unknown"}'),
              Text('Size: ${characters[i].size ?? "Unknown"}'),
              Text('Birthday: ${characters[i].birthday ?? "Unknown"}'),
              Text('Age: ${characters[i].age ?? "Unknown"}'),
              Text('Bounty: ${characters[i].bounty ?? "Unknown"}'),
              Text('Status: ${characters[i].status ?? "Unknown"}'),
            ],
          ),
        ),
      ),
    );
  }
}
