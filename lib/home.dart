import 'package:conversor_de_moeda/variation.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var gold = Color.fromARGB(254, 242, 203, 87);
  var dark = Colors.grey[900];
  var dark2 = TextStyle(color: Colors.grey[900]);
  var message = TextStyle(
    color: Color.fromARGB(254, 242, 203, 87),
    fontSize: 25,
  );

  double dollar;
  double euro;
  double peso;
  double bitCoin;
  double libra;

  final realController = TextEditingController();
  final dollarController = TextEditingController();
  final euroController = TextEditingController();
  final pesoController = TextEditingController();
  final bitCoinController = TextEditingController();
  final libraController = TextEditingController();

  void _realChanged(String text) {
    if (text.isEmpty) {
      _clearFields();
      return;
    }
    double real = double.parse(text);
    dollarController.text = (real / dollar).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);
    pesoController.text = (real / peso).toStringAsFixed(2);
    bitCoinController.text = (real / bitCoin).toStringAsFixed(2);
    libraController.text = (real / libra).toStringAsFixed(2);
  }

  void _dollarChanged(String text) {
    if (text.isEmpty) {
      _clearFields();
      return;
    }
    double dollar = double.parse(text);
    realController.text = (dollar * this.dollar).toStringAsFixed(2);
    euroController.text = (dollar * this.dollar / euro).toStringAsFixed(2);
    pesoController.text = (dollar * this.dollar / peso).toStringAsFixed(2);
    bitCoinController.text = (dollar * this.dollar / bitCoin).toStringAsFixed(2);
    libraController.text = (dollar * this.dollar / libra).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    if (text.isEmpty) {
      _clearFields();
      return;
    }
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dollarController.text = (euro * this.euro / dollar).toStringAsFixed(2);
    pesoController.text = (euro * this.euro / peso).toStringAsFixed(2);
    bitCoinController.text = (euro * this.euro / bitCoin).toStringAsFixed(2);
    libraController.text = (euro * this.euro / libra).toStringAsFixed(2);
  }

  void _pesoChanged(String text) {
    if (text.isEmpty) {
      _clearFields();
      return;
    }
    double peso = double.parse(text);
    realController.text = (peso * this.peso).toStringAsFixed(2);
    dollarController.text = (peso * this.peso / dollar).toStringAsFixed(2);
    euroController.text = (peso * this.peso / euro).toStringAsFixed(2);
    bitCoinController.text = (peso * this.peso / bitCoin).toStringAsFixed(2);
    libraController.text = (peso * this.peso / libra).toStringAsFixed(2);
  }

  void _libraChanged(String text) {
    if (text.isEmpty) {
      _clearFields();
      return;
    }
    double libra = double.parse(text);
    realController.text = (libra * this.libra).toStringAsFixed(2);
    dollarController.text = (libra * this.libra / dollar).toStringAsFixed(2);
    euroController.text = (libra * this.libra / euro).toStringAsFixed(2);
    bitCoinController.text = (libra * this.libra / bitCoin).toStringAsFixed(2);
    pesoController.text = (libra * this.libra / peso).toStringAsFixed(2);
  }

  void _bitCoinChanged(String text) {
    if (text.isEmpty) {
      _clearFields();
      return;
    }
    double bitCoin = double.parse(text);
    realController.text = (bitCoin * this.bitCoin).toStringAsFixed(2);
    dollarController.text = (bitCoin * this.bitCoin / dollar).toStringAsFixed(2);
    euroController.text = (bitCoin * this.bitCoin / euro).toStringAsFixed(2);
    pesoController.text = (bitCoin * this.bitCoin / peso).toStringAsFixed(2);
    libraController.text = (bitCoin * this.bitCoin / libra).toStringAsFixed(2);
  }

  void _clearFields() {
    realController.text = "";
    dollarController.text = "";
    euroController.text = "";
    pesoController.text = "";
    bitCoinController.text = "";
    libraController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark,
      appBar: AppBar(
        backgroundColor: gold,
        title: Text('Conversor', style: dark2),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.equalizer,
                color: dark,
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Variation()));
              }),
        ],
      ),
      body: FutureBuilder<Map>(
        //Por que um MAP? pois a API retorna um mapa "Future<Map>"
        future: getData(),
        //Qual é o futuro que queremos que ele construa (pega o futuro dos dados)
        builder: (context, snapshot) {
          //nesse caso, snapshot é uma cópia isntantânea dos dados da API
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
                dollar = snapshot.data['results']['currencies']['USD']['buy'];
                euro = snapshot.data['results']['currencies']['EUR']['buy'];
                peso = snapshot.data['results']['currencies']['ARS']['buy'];
                bitCoin = snapshot.data['results']['currencies']['BTC']['buy'];
                libra = snapshot.data['results']['currencies']['GBP']['buy'];
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Image.asset(
                          'assets/change.png',
                          width: 150,
                          height: 150,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        buildTextField(
                            'Real', '\$ ', realController, _realChanged),
                        SizedBox(
                          height: 20,
                        ),
                        buildTextField(
                            'Dólar', 'US\$ ', dollarController, _dollarChanged),
                        SizedBox(
                          height: 20,
                        ),
                        buildTextField(
                            'Euro', '€ ', euroController, _euroChanged),
                        SizedBox(
                          height: 20,
                        ),
                        buildTextField(
                            'Peso', '\$ ', pesoController, _pesoChanged),
                        SizedBox(
                          height: 20,
                        ),
                        buildTextField(
                            'Libra', '£ ', libraController,
                            _libraChanged),
                        SizedBox(
                          height: 20,
                        ),
                        buildTextField('BitCoin', 'B ', bitCoinController,
                            _bitCoinChanged),
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

Widget buildTextField(String label, String prefix,
    TextEditingController controller, Function change) {
  var gold = Color.fromARGB(254, 242, 203, 87);

  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: gold),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
      prefixText: prefix,
    ),
    style: TextStyle(color: gold, fontSize: 25),
    keyboardType: TextInputType.number,
    onChanged: change,
  );
}
