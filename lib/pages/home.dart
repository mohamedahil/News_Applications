import 'package:flutter/material.dart';
import 'package:quote_app/apidata/apidata.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Map<String, String>> userList = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final data = await ApiService.fetchUserData();
    setState(() {
      userList = data;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("API Application"), centerTitle: true),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: userList.length,
        itemBuilder: (context, index) {
          final user = userList[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Author: ${user['author']}", style: const TextStyle(fontSize: 16,fontWeight:FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text("Title: ${user['title']}", style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 4),
                  Text("Date: ${user['news']}", style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 4),
                  Image.network(
                    user['image']!,
                  width: double.infinity,
                height: 150,)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
