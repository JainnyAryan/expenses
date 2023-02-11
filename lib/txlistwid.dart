// Transaction Widget

// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, must_be_immutable, sized_box_for_whitespace, prefer_const_constructors, duplicate_ignore, unnecessary_string_escapes

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './transaction.dart';

class TxListWid extends StatelessWidget {
  final List<Transaction> transaction;
  Function DeleteTX;
  TxListWid(this.transaction, this.DeleteTX);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.68,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                radius: 25,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      FittedBox(child: Text(transaction[index].amt.toString()))
                ),
              ),
              title: Text(
                transaction[index].title,
                style: Theme.of(context).textTheme.headline6,
              ),
              subtitle: Text(DateFormat("dd-MM-yyyy").format(transaction[index].date)),
              trailing: IconButton(icon: Icon(Icons.delete), onPressed: () => DeleteTX(transaction[index].id),),
            ),
          );
        },
        itemCount: transaction.length,
      ),
    );
  }
}
