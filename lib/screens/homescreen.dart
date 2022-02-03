import 'package:flutter/material.dart';
import 'package:web3_transactions/provider/contractProvider.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ContractProvider contractProvider = Provider.of<ContractProvider>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: contractProvider.ownAdress.toString() == 'null'
              ? Text('null address: ')
              : Text('${contractProvider.ownAdress.toString().substring(0, 5)}' + '...' + '${contractProvider.ownAdress.toString().substring(38, 42)}',
                  overflow: TextOverflow.ellipsis, style: GoogleFonts.titilliumWeb()),
          actions: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.orange,
              child: CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('assets/Flow.png'),
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Text('${contractProvider.balance!.getInEther.toString()} ETH', style: GoogleFonts.titilliumWeb()),
          ),
          Center(
            child: Text(contractProvider.ownAdress.toString(),
                overflow: TextOverflow.fade),
          ),
        ],
      ),
    );
  }
}
