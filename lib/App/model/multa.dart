class Multa {
  String placa;
  DateTime horaDaMulta;

  Multa({this.placa, this.horaDaMulta});

  factory Multa.fromJson(Map<String, dynamic> json) {
    return Multa();
  }

  @override
  String toString() {
    return 'placa: $placa, hora da multa: ${horaDaMulta.toString()}';
  }
}
