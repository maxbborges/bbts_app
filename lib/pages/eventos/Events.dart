import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:bbts_flutter/providers/db_provider_mysql.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InsertEvent extends StatefulWidget {
  @override
  _InsertEventState createState() => _InsertEventState();
}

class _InsertEventState extends State<InsertEvent> {
  @override
  void initState(){
    super.initState();
  }

  final _matricula = TextEditingController(text: 'aaa');
  bool _matricula_validate = false;
  final _nAbonos = TextEditingController();
  bool _nAbonos_validate = false;

  List<bool> _adiantamento = [false, true];
  List<bool> _tipo = [false, true];

  DateTime selectedDate_inicial = DateTime.now();
  DateTime selectedDate_final = (DateTime.now()).add(const Duration(days: 1));

  Future<void> _selectDate_inicial(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
        context: context,
        initialDate: selectedDate_inicial,
        firstDate: DateTime.now(),
        lastDate: DateTime(2030)))!;
    if (picked != null && picked != selectedDate_inicial)
      setState(() {
        selectedDate_inicial = picked;
      });
  }

  Future<void> _selectDate_final(BuildContext context) async {
    var today = DateTime.now();
    final DateTime picked = (await showDatePicker(
        context: context,
        initialDate: selectedDate_final,
        firstDate: today.add(const Duration(days: 1)),
        lastDate: DateTime(2030)))!;

    if (picked != null && picked != selectedDate_final)
      setState(() {
        selectedDate_final = picked;
      });
  }

  _insert() async {
    var __tipo = 'ferias';
    if (_tipo[0]) {
      __tipo = 'abono';
    }

    var a = await DBProvider_mysql.db.postEvent({
      "matricula": "${_matricula.text}",
      "numero_abonos": "${_nAbonos.text}",
      "adiantamento": _adiantamento[0],
      "data_inicio": "${selectedDate_inicial}",
      "data_fim": "${selectedDate_final}",
      "tipo": __tipo,
    });
    if (!a) {
      final snackBar = SnackBar(content: Text('Erro ao inserir!'));
      return ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    final snackBar = SnackBar(
      content: Text('Inserido com sucesso!'),
      duration: Duration(seconds: 5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.pop(context);
  }

  insertEvent(context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Matricula',
                  errorText:
                      _matricula_validate ? 'Value Can\'t Be Empty' : null,
                ),
                controller: _matricula,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Abonos',
                  errorText: _nAbonos_validate ? 'Value Can\'t Be Empty' : null,
                ),
                controller: _nAbonos,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, //Center Row contents horizontally,
                crossAxisAlignment:
                    CrossAxisAlignment.center, //Center Row contents vertically,

                children: [
                  Text('Inicio: '),
                  ElevatedButton(
                    onPressed: () => _selectDate_inicial(context),
                    child:
                        Text("${selectedDate_inicial.toLocal()}".split(' ')[0]),
                  ),
                  Text('Fim: '),
                  ElevatedButton(
                    onPressed: () => _selectDate_final(context),
                    child:
                        Text("${selectedDate_final.toLocal()}".split(' ')[0]),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, //Center Row contents horizontally,
                  crossAxisAlignment:
                      CrossAxisAlignment.center, //Center Row con
                  children: [
                    Text('13º: '),
                    ToggleButtons(
                      children: <Widget>[
                        Text('Sim'),
                        Text('Não'),
                      ],
                      onPressed: (int index) {
                        setState(
                          () {
                            for (int buttonIndex = 0;
                                buttonIndex < _adiantamento.length;
                                buttonIndex++) {
                              if (buttonIndex == index) {
                                _adiantamento[buttonIndex] = true;
                              } else {
                                _adiantamento[buttonIndex] = false;
                              }
                            }
                          },
                        );
                      },
                      isSelected: _adiantamento,
                    ),
                    Text('Tipo: '),
                    ToggleButtons(
                      children: <Widget>[
                        Text('Abono'),
                        Text('Ferias'),
                      ],
                      onPressed: (int index) {
                        setState(
                          () {
                            for (int buttonIndex = 0;
                                buttonIndex < _tipo.length;
                                buttonIndex++) {
                              if (buttonIndex == index) {
                                _tipo[buttonIndex] = true;
                              } else {
                                _tipo[buttonIndex] = false;
                              }
                            }
                          },
                        );
                      },
                      isSelected: _tipo,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(
                    () {
                      _matricula.text.isEmpty
                          ? _matricula_validate = true
                          : _matricula_validate = false;
                      _nAbonos.text.isEmpty
                          ? _nAbonos_validate = true
                          : _nAbonos_validate = false;

                      if (!_nAbonos_validate && !_matricula_validate) {
                        _insert();
                        // final snackBar = SnackBar(content: Text(_insert()));

                        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                  );
                },
                child: Text('Inserir'),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Evento'),
      ),
      body: insertEvent(context),
    );
  }
}
