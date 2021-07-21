import 'Network.dart';

const apiKey='040473E9-4C44-4A0D-AA7B-3EDEB4AB1DCA';
const apiUrl='https://rest.coinapi.io/v1/exchangerate';

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

class CoinData
{
  Future<dynamic> getCryptoPrice(String cryptoCurr,String fiatCurr) async
  {
    var url='$apiUrl/$cryptoCurr/$fiatCurr?apikey=$apiKey';
    NetworkHelper networkHelper=NetworkHelper(url);

    var coinData= await networkHelper.getData();
    print(url);
    return coinData;
  }
}
