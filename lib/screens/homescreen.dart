import 'package:flutter/material.dart';
import 'package:web3_transactions/provider/contractProvider.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web3_transactions/services/http.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<Map<String, dynamic>>? cryptoPrice;

  @override
  void initState() {
    cryptoPrice = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ContractProvider contractProvider = Provider.of<ContractProvider>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: contractProvider.ownAdress.toString() == 'null'
              ? Text('null address: ')
              : Text(
                  '${contractProvider.ownAdress.toString().substring(0, 5)}' +
                      '...' +
                      '${contractProvider.ownAdress.toString().substring(38, 42)}',
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.titilliumWeb(),
                ),
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
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            height: 40,
            child: SvgPicture.asset('assets/eth.svg'),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 5),
            child: Text(
                '${contractProvider.balance!.getInEther.toString()} ETH ',
                style: GoogleFonts.titilliumWeb(
                    fontWeight: FontWeight.w700, fontSize: 25)),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 30),
            child: cryptoData(contractProvider),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(40, 40), shape: const CircleBorder()),
                    onPressed: () {
                      Navigator.pushNamed(context, '/sendeth');
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Icon(Icons.send),
                    ),
                  ),
                  Container(
                    child: Text('Send', style: GoogleFonts.titilliumWeb()),
                  )
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(40, 40), shape: const CircleBorder()),
                    onPressed: () {},
                    child: Container(
                      alignment: Alignment.center,
                      child: Icon(Icons.arrow_downward_sharp),
                    ),
                  ),
                  Container(
                    child: Text('Recieve', style: GoogleFonts.titilliumWeb()),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  FutureBuilder cryptoData(ContractProvider contractProvider) {
    return FutureBuilder(
      future: cryptoPrice,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            String dollarPrice = snapshot.data["USD"].toString();
            var dPrice = double.parse(dollarPrice);
            String ethPrice = contractProvider.balance!.getInEther.toString();
            var ePrice = double.parse(ethPrice);
            double newUSDPrice = dPrice * ePrice;
            //print('${newUSDPrice.toString().substring(0, 5)}' + 'USD');
            return Container(
              child: Text('\$${newUSDPrice.toString().substring(0, 5)} USD',
                  style: GoogleFonts.titilliumWeb()),
            );
          } else if (snapshot.hasError) {
            return Text("couldn't get price");
          }
        }
        return Container(child: Text("... loading price"));
      },
    );
  }
}
