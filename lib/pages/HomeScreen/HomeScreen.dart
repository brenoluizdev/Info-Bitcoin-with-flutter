// ignore_for_file: file_names
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'InfoBitcoin',
            style: TextStyle(
                fontFamily: 'Bebas', fontWeight: FontWeight.bold, fontSize: 30),
          ),
          centerTitle: true,
          foregroundColor: Colors.orangeAccent,
          backgroundColor: Colors.black,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/details');
              },
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
        body: Container(
            width: double.infinity,
            color: Colors.black,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      fillColor: Colors.white,
                      filled: true,
                      labelText: 'Pesquisar...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}
