import 'dart:convert';
import 'package:http/http.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future getCoinData(String currency) async {
    String url =
        'https://apiv2.bitcoinaverage.com/indices/global/ticker/short?crypto=BTC,ETH,LTC&fiat=$currency';

    Response response = await get(url);

    if (response.statusCode == 200) {
      // ok
      print(response.body);
      return jsonDecode(response.body);
    } else {
      // uh-oh
      print(response.statusCode);
    }
  }
}
