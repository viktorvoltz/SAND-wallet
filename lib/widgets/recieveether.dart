import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:web3_transactions/provider/contractProvider.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

void modalBottomSheetMenu(BuildContext context, String address) {
  showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      context: context,
      builder: (builder) {
        return new Container(
          height: 450.0,
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(30)
                ),
              ),
              Container(
                height: 0.5,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  "Recieve",
                  style: GoogleFonts.titilliumWeb(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 10),
              QrImage(
                data: address,
                size: 250,
                embeddedImageStyle: QrEmbeddedImageStyle(size: Size(80, 80)),
              )
            ],
          ),
        );
      });
}
