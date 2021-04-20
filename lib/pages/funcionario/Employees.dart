import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bbts_flutter/providers/db_provider_mysql.dart';

class InsertEmployerPessoal extends StatefulWidget {
  @override
  _InsertEmployerPessoalState createState() => _InsertEmployerPessoalState();
}

class _InsertEmployerPessoalState extends State<InsertEmployerPessoal> {
  // NECESSARIO REFAZER COM UPDATE!
  final _matricula = TextEditingController();
  final _nome = TextEditingController();
  final _cpf = TextEditingController();
  final _rg = TextEditingController();
  _insert() async {
    var a = await DBProvider_mysql.db.putEmployerPessoal({
      "matricula": "${_matricula.text}",
      "cpf": "${_cpf.text}",
      "rg": "${_rg.text}"
    });
    print(a);
    if (a) {
    } else {}
  }

  employer() {
    return Center(
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Matricula'),
            controller: _matricula,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'CPF'),
            controller: _cpf,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'RG'),
            controller: _rg,
          ),
          ElevatedButton(
            onPressed: _insert,
            child: Text('Editar'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Editar Funcionario'),
      ),
      body: employer(),
    );
  }
}

class InsertEmployerCorporativo extends StatefulWidget {
  @override
  _InsertEmployerCorporativoState createState() =>
      _InsertEmployerCorporativoState();
}

class _InsertEmployerCorporativoState extends State<InsertEmployerCorporativo> {
  final _matricula = TextEditingController();
  final _chaveC = TextEditingController();
  final _cartaoBB = TextEditingController();
  final _cartaoCapital = TextEditingController();
  final _cartaoBBTS = TextEditingController();
  final _nContrato = TextEditingController();
  final _dataContratacao = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    var today = DateTime.now();
    final DateTime picked = (await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2030)))!;
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  _insert() async {
    var a = await DBProvider_mysql.db.putEmployerCorporativo({
      "matricula": "${_matricula.text}",
      "chave_c": "${_chaveC.text}",
      "cartao_bb": "${_cartaoBB.text}",
      "cartao_capital": "${_cartaoCapital.text}",
      "cartao_bbts": "${_cartaoBBTS.text}",
      "num_contrato": "${_nContrato.text}",
      "data_contratacao": "${_selectedDate}"
    });
    print(a);
    if (a) {
    } else {}
  }

  employerCorporativo() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Matricula'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: _matricula,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Chave C'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: _chaveC,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Cartao BB'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: _cartaoBB,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Cartao Capital'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: _cartaoCapital,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Cartao BBTS'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: _cartaoBBTS,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Numero Contrato'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: _nContrato,
            ),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text("${_selectedDate.toLocal()}".split(' ')[0]),
            ),
            ElevatedButton(
              onPressed: _insert,
              child: Text('Editar'),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Corporativo'),
      ),
      body: employerCorporativo(),
    );
  }
}

class InsertEmployer extends StatefulWidget {
  @override
  _InsertEmployerState createState() => _InsertEmployerState();
}

class _InsertEmployerState extends State<InsertEmployer> {
  final _matricula = TextEditingController();
  final _nome = TextEditingController();
  bool _loading = false;
  bool _matricula_validate = false;
  bool _nome_validate = false;

  _insert() async {
    var a = await DBProvider_mysql.db.postEmployer({
      "matricula": "${_matricula.text}",
      "nome": "${_nome.text}",
    });

    if (a is List) {
      final snackBar = SnackBar(content: Text('Usuário já cadastrado!'));
      setState(() {
        _loading = false;
      });

      return ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      setState(() {
        _loading = false;
      });

      if (!a) {
        final snackBar = SnackBar(content: Text('Erro ao inserir!'));
        return ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      final snackBar = SnackBar(
        content: Text('Cadastrado com sucesso!'),
        duration: Duration(seconds: 5),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context);
    }
  }

  inserirFuncionario() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Matricula',
              errorText: _matricula_validate ? 'Value Can\'t Be Empty' : null,
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            controller: _matricula,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Nome',
              errorText: _nome_validate ? 'Value Can\'t Be Empty' : null,
            ),
            controller: _nome,
          ),
          _loading
              ? Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Inserindo funcionario...',
                        style: const TextStyle(fontSize: 20),
                      ),
                      LinearProgressIndicator(
                        semanticsLabel: 'Linear progress indicator',
                      ),
                    ],
                  ),
                )
              : ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _matricula.text.isEmpty
                          ? _matricula_validate = true
                          : _matricula_validate = false;

                      _nome.text.isEmpty
                          ? _nome_validate = true
                          : _nome_validate = false;

                      if (!_matricula_validate && !_nome_validate) {
                        _loading = true;
                        _insert();
                      }
                    });
                  },
                  child: Text('Inserir'),
                ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Criar Funcionario'),
      ),
      body: inserirFuncionario(),
    );
  }
}
