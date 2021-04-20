import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bbts_flutter/providers/db_provider_mysql.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bbts_flutter/pages/Menu.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _matricula = TextEditingController();
  final _senha = TextEditingController();
  final _senhaOld = TextEditingController();
  final _senhaNew = TextEditingController();

  bool _matricula_validate = false;
  bool _senha_validate = false;

  bool _senhaOld_validate = false;
  bool _senhaNew_validate = false;

  bool _esqueceu = true;

  bool _obscureText = true;
  bool _obscureOld = true;
  bool _obscureNew = true;

  bool isLoading = false;
  _criar() async {
    Navigator.pushNamed(context, "/InsertEmployer", arguments: {});
  }

  _resetar() async {
    var a = await DBProvider_mysql.db.trocaSenha({
      "matricula": "${_matricula.text}",
      "senhaNew": "${_senhaNew.text}",
      "senhaOld": "${_senhaOld.text}"
    });

    if (a == false) {
      final snackBar = SnackBar(content: Text('Erro ao trocar senha!'));
      return ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    setState(() {
      _esqueceu = true;
    });

    final snackBar = SnackBar(content: Text('Senha alterada com sucesso!'));
    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _btnLogin() {
    return ElevatedButton(
      onPressed: () {
        setState(
          () {
            _matricula.text.isEmpty
                ? _matricula_validate = true
                : _matricula_validate = false;
            _senha.text.isEmpty
                ? _senha_validate = true
                : _senha_validate = false;

            if (!_senha_validate && !_matricula_validate) {
              isLoading = true;
              _logar();
            }
          },
        );
      },
      child: Text('Login'),
    );
  }

  _loading() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Realizando verificação dos dados!',
              style: const TextStyle(fontSize: 20),
            ),
            LinearProgressIndicator(
              // value: controller.value,
              semanticsLabel: 'Linear progress indicator',
            ),
          ],
        ),
      ),
    );
  }

  _logar() async {
    var a = await DBProvider_mysql.db.logar({
      "matricula": "${_matricula.text}",
      "senha": "${_senha.text}",
    });

    if (a == false) {
      setState(() {
        isLoading = false;
      });
      final snackBar = SnackBar(content: Text('Erro ao realizar login!'));
      return ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print (a[2]['valor']);
    preferences.setString('Nome', a[2]['valor']);
    preferences.setString('Regras', a[1]['valor']);
    preferences.setString('Matricula', a[0]['valor']);

    Navigator.pushReplacementNamed(context, "/Menu", arguments: {});
  }

  esqueceu() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Senha Antiga',
                  errorText:
                      _senhaOld_validate ? 'Value Can\'t Be Empty' : null,
                ),
                controller: _senhaOld,
                obscureText: _obscureOld,
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _obscureOld = !_obscureOld;
                });
              },
              child: Text(_obscureOld ? "Show" : "Hide"),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nova Senha',
                  errorText:
                      _senhaNew_validate ? 'Value Can\'t Be Empty' : null,
                ),
                controller: _senhaNew,
                obscureText: _obscureNew,
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _obscureNew = !_obscureNew;
                });
              },
              child: Text(_obscureNew ? "Show" : "Hide"),
            ),
          ],
        )
      ],
    );
  }

  _sessao() async{
    var a = await DBProvider_mysql.db.sessao('verificar');
    if (a){
      Navigator.pushReplacementNamed(context, "/Menu", arguments: {});
    }
  }

  login() {
    _sessao();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      'https://media-exp1.licdn.com/dms/image/C4D0BAQEqz_sE-AndlQ/company-logo_200_200/0/1543505877023?e=1623888000&v=beta&t=cYRgdLSUsIFyRpqlfBjjFS1UFTlaAoK3h22YEl3SBMY',
                      height: 200.0,
                      width: 150.0,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Matricula',
                      errorText:
                          _matricula_validate ? 'Value Can\'t Be Empty' : null,
                    ),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    textInputAction: TextInputAction.next,
                    controller: _matricula,
                  ),
                  _esqueceu
                      ? Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  icon: const Padding(
                                    padding: const EdgeInsets.only(top: 9.0),
                                    child: const Icon(Icons.lock),
                                  ),
                                  errorText: _senha_validate
                                      ? 'Value Can\'t Be Empty'
                                      : null,
                                ),
                                controller: _senha,
                                obscureText: _obscureText,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Text(_obscureText ? "Show" : "Hide"),
                            )
                          ],
                        )
                      : esqueceu(),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _esqueceu = false;
                    });
                  },
                  child: Text('Esqueceu?'),
                ),
                TextButton(
                  onPressed: _criar,
                  child: Text('Criar Novo'),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _esqueceu
                    ? isLoading
                        ? _loading()
                        : _btnLogin()
                    : Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(
                                () {
                                  _esqueceu = true;
                                },
                              );
                            },
                            child: Text('Voltar'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(
                                () {
                                  _matricula.text.isEmpty
                                      ? _matricula_validate = true
                                      : _matricula_validate = false;
                                  _senhaNew.text.isEmpty
                                      ? _senhaNew_validate = true
                                      : _senhaNew_validate = false;
                                  _senhaOld.text.isEmpty
                                      ? _senhaOld_validate = true
                                      : _senhaOld_validate = false;

                                  if (!_senhaNew_validate &&
                                      !_senhaOld_validate &&
                                      !_matricula_validate) {
                                    _resetar();
                                  }
                                },
                              );
                            },
                            child: Text('Resetar'),
                          ),
                        ],
                      )
              ],
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
        title: new Text('Acesso Restrito'),
      ),
      body: login(),
    );
  }
}
