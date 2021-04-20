import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bbts_flutter/providers/db_provider.dart';
import 'package:bbts_flutter/providers/db_provider_mysql.dart';
import 'package:bbts_flutter/providers/api_provider.dart';

class ListEmployees extends StatefulWidget {
  // const ListEmployees({required Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ListEmployees();
  }
}

class _ListEmployees extends State<ListEmployees> {
  // @override
  // void initState() {
  //   super.initState();
  // }

  List<dynamic> resultado = [];
  bool reload = false;
  final _search = TextEditingController();

  getListEmployees() {
    return FutureBuilder(
        future: DBProvider_mysql.db.getEmployees(),
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
            if (!reload) {
              for (var data in snapshot.data) {
                resultado.add(data);
              }
            }

            return Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16,0,16,0),
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Buscar por nome ou matrícula'),
                            controller: _search,
                            onChanged: (String value) => setState(() {
                              List<dynamic> temp = [];
                              resultado = snapshot.data;
                              var text = (value).toUpperCase();
                              for (var k in resultado) {
                                if ((k['nome'].toUpperCase()).contains(text)) {
                                  temp.add(k);
                                }
                                if (k['matricula'].contains(text)){
                                  temp.add(k);
                                }
                              }
                              resultado = temp;
                              reload = true;
                            }),
                          ),
                        ),

                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(16,0,16,0),
                        child: ElevatedButton.icon(
                          onPressed: () => setState(() {
                            List<dynamic> temp = [];
                            resultado = snapshot.data;
                            var text = (_search.text).toUpperCase();
                            for (var k in resultado) {
                              if ((k['nome'].toUpperCase()).contains(text)) {
                                temp.add(k);
                              }
                              if (k['matricula'].contains(text)){
                                temp.add(k);
                              }
                            }
                            resultado = temp;
                            reload = true;
                          }),
                          label: Text('Buscar'),
                          icon: Icon(Icons.search),
                        ),
                      ),

                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: resultado.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  title: Text(
                                    "${resultado[index]['nome'].toUpperCase()}",
                                    textAlign: TextAlign.center,
                                  ),
                                  leading: CircleAvatar(
                                    radius: 20.0,
                                    backgroundImage:
                                        // NetworkImage('https://via.placeholder.com/150'),
                                        AssetImage('assets/images/avatar.png'),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  onTap: () {
                                    setState(
                                      () {
                                        Navigator.pushNamed(
                                            context, "/Employer",
                                            arguments: {
                                              'matricula': resultado[index]
                                                  ['matricula'],
                                              'nome': resultado[index]['nome']
                                                  .toUpperCase()
                                            });
                                      },
                                    );
                                  },
                                  subtitle: Wrap(children: <Widget>[
                                    Center(
                                        child: Column(
                                      children: <Widget>[
                                        Text(
                                            'Matricula: ${resultado[index]["matricula"]}'),
                                      ],
                                    )),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Funcionarios'),
      ),
      body: getListEmployees(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          resultado = [];
          reload = true;
        }),
        child: Icon(Icons.search),
      ),
    );
  }
}
