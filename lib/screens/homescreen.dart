import 'package:flutter/material.dart';
import 'package:web3_transactions/provider/contractProvider.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web3_transactions/widgets/recieveether.dart';
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
    List<Map<String, String>> reversedTransaction =
        contractProvider.transaction.reversed.toList();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
                  '${contractProvider.balance!.getInEther.toDouble().toString()} ETH ',
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
                    Container(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(40, 40),
                          shape: const CircleBorder(),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/sendeth');
                        },
                        child: Container(
                          child: SvgPicture.asset(
                            'assets/sendETH.svg',
                            alignment: Alignment.center,
                            fit: BoxFit.scaleDown,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Text('Send', style: GoogleFonts.titilliumWeb()),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            alignment: Alignment(0.0, 0.0)
                            ),
                        onPressed: () {
                          modalBottomSheetMenu(
                              context, contractProvider.ownAdress.toString());
                        },
                        child: Icon(
                          Icons.arrow_downward_sharp,
                          size: 40,
                        ),
                      ),
                    ),
                    Container(
                      child: Text('Recieve', style: GoogleFonts.titilliumWeb()),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              child: TabBar(
                unselectedLabelColor: Colors.black45,
                labelColor: Colors.black,
                tabs: [
                  Tab(
                      child: Text(
                    "Activity 🌟",
                    style: GoogleFonts.titilliumWeb(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  )),
                  Tab(
                    child: Text(
                      "Assets 🗽",
                      style: GoogleFonts.titilliumWeb(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
                isScrollable: true,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: TabBarView(children: [
                ListView.builder(
                  itemCount: reversedTransaction.length,
                  itemBuilder: (BuildContext context, index) {
                    return ListTile(
                      horizontalTitleGap: 1.0,
                      leading: Container(
                        height: 25,
                        width: 25,
                        child: SvgPicture.asset(
                          'assets/activitySend.svg',
                          color: Colors.red,
                        ),
                      ),
                      title: Container(
                        child: Text(
                            'To: ${reversedTransaction[index]["to"]!.substring(0, 31)}...',
                            overflow: TextOverflow.fade,
                            style: GoogleFonts.titilliumWeb(
                                fontWeight: FontWeight.w700)),
                      ),
                      subtitle: Text(
                        'From: ${reversedTransaction[index]["from"]!.substring(0, 31)}...',
                        overflow: TextOverflow.fade,
                      ),
                      trailing: Text(
                          '${reversedTransaction[index]["amount"]!} ETH',
                          style: GoogleFonts.titilliumWeb(
                              fontWeight: FontWeight.w700, fontSize: 16)),
                    );
                  },
                ),
                Container(
                  child: Center(
                    child: Text(
                      "NFTs are coming to SAND Soon 👽",
                      style: GoogleFonts.titilliumWeb(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ]),
            )
          ],
        ),
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
            return Text("couldn't fetch price");
          }
        }
        return Container(child: Text("... loading price"));
      },
    );
  }
}
