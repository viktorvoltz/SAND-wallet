import 'package:flutter/material.dart';
import 'package:web3_transactions/provider/contractProvider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ContractProvider contractProvider = Provider.of<ContractProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('address: ${contractProvider.ownAdress.toString()}'),
        actions: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.orange,
            child: CircleAvatar(
              radius: 45,
              backgroundImage: AssetImage('assets/Flow.png'),
            ),
          )
        ],
      ),
    );
  }
}