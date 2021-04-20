class Funcionario {
  final int matricula;

  Funcionario({required this.matricula});

  factory Funcionario.fromJson(Map<String, dynamic> json) {
    return Funcionario(
      matricula: json['matricula'],
    );
  }

  Map<String, dynamic> toJson() => {
        "matricula": matricula,
      };
}

class FuncionarioPessoal {
  final String nome;
  final String cpf;
  final String rg;

  FuncionarioPessoal({required this.nome, required this.cpf, required this.rg});

  factory FuncionarioPessoal.fromJson(Map<String, dynamic> json) {
    return FuncionarioPessoal(
      nome: json['nome'],
      cpf: json['cpf'],
      rg: json['rg'],
    );
  }

  // factory FuncionarioPessoal.toList(List<dynamic> json){
  //   List<FuncionarioPessoal> list = List<FuncionarioPessoal>.from(json.map((i) => FuncionarioPessoal.fromJson(i)));
  //   // List<Example> list = List<Example>.json.map((i) => FuncionarioPessoal.fromJson(i)).toList();
  //   // return json.map((i) => FuncionarioPessoal.fromJson(i)).toList();
  //   return list;
  // }

  Map<String, dynamic> toJson() => {
        "nome": nome,
        "cpf": cpf,
        "rg": rg,
      };
}

abstract class Serializable {
  Map<String, dynamic> toJson();
}

class FuncionarioCorporativo {
  final String matricula;
  final String chave_c;
  final String cartao_bb;
  final String cartao_capital;
  final String cartao_bbts;
  final String num_contrato;

  FuncionarioCorporativo({
    required this.matricula,
    required this.chave_c,
    required this.cartao_bb,
    required this.cartao_capital,
    required this.cartao_bbts,
    required this.num_contrato,
  });

  factory FuncionarioCorporativo.fromJson(Map<String, dynamic> json) {
    return FuncionarioCorporativo(
      matricula: json['matricula'],
      chave_c: json['chave_c'],
      cartao_bb: json['cartao_bb'],
      cartao_capital: json['cartao_capital'],
      cartao_bbts: json['cartao_bbts'],
      num_contrato: json['num_contrato'],
    );
  }

  // factory FuncionarioCorporativo.toJson(List<dynamic> json){
  //   return FuncionarioCorporativo(
  //
  //   );
  // }

  @override
  Map<String, dynamic> toJson() => {
        "matricula": this.matricula,
        "chave_c": this.chave_c,
        "cartao_bb": this.cartao_bb,
        "cartao_capital": this.cartao_capital,
        "cartao_bbts": this.cartao_bbts,
        "num_contrato": this.num_contrato,
      };
}

class Funcionarios {
  final String matricula;
  final String nome;

  Funcionarios({required this.matricula, required this.nome});

  factory Funcionarios.fromJson(Map<String, dynamic> json) {
    return Funcionarios(
      matricula: json['matricula'],
      nome: json['nome'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        "matricula": this.matricula,
        "nome": this.nome,
      };
}
