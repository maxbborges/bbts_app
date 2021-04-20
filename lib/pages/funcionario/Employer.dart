import 'package:bbts_flutter/pages/ListEmployees.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bbts_flutter/providers/db_provider.dart';
import 'package:bbts_flutter/providers/db_provider_mysql.dart';
import 'package:bbts_flutter/providers/api_provider.dart';

class Employer extends StatefulWidget {
  @override
  _EmployerState createState() => _EmployerState();
}

class _EmployerState extends State<Employer> {
  getEmployer(argumentos) {
    return FutureBuilder(
      future: DBProvider_mysql.db.getEmployer(argumentos['matricula']),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Carregando dados!',
                  style: const TextStyle(fontSize: 20),
                ),
                LinearProgressIndicator(
                  // value: controller.value,
                  semanticsLabel: 'Linear progress indicator',
                ),
              ],
            ),
          );
        } else {
          var resultado = snapshot.data;
          return Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Image(
                        image: AssetImage('assets/images/avatar.png'),
                      ),
                      // child: ClipRRect(
                      //   borderRadius: BorderRadius.circular(8.0),
                      //   child: Image.network(
                      //     'https://via.placeholder.com/150',
                      //     height: 200.0,
                      //     width: 150.0,
                      //   ),
                      // ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Nome: ',
                              style: TextStyle(
                                  fontSize: 30.0,
                                  height: 1.0,
                                  color: Colors.black),
                            ),
                            Text(
                              resultado["nome"] == null
                                  ? ''
                                  : '${resultado["nome"]}',
                              style: TextStyle(
                                  fontSize: 25.0,
                                  height: 1.0,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'CPF: ',
                              style: TextStyle(
                                  fontSize: 30.0,
                                  // height: 2.0,
                                  color: Colors.black),
                            ),
                            Text(
                              resultado["cpf"] == null
                                  ? ''
                                  : '${resultado["cpf"]}',
                              style: TextStyle(
                                  fontSize: 30.0,
                                  // height: 2.0,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'RG: ',
                              style: TextStyle(
                                  fontSize: 30.0,
                                  // height: 2.0,
                                  color: Colors.black),
                            ),
                            Text(
                              resultado["rg"] == null
                                  ? ''
                                  : '${resultado["rg"]}',
                              style: TextStyle(
                                  fontSize: 30.0,
                                  // height: 2.0,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Chave_c: ',
                              style: TextStyle(
                                  fontSize: 30.0,
                                  // height: 2.0,
                                  color: Colors.black),
                            ),
                            Text(
                              resultado["chave_c"] == null
                                  ? ''
                                  : '${resultado["chave_c"]}',
                              style: TextStyle(
                                  fontSize: 30.0,
                                  // height: 2.0,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Cartao BB: ',
                              style: TextStyle(
                                  fontSize: 30.0,
                                  // height: 2.0,
                                  color: Colors.black),
                            ),
                            Text(
                              resultado["cartao_bb"] == null
                                  ? ''
                                  : '${resultado["cartao_bb"]}',
                              style: TextStyle(
                                  fontSize: 30.0,
                                  // height: 2.0,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Cartao BBTS: ',
                              style: TextStyle(
                                  fontSize: 30.0,
                                  // height: 2.0,
                                  color: Colors.black),
                            ),
                            Text(
                              resultado["cartao_bbts"] == null
                                  ? ''
                                  : '${resultado["cartao_bbts"]}',
                              style: TextStyle(
                                  fontSize: 30.0,
                                  // height: 2.0,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Cartao Capital: ',
                              style: TextStyle(
                                  fontSize: 30.0,
                                  // height: 2.0,
                                  color: Colors.black),
                            ),
                            Text(
                              resultado["cartao_capital"] == null
                                  ? ''
                                  : '${resultado["cartao_capital"]}',
                              style: TextStyle(
                                  fontSize: 30.0,
                                  // height: 2.0,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'N. Contrato: ',
                              style: TextStyle(
                                  fontSize: 30.0,
                                  // height: 2.0,
                                  color: Colors.black),
                            ),
                            Text(
                              resultado["num_contrato"] == null
                                  ? ''
                                  : '${resultado["num_contrato"]}',
                              style: TextStyle(
                                  fontSize: 30.0,
                                  // height: 2.0,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map argumentos = ModalRoute.of(context)!.settings.arguments as Map;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Funcionario'),
      ),
      body: getEmployer(argumentos),
    );
  }
}
