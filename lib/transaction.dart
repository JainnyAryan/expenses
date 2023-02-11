class Transaction {
  String id;
  String title;
  double amt;
  DateTime date;

  Transaction(
      {required this.id,
      required this.title,
      required this.amt,
      required this.date});
}
