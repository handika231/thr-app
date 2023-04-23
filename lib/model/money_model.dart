class MoneyModel {
  final String money;
  final int count;

  const MoneyModel({
    this.count = 0,
    required this.money,
  });
}

List<MoneyModel> moneyList = [
  const MoneyModel(
    count: 2,
    money: 'Rp. 20.000',
  ),
  const MoneyModel(
    count: 3,
    money: 'Rp. 30.000',
  ),
  const MoneyModel(
    count: 2,
    money: 'Rp. 20.000',
  ),
  const MoneyModel(
    count: 2,
    money: 'Rp. 20.000',
  ),
  const MoneyModel(
    count: 3,
    money: 'Rp. 30.000',
  ),
  const MoneyModel(
    count: 4,
    money: 'Rp. 40.000',
  ),
  const MoneyModel(
    count: 3,
    money: 'Rp. 30.000',
  ),
  const MoneyModel(
    count: 4,
    money: 'Rp. 40.000',
  ),
];
