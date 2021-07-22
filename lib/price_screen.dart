import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}


class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency='USD';
  String cryptoCurr='BTC';
  String cryptoCurr1='ETH';
  String cryptoCurr2='LTC';
  double cryptoRate;
  double cryptoRate1;
  double cryptoRate2;

  @override
  void initState()
  {
    super.initState();
    getPriceData();
  }

  DropdownButton<String> androidDropDown()
  {
    List<DropdownMenuItem<String>> dropdownItems=[];
    for(int i=0; i<currenciesList.length;i++)
    {
      String currency=currenciesList[i];
      var newItem=DropdownMenuItem(
        child:Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
      value:selectedCurrency,
      items:dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getPriceData();
        });
      },);
  }

  CupertinoPicker iosPicker(){

    List<Widget> pickerItems=[];
    for(int i=0;i<currenciesList.length;i++)
    {
      var textWidget=Text(currenciesList[i]);
      pickerItems.add(textWidget);
    }

    return CupertinoPicker(itemExtent: 32.0,onSelectedItemChanged: (selectedIndex)
    {
      print(selectedIndex);
    },
      children:
      pickerItems,
    );
  }

  Widget getPicker()
  {
    if(Platform.isIOS)
      {
        return iosPicker();
      }
    else if(Platform.isAndroid)
      {
        return androidDropDown();
      }
  }

  void getPriceData() async
  {
    CoinData coinDataObj= CoinData();
    for(int i=0;i<cryptoList.length;i++)
    {
      String cryptoCurrency=cryptoList[i];
      var coinData= await coinDataObj.getCryptoPrice(cryptoList[i], selectedCurrency);
      if(coinData==null)
      {
        print('err');
        cryptoCurr='null';
        cryptoRate=0.0;
      }
      else
      {
        if(cryptoList[i]=='BTC')
          {
            cryptoRate=coinData['rate'];
          }
        else if(cryptoList[i]=='ETH')
          {
            cryptoRate1=coinData['rate'];
          }
        else if(cryptoList[i]=='LTC')
          {
            cryptoRate2=coinData['rate'];
          }
      }
    }
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
          Center(
            child: Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 28.0),
                    child: Text(
                      '1 BTC = $cryptoRate $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = $cryptoRate1 $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = $cryptoRate2 $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 50.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getPicker(),

            // child: Platform.isIOS ? iosPicker() : androidDropDown(),
            // child: DropdownButton(
            //     value:selectedCurrency,
            //     items: getDropdownItems()
            //     , onChanged:(value)
            //         {
            //           setState(()
            //           {
            //             selectedCurrency=value;
            //           });
            //         }
            // ),
          ),
        ],
      ),
    );
  }
}
