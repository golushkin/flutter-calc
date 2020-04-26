enum SingingCharacter { male, female }

const ACTIVITIES = [
  "минимум или отсутствие физической нагрузки",
  "занятия фитнесом 3 раза в неделю",
  "занятия фитнесом 5 раз в неделю",
  "интенсивная физическая нагрузка 5 раз в неделю",
  "занятия фитнесом каждый день",
  "каждый день интенсивно или по два раза в день",
  "ежедневная физическая нагрузка плюс физическая работа",
];

const VALUES = [1.2, 1.375, 1.4625, 1.550, 1.6375, 1.725, 1.9];

List<String> METHODS = List.from([
  "Формула Миффлина — Сан Жеора",
  "Формула Харриса-Бенедикта",
]);

const SEX = [
  "Мужчина",
  "Женщина",
];


class Calories{
  final SingingCharacter sex;
  final double height;
  final double weight;
  final String method;
  final String activity;
  final int age;

  Calories(this.sex, this.height, this.weight, this.method, this.activity, this.age);

  String _mifflinsFormula(){
    double result = 0;

    if (this.sex == SingingCharacter.male) {
      result = 10 * this.weight + 6.25 * this.height - 5 * this.age + 5;
    } 
    else {
      result = 10 * this.weight + 6.25 * this.height - 5 * this.age - 161;
    }

    result = result * VALUES[ACTIVITIES.indexOf(this.activity)];

    return result.toStringAsFixed(2);
  }

  String _harisonsFormula(){
    double result = 0;

    if (this.sex == SingingCharacter.male) {
      result = 66.5 + 13.75 * this.weight + 5.003 * this.height - 6.775 * this.age;
    } 
    else {
      result = 655.1 + 9.563 * this.weight + 1.85 * this.height - 4.676 * this.age;
    }

    return result.toStringAsFixed(2);
  }
  
  String calculate(){
    String output;

    if (this.method == METHODS[0]) {
      output = "Ваша суточная норма калорий: " + _mifflinsFormula();
    }
    else{
      output = "Ваша суточная норма калорий: " + _harisonsFormula();
    }

    return output;
  }
}