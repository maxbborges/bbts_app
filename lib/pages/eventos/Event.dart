import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:bbts_flutter/providers/db_provider_mysql.dart';

class Event extends StatefulWidget {
  @override
  _EventState createState() => _EventState();
}

class _EventState extends State<Event> {
  getEvent(argumentos) {
    return FutureBuilder(
      future: DBProvider_mysql.db.getEvent(argumentos['id']),
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
          var resultado = (snapshot.data)[0];
          return Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          'https://via.placeholder.com/150',
                          height: 200.0,
                          width: 150.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'ID: ',
                              style: TextStyle(
                                  fontSize: 30.0,
                                  height: 1.0,
                                  color: Colors.black),
                            ),
                            Text(
                              resultado["id"] == null
                                  ? ''
                                  : '${resultado["id"]}',
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
                              'Numero de Abonos: ',
                              style: TextStyle(
                                  fontSize: 30.0,
                                  // height: 2.0,
                                  color: Colors.black),
                            ),
                            Text(
                              resultado["numero_abonos"] == null
                                  ? ''
                                  : '${resultado["numero_abonos"]}',
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
                              'adiantamento: ',
                              style: TextStyle(
                                  fontSize: 30.0,
                                  // height: 2.0,
                                  color: Colors.black),
                            ),
                            Text(
                              resultado["adiantamento"] == null
                                  ? ''
                                  : '${resultado["adiantamento"]}',
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
                              'data_inicio: ',
                              style: TextStyle(
                                  fontSize: 30.0,
                                  // height: 2.0,
                                  color: Colors.black),
                            ),
                            Text(
                              resultado["data_inicio"] == null
                                  ? ''
                                  : '${resultado["data_inicio"]}',
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
                              'data_fim: ',
                              style: TextStyle(
                                  fontSize: 30.0,
                                  // height: 2.0,
                                  color: Colors.black),
                            ),
                            Text(
                              resultado["data_fim"] == null
                                  ? ''
                                  : '${resultado["data_fim"]}',
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
                              'status: ',
                              style: TextStyle(
                                  fontSize: 30.0,
                                  // height: 2.0,
                                  color: Colors.black),
                            ),
                            Text(
                              resultado["status"] == null
                                  ? ''
                                  : '${resultado["status"]}',
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
                              'tipo: ',
                              style: TextStyle(
                                  fontSize: 30.0,
                                  // height: 2.0,
                                  color: Colors.black),
                            ),
                            Text(
                              resultado["tipo"] == null
                                  ? ''
                                  : '${resultado["tipo"]}',
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
    final Map argumentos = ModalRoute.of(context)!.settings.arguments! as Map;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Evento'),
      ),
      body: getEvent(argumentos),
    );
  }
}
