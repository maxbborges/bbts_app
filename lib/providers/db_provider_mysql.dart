import 'package:bbts_flutter/models/funcionario.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final String ip = "http://192.168.0.128/bbts_api";
// final String ip = "https://mbbdev.com/bbts_api";

class DBProvider_mysql {
  DBProvider_mysql._();
  static final DBProvider_mysql db = DBProvider_mysql._();
  Dio _dio = Dio();

  Future getData() async {
    Response response =
        await _dio.get("${ip}/funcionarios/?matricula=112243&tipo=pessoal");
    var a = FuncionarioPessoal.fromJson(response.data);
    return a;
  }

  Future<List<dynamic>> getEmployees() async {
    Response res = await _dio.get("${ip}/funcionarios/");
    return res.data;
  }

  Future<List<dynamic>> getEvents() async {
    Response res = await _dio.get("${ip}/eventos/");
    return res.data;
  }

  Future<dynamic> getEmployer(matricula) async {
    var corporativo = {};
    var pessoal = {};
    var resultado = {};
    Response res;

    res = await _dio
        .get("${ip}/funcionarios/?matricula=${matricula}&tipo=corporativo");
    if (res.data is! bool) {
      corporativo = (FuncionarioCorporativo.fromJson(res.data)).toJson();
    }

    res = await _dio
        .get("${ip}/funcionarios/?matricula=${matricula}&tipo=pessoal");
    if (res.data is! bool) {
      pessoal = (FuncionarioPessoal.fromJson(res.data)).toJson();
    }

    resultado.addAll(pessoal);
    resultado.addAll(corporativo);

    return resultado;
  }

  Future<List<dynamic>> getEvent(id) async {
    Response res = await _dio.get("${ip}/eventos/?tipo=id&id=${id}");
    return res.data;
  }

  Future<List<dynamic>> getEventByDay(dia) async {
    // IMPLEMENTAR PARA CALENDARIO
    Response res = await _dio.get("${ip}/eventos/?tipo=data&data=${dia}");
    return res.data;
  }

  postEmployer(dados) async {
    Response res =
        await _dio.post('${ip}/funcionarios/?tipo=funcionario', data: dados);

    if (!res.data) {
      Response res1 = await _dio.get(
          '${ip}/funcionarios/?matricula=${dados["matricula"]}&tipo=funcionario');
      return (res1.data);
    }

    return res.data;
  }

  putEmployerCorporativo(dados) async {
    Response res = await _dio.put('${ip}/funcionarios/?tipo=dados_corporativos',
        data: dados);

    return res.data;
  }

  putEmployerPessoal(dados) async {
    Response res =
        await _dio.put('${ip}/funcionarios/?tipo=dados_pessoais', data: dados);

    return res.data;
  }

  postEvent(dados) async {
    Response res =
        await _dio.post('${ip}/eventos/?tipo=ferias_abonos', data: dados);

    return res.data;
  }

  logar(dados) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Response res = await _dio.post(
      '${ip}/seguranca/',
      data: dados,
    );
    if (res.data!=false){
      preferences.setBool('conectado', true);
    }
    return res.data;
  }

  sessao(tipo) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (tipo=='verificar'){
      if(preferences.get('conectado')==null){
        return false;
      }
      return preferences.get('conectado');
    } else {
      preferences.setBool('conectado', false);
    }

  }

  trocaSenha(dados) async {
    Response res = await _dio.post('${ip}/seguranca/?trocaSenha', data: dados);
    // print(res.data);

    return res.data;
  }
}
