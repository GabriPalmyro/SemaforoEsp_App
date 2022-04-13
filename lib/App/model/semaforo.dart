class Semaforo {
  Semaforo({this.hasPedestrian = false, this.ldrValue = 0, this.luzes});

  double ldrValue;
  bool hasPedestrian;
  List<int> luzes = [0, 0, 0];

  factory Semaforo.fromJson(Map<String, dynamic> json) {
    return Semaforo();
  }

  @override
  String toString() {
    return 'ldrValue: $ldrValue, hasPedestrian: $hasPedestrian, luzes: ${luzes.toString()}';
  }
}
