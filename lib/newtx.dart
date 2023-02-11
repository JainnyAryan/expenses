// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTx extends StatefulWidget {
  final Function addFunc;
  NewTx(this.addFunc);

  @override
  State<NewTx> createState() => _NewTxState();
}

class _NewTxState extends State<NewTx> {
  final titleval = TextEditingController();
  final amtval = TextEditingController();
  final dateval = TextEditingController();

  late DateTime pickeddate;

  void showPresentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedData) {
      if (pickedData == null) {
        return;
      }
      setState(() {
        pickeddate = pickedData;
        dateval.text = DateFormat.yMd().format(pickedData);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    void submitData() {
      if (titleval.text.isEmpty || double.parse(amtval.text) <= 0 || pickeddate == null) {
        return;
      }
      widget.addFunc(titleval.text, double.parse(amtval.text), pickeddate);
      Navigator.of(context).pop();
    }

    return Card(
      child: Container(
        padding: EdgeInsets.only(top: 25, left: 25, right: 25, bottom: MediaQuery.of(context).viewInsets.bottom + 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleval,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amtval,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              controller: dateval,
              // enabled: false,
              decoration: InputDecoration(labelText: "Pick Date"),
              onTap: showPresentDatePicker,
              readOnly: true,
            ),
            ElevatedButton(
              style: ButtonStyle(elevation: MaterialStateProperty.all(10)),
              onPressed: submitData,
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
