import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web3_transactions/provider/contractProvider.dart';
import 'package:provider/provider.dart';

class SendEther extends StatefulWidget {
  const SendEther({Key? key}) : super(key: key);

  @override
  _SendEtherState createState() => _SendEtherState();
}

class _SendEtherState extends State<SendEther> {
  TextEditingController address = TextEditingController();
  TextEditingController amount = TextEditingController();
  bool _validate = false;

  @override
  void dispose() {
    address.dispose();
    amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ContractProvider contractProvider = Provider.of<ContractProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Send ETH To ...', style: GoogleFonts.titilliumWeb()),
        elevation: 5.0,
        shadowColor: const Color.fromARGB(255, 140, 12, 179),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: TextField(
                enableInteractiveSelection: true,
                controller: address,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter address to send to",
                    labelText: "Address",
                    errorText: address.text.isNotEmpty && address.text.startsWith('0x')
                        ? null
                        : "Enter correct ETH address"),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: double.infinity,
              child: TextField(
                enableInteractiveSelection: true,
                controller: amount,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter amount",
                  labelText: "Amount in ETH",
                ),
              ),
            ),
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 37),
                  height: 20,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0
                    )
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black
                    ),
                    child: Text(
                      'Send  🌈',
                      style: GoogleFonts.titilliumWeb(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2.0
                      ),
                    ),
                    onPressed: () {
                      contractProvider.sendEther(amount.text, address.text);
                      FocusScope.of(context).unfocus();
                      address.clear();
                      amount.clear();
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
