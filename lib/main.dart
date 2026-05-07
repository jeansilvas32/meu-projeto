import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _alturaController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();
  double altura = 0;
  double peso = 0;
  double imc = 0;
  bool mostraResultado = false;

  void calcularImc() {
    imc = (peso / (altura * altura));
  }

  String classificacaoImc(double imc) {
    if (imc < 18.5)
      return 'Abaixo do peso';
    else if (imc < 25)
      return 'Peso normal';
    else if (imc < 30)
      return 'Sobrepeso';
    else if (imc < 35)
      return 'Obesidade grau I';
    else if (imc < 40)
      return 'Obesidade grau II';
    else
      return 'Obesidade grau III';
  }

  Color mudarCor() {
    if (imc < 18.5) {
      return Colors.red;
    } else if (imc < 25) {
      return Colors.green;
    } else {
      return const Color.fromARGB(255, 151, 19, 10);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("IMC"), backgroundColor: Colors.blue),
        backgroundColor: const Color.fromARGB(255, 252, 253, 255),
        body: Center(
          child: Padding(
            padding: EdgeInsetsGeometry.only(top: 400, right: 300, left: 300),
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  spacing: 10,
                  children: [
                    TextFormField(
                      controller: _pesoController,
                      decoration: InputDecoration(
                        hintText: 'Digite seu peso',
                        labelText: 'PESO',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.scale),
                      ),
                    ),
                    TextFormField(
                      controller: _alturaController,
                      decoration: InputDecoration(
                        hintText: 'Digite seu altura',
                        labelText: 'ALTURA',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.accessibility),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                peso = double.parse(
                                  _pesoController.text.replaceAll(',', '.'),
                                );
                                altura = double.parse(
                                  _alturaController.text.replaceAll(',', '.'),
                                );
                                calcularImc();

                                mostraResultado = true;
                              });
                            }
                          },
                          child: Text('resultado/IMC'),
                        ),

                        SizedBox(width: 75),

                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _pesoController.clear();
                              _alturaController.clear();
                              mostraResultado = false;
                            });
                          },
                          child: Text("Novo calculo"),
                        ),
                      ],
                    ),

                    if (mostraResultado)
                      Container(
                        width: 300,
                        height: 50,
                        decoration: BoxDecoration(color: mudarCor()),

                        child: Center(
                          child: Text(
                            "Seu imc: ${imc.toStringAsFixed(2)} - ${classificacaoImc(imc)}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
