import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web3_transactions/screens/homescreen.dart';
import 'package:web3_transactions/screens/recieveether.dart';
import 'package:web3_transactions/screens/sendether.dart';

import 'provider/contractProvider.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider<ContractProvider>(
      create: (_) => ContractProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/sendeth': (context) => const SendEther(),
        },
      ),
    );
  }
}