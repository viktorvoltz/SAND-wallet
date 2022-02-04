import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SendEther extends StatefulWidget {
  const SendEther({ Key? key }) : super(key: key);

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Send ETH To ...', style: GoogleFonts.titilliumWeb()),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: TextField(
                controller: address,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter address to send to",
                  labelText: "Address",
                  errorText: address.text.startsWith('0x') ? null : 'Enter a valid ETH address'
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}