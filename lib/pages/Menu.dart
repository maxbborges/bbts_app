import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bbts_flutter/providers/db_provider_mysql.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  _sessao() async{
    await DBProvider_mysql.db.sessao('sair');
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Menu'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween ,
            children: [
              ElevatedButton(
                child: Text(
                  'Listar Empregados',
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/ListEmployees", arguments: {});
                },
              ),
              ElevatedButton(
                child: Text(
                  'Listar Eventos',
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/ListEvents", arguments: {});
                },
              ),
              ElevatedButton(
                child: Text(
                  'Calendários',
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/Calendars", arguments: {});
                },
              ),
              ElevatedButton(
                child: Text(
                  'Editar Funcionário (Pessoal)',
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/InsertEmployerPessoal",
                      arguments: {});
                },
              ),
              ElevatedButton(
                child: Text(
                  'Editar Funcionário (Corporativo)',
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/InsertEmployerCorporativo",
                      arguments: {});
                },
              ),
              ElevatedButton(
                child: Text(
                  'Cadastrar Evento',
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/InsertEvents", arguments: {});
                },
              ),
              ElevatedButton(
                child: Text(
                  'Logout',
                ),
                onPressed: () {
                  _sessao();
                  Navigator.pushReplacementNamed(context, "/Login",
                      arguments: {});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
