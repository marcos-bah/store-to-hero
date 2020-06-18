import 'package:flutter/material.dart';
import 'package:loja_to_hero/models/user_model.dart';
import 'package:loja_to_hero/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
        title: 'Flutter`s Agro',
        theme: ThemeData(
          primarySwatch: Colors.green,
          primaryColor: Colors.lightGreen,
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
