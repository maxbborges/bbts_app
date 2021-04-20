import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bbts_flutter/providers/db_provider.dart';
import 'package:bbts_flutter/providers/db_provider_mysql.dart';
import 'package:bbts_flutter/providers/api_provider.dart';

class ListEvents extends StatefulWidget {
  @override
  _ListEventsState createState() => _ListEventsState();
}

class _ListEventsState extends State<ListEvents> {
  List<dynamic> resultado = [];
  bool reload = false;
  final _search = TextEditingController();
  String typeDropdownValue = 'Todos';
  String statusDropdownValue = 'Todos';
  List<String> typePositions = ['Todos', 'Ferias', 'Abono', 'Outros'];
  List<String> statusPositions = ['Todos','Pendente', 'Aprovado'];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Eventos'),
      ),
      body: getListEvents(),
    );
  }

  checkEmpty(){
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
  }

  searchBox(snapshot){
    var _typeDropdownValue = typeDropdownValue.toUpperCase();
    var _statusDropdownValue = statusDropdownValue.toUpperCase();
    return Expanded(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: TextFormField(
          decoration: InputDecoration(
              labelText: 'Buscar por nome Funcionario'),
          controller: _search,
          onChanged: (String value) => setState(
                () {
              List<dynamic> temp = [];
              resultado = snapshot.data;
              var text = (value).toUpperCase();
              for (var k in resultado) {
                var name = k['nome'].toUpperCase();
                var type = k['tipo'].toUpperCase();
                var status = k['status'].toUpperCase();
                if (name.contains(text)) {
                  if (_typeDropdownValue != 'TODOS') {
                    if (type==_typeDropdownValue) {
                      temp.add(k);
                    }
                  } else {
                    temp.add(k);
                  }
                }
              }
              resultado = temp;
              reload = true;
            },
          ),
        ),
      ),
    );
  }

  searchButton(snapshot){
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: ElevatedButton.icon(
        onPressed: () => setState(() {
          List<dynamic> temp = [];
          resultado = snapshot.data;
          var text = (_search.text).toUpperCase();
          for (var k in resultado) {
            if ((k['nome'].toUpperCase()).contains(text)) {
              temp.add(k);
            }
            if (k['matricula'].contains(text)) {
              temp.add(k);
            }
          }
          resultado = temp;
          reload = true;
        }),
        label: Text('Buscar'),
        icon: Icon(Icons.search),
      ),
    );
  }

  typeDropdownButton(snapshot){
    return Padding(
      padding: EdgeInsets.all(16),
      child: DropdownButton<String>(
        value: typeDropdownValue,
        icon: Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? newValue) {
          setState(() {
            List<dynamic> temp = [];
            resultado = snapshot.data;

            if (newValue != 'Todos') {
              for (var k in resultado) {
                var tipo = k['tipo'].toUpperCase();
                var _dropdownValue = newValue!.toUpperCase();
                if (tipo.contains(_dropdownValue)) {
                  if (_search.text != '') {
                    var text = (_search.text).toUpperCase();
                    var nome = k['nome'].toUpperCase();
                    if (nome.contains(text)) {
                      temp.add(k);
                    }
                  } else {
                    temp.add(k);
                  }
                }
              }
              resultado = temp;
            }
            reload = true;
            typeDropdownValue = newValue!;
          });
        },
        items: typePositions
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  listView(){
    return Expanded(
      child: ListView.builder(
        itemCount: (resultado).length,
        itemBuilder: (context, index) {
          return Column(children: <Widget>[
            ListTile(
              title: Text(
                "${(resultado[index]['nome'])}",
                textAlign: TextAlign.center,
              ),
              onTap: () {
                setState(
                      () {
                    Navigator.pushNamed(context, "/Event",
                        arguments: {'id': resultado[index]['id']});
                  },
                );
              },
              subtitle: Wrap(children: <Widget>[
                Center(
                    child: Column(
                      children: <Widget>[
                        Text('${(resultado[index]['tipo'])}'),
                        Text('${(resultado[index]['status'])}'),
                        Text('${(resultado[index]['data_inicio'])}'),
                      ],
                    )),
              ]),
            ),
          ]);
        },
      ),
    );
  }

  statusDropdownButton(snapshot){
    return Padding(
      padding: EdgeInsets.all(16),
      child: DropdownButton<String>(
        value: statusDropdownValue,
        icon: Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? newValue) {
          setState(() {
            List<dynamic> temp = [];
            resultado = snapshot.data;

            if (newValue != 'Todos') {
              for (var k in resultado) {
                var status = k['status'].toUpperCase();
                var _dropdownValue = newValue!.toUpperCase();
                if (status==_dropdownValue) {
                  if (_search.text != '') {
                    var text = (_search.text).toUpperCase();
                    var nome = k['nome'].toUpperCase();
                    if (nome.contains(text)) {
                      temp.add(k);
                    }
                  } else {
                    temp.add(k);
                  }
                }
              }
              resultado = temp;
            }
            reload = true;
            statusDropdownValue = newValue!;
          });
        },
        items: statusPositions
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  mountListEvents(snapshot){
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              searchBox(snapshot),
              // searchButton(snapshot),
              typeDropdownButton(snapshot),
              statusDropdownButton(snapshot),
            ],
          ),
          listView(),
        ],
      ),
    );
  }

  getListEvents() {
    return FutureBuilder(
      future: DBProvider_mysql.db.getEvents(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return checkEmpty();
        } else {
          if (!reload) {
            for (var data in snapshot.data) {
              resultado.add(data);
            }
          }

          return mountListEvents(snapshot);
        }
      },
    );
  }
}
