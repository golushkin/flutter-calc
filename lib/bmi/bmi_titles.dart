class BmiTitles {
  final double result;

  BmiTitles(this.result);

  String get_title() {
    if (result < 16) {
      return "Выраженный дефицит массы тела";
    } else if (result >= 16 && result < 18.5) {
      return "Недостаточная (дефицит) масса тела";
    } else if (result >= 18.5 && result < 25) {
      return "Нормаnull";
    } else if (result >= 25 && result < 30) {
      return "Избыточная масса тела (предожирение)";
    } else if (result >= 30 && result < 35) {
      return "Ожирение первой степени";
    } else if (result >= 35 && result < 40) {
      return "Ожирение второй степени";
    } else {
      return "Ожирение третьей степени (морбидное)";
    }
  }
}
