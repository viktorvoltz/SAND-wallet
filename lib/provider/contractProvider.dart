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
  String privateKey = dotenv.env["PRIVATE_KEY"]!;

  Web3Client? _client;

  bool isLoading = true;

  String? _abiCode;
  EthereumAddress? _contractAddress;
  EthereumAddress? ownAdress;
  EthereumAddress? _reciever;
  EtherAmount? balance;

  Credentials? _credentials;

  DeployedContract? _contract;
  ContractFunction? _yourName;
  ContractFunction? _setName;

  String? deployedName;
  String recieverAddress = '';

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
    balance = await _client!.getBalance(ownAdress!);
   _reciever = EthereumAddress.fromHex(recieverAddress);
  }
}