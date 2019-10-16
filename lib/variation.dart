import 'package:conversor_de_moeda/custom_expansion_tile.dart' as custom;
import 'package:conversor_de_moeda/main.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class Variation extends StatefulWidget {
  @override
  _VariationState createState() => _VariationState();
}

class _VariationState extends State<Variation> {
  var white = Colors.white;
  var gold = Color.fromARGB(254, 242, 203, 87);
  var dark = Colors.grey[900];
  var dark2 = TextStyle(color: Colors.grey[900]);
  var value = TextStyle(
    color: Colors.green[700],
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  var message = TextStyle(
    color: Colors.grey[900],
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );


  double dollar;
  double euro;
  double peso;
  double bitCoin;
  double libra;
  String dollarName;
  String euroName;
  String pesoName;
  String bitCoinName;
  String libraName;
  double dollarBuy;
  double dollarSell;
  double euroBuy;
  double euroSell;
  double pesoBuy;
  double pesoSell;
  double bitCoinBuy;
  double bitCoinSell;
  double libraBuy;
  double libraSell;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark,
      appBar: AppBar(
        backgroundColor: gold,
        title: Text('Mais informações', style: dark2),
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(
                child: Text('Erro ao carregar os dados', style: message),
              );
              break;
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(gold),
                ),
              );
              break;
            case ConnectionState.active:
              return Center();
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                Center(
                  child: Text('Erro ao carregar os dados', style: message),
                );
              } else {
                dollar =
                    snapshot.data['results']['currencies']['USD']['variation'];
                dollarName =
                    snapshot.data['results']['currencies']['USD']['name'];
                dollarBuy =
                    snapshot.data['results']['currencies']['USD']['buy'];
                dollarSell =
                    snapshot.data['results']['currencies']['USD']['sell'];
                if (dollarSell == null){
                  dollarSell = 0;
                }

                euro =
                    snapshot.data['results']['currencies']['EUR']['variation'];
                euroName =
                    snapshot.data['results']['currencies']['EUR']['name'];
                euroBuy =
                    snapshot.data['results']['currencies']['EUR']['buy'];
                euroSell =
                    snapshot.data['results']['currencies']['EUR']['sell'];
                if (euroSell == null){
                  euroSell = 0;
                }

                peso =
                    snapshot.data['results']['currencies']['ARS']['variation'];
                pesoName =
                    snapshot.data['results']['currencies']['ARS']['name'];
                pesoBuy =
                    snapshot.data['results']['currencies']['ARS']['buy'];
                pesoSell =
                    snapshot.data['results']['currencies']['ARS']['sell'];
                if (pesoSell == null){
                  pesoSell = 0;
                }

                bitCoin =
                    snapshot.data['results']['currencies']['BTC']['variation'];
                bitCoinName =
                    snapshot.data['results']['currencies']['BTC']['name'];
                bitCoinBuy =
                    snapshot.data['results']['currencies']['BTC']['buy'];
                bitCoinSell =
                    snapshot.data['results']['currencies']['BTC']['sell'];
                if (bitCoinSell == null){
                  bitCoinSell = 0;
                }

                libra =
                    snapshot.data['results']['currencies']['GBP']['variation'];
                libraName =
                    snapshot.data['results']['currencies']['GBP']['name'];
                libraBuy =
                    snapshot.data['results']['currencies']['GBP']['buy'];
                libraSell =
                    snapshot.data['results']['currencies']['GBP']['sell'];
                if (libraSell == null){
                  libraSell = 0;
                }

                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Image.asset(
                          'assets/graph.png',
                          width: 150,
                          height: 150,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        customExpansionTile('$dollar', '$dollarName', '$dollarBuy', '$dollarSell'),
                        SizedBox(height: 20,),
                        customExpansionTile('$euro', '$euroName', '$euroBuy', '$euroSell'),
                        SizedBox(height: 20,),
                        customExpansionTile('$peso', '$pesoName', '$pesoBuy', '$pesoSell'),
                        SizedBox(height: 20,),
                        customExpansionTile('$libra', '$libraName', '$libraBuy', '$libraSell'),
                        SizedBox(height: 20,),
                        customExpansionTile('$bitCoin', '$bitCoinName', '$bitCoinBuy', '$bitCoinSell'),

                      ],
                    ),
                  ),
                );
              }
              break;
          }
        },
      ),
    );
  }
}

Widget customExpansionTile(String label, String name, String buy, String sell){
  var gold = Color.fromARGB(254, 242, 203, 87);
  var dark = Colors.grey[900];
  var value = TextStyle(
    color: Colors.green[700],
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  var message = TextStyle(
    color: Colors.grey[900],
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  return custom.ExpansionTile(
    title: Text(
      name,
      style: TextStyle(color: dark, fontSize: 25),
    ),
    headerBackgroundColor: gold,
    iconColor: dark,
    backgroundColor: Colors.white,
    children: <Widget>[
      Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('Variação: ', style: message,),
                Text(label, style: value,),
              ],
            ),
            Divider(color: dark),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('Compra: ', style: message,),
                Text(buy, style: value,),
              ],
            ),
            Divider(color: dark),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('Venda: ', style: message,),
                Text(sell, style: value,),
              ],
            ),
            Divider(color: dark),
          ],
        ),
      ),
    ],
  );
}