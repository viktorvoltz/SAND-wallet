import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:web3_transactions/provider/contractProvider.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

void modalBottomSheetMenu(BuildContext context, String address) {
  final box = context.findRenderObject() as RenderBox?;
  showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      context: context,
      builder: (builder) {
        return FractionallySizedBox(
          heightFactor: 0.7,
          child: new Container(
            height: 600.0,
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
                      color: const Color.fromARGB(255, 140, 12, 179),
                      borderRadius: BorderRadius.circular(30)),
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
                const SizedBox(height: 10),
                QrImage(
                  data: address,
                  size: 250,
                  embeddedImageStyle: QrEmbeddedImageStyle(size: Size(80, 80)),
                ),
                Text("Scan QR to get address",
                    style: GoogleFonts.titilliumWeb()),
                const SizedBox(height: 30),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.symmetric(horizontal: 70),
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black45),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${address.substring(0, 5)}' +
                            '...' +
                            '${address.substring(38, 42)}',
                        style: GoogleFonts.titilliumWeb(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(
                            ClipboardData(text: address),
                          ).then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                behavior: SnackBarBehavior.floating,
                                content: Text("Address copied to clipboard"),
                              ),
                            );
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          alignment: Alignment.center,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.black87,
                          ),
                          child: Text(
                            "Copy",
                            style: GoogleFonts.titilliumWeb(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () async{
                          await Share.share(address, sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
                        },
                        child: Container(
                          child: Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      });
}
