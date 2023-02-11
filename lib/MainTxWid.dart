/* // ignore_for_file: use_key_in_widget_constructors, file_names, non_constant_identifier_names, unused_local_variable

import 'package:flutter/material.dart';
import './txlistwid.dart';
import './newtx.dart';
import './transaction.dart';

class MainTxWid extends StatefulWidget {
  @override
  State<MainTxWid> createState() => MainTxWidState();
}

class MainTxWidState extends State<MainTxWid> {
  List<Transaction> transaction = [
    Transaction(id: 't11', title: 'Khana', amt: 150, date: DateTime.now()),
    Transaction(id: 't124', title: 'Khazana', amt: 300, date: DateTime.now()),
  ];

  void AddTx(String name, double txamt) {
    Transaction addedTx = Transaction(
      id: DateTime.now().toString(),
      title: name,
      amt: txamt,
      date: DateTime.now(),
    );

    setState(() {
      transaction.add(addedTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTx(AddTx),
        TxListWid(transaction),
      ],
    );
  }
}
 */