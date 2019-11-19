import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData model = CoinData();

  String selectedCurrency = 'USD';
  Map<String, double> values = {'BTC': 0.0, 'ETH': 0.0, 'LTC': 0.0};

  // UI - Currency cards
  List<Widget> getCurrencyCards() {
    List<Widget> list = [];

    for (var crypto in cryptoList) {
      list.add(
        CryptoCard(
            crypto: crypto, values: values, selectedCurrency: selectedCurrency),
      );
    }

    return list;
  }

  // UI - Dropdowns
  List<DropdownMenuItem> getDropdownItems() {
    List<DropdownMenuItem<String>> list = [];

    for (String currency in currenciesList) {
      list.add(DropdownMenuItem(
        child: Text(currency),
        value: currency,
      ));
    }

    return list;
  }

  List<Widget> getPickerItems() {
    List<Widget> list = [];

    for (String currency in currenciesList) {
      list.add(
        Text(currency),
      );
    }

    return list;
  }

  DropdownButton androidPicker() {
    return DropdownButton<String>(
      value: selectedCurrency,
      items: getDropdownItems(),
      onChanged: (value) {
        getLatestValue(value);
      },
    );
  }

  CupertinoPicker iOSPicker() {
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        getLatestValue(currenciesList[selectedIndex]);
      },
      children: getPickerItems(),
    );
  }

  // Helper Methods
  void getLatestValue(String currency) async {
    var data = await model.getCoinData(currency);

    setState(() {
      for (String crypto in cryptoList) {
        values[crypto] = data['$crypto$currency']['last'];
        values[crypto] = data['$crypto$currency']['last'];
        values[crypto] = data['$crypto$currency']['last'];
      }

      selectedCurrency = currency;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: getCurrencyCards(),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidPicker(),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    Key key,
    @required this.crypto,
    @required this.values,
    @required this.selectedCurrency,
  }) : super(key: key);

  final String crypto;
  final Map<String, double> values;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $crypto = ${values[crypto].toStringAsFixed(2)} $selectedCurrency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
