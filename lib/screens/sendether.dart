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
                    errorText: address.text.startsWith('0x')
                        ? null
                        : 'Enter a valid ETH address'),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: double.infinity,
              child: ElevatedButton(
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
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
