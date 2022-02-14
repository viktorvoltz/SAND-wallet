import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web_socket_channel/io.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class ContractProvider extends ChangeNotifier {
  final String _rpcUrl = "http://10.0.2.2:7545";
  final String _wsUrl = "ws://10.0.2.2:7545/";
  String privateKey = '02645d06db5e36314368656b8b3442adec1105562e7b646b34f5c51e9dadd561';

  Web3Client? _client;

  bool isLoading = true;

  String? _abiCode;
  EthereumAddress? _contractAddress;
  EthereumAddress? ownAdress;
  EtherAmount? balance;

  Credentials? _credentials;

  String recieverAddress = '';
  List<Map<String, String>> transaction = [];

  ContractProvider() {
    initialSetup();
  }

  initialSetup() {
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });

    getAbi();
    getCredentials();
  }

  Future<void> getAbi() async {
    // Reading the contract abi
    String abiStringFile =
        await rootBundle.loadString("src/artifacts/HelloWorld.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);

    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
  }

  String recieverHex(String hex){
    recieverAddress = hex;
    return recieverAddress;
  }

  Future<void> getCredentials() async {
    _credentials = await _client!.credentialsFromPrivateKey(privateKey);
    ownAdress = await _credentials!.extractAddress();
    notifyListeners();
    //print(ownAdress.toString());
    await _balance();
  }

  EthereumAddress reciever(String rvalue){
    return EthereumAddress.fromHex(rvalue);
  }

  Future<void> sendEther(String value, String rvalue) async{
    await _client!.sendTransaction(
      _credentials!,
      Transaction(
        from: ownAdress,
        to: reciever(rvalue),
        value: EtherAmount.fromUnitAndValue(EtherUnit.ether, value),
      ),
    );
    await _balance();
    transactionHistory(rvalue, value);
  }

  Future<EtherAmount?> _balance() async {
    balance = await _client!.getBalance(ownAdress!);
    notifyListeners();
    return balance;
  }

  void transactionHistory(String recieverAddress, String amountSent){
    transaction.add(
      {
        "transaction_type": "Sent",
        "amount": amountSent,
        "from": ownAdress.toString(),
        "to": recieverAddress
      }
    );
    notifyListeners();
  }
}
