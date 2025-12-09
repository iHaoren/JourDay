import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: FirstPage()));
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      backgroundColor: Colors.teal[400],
      leading: Icon(Icons.home_rounded,
      color: Colors.white,),
      title: Text('Flashcard Me',
      style: TextStyle(color: Colors.white),),
      actions: <Widget>[
        Icon(Icons.search),
      ]
    ));
  }
}
