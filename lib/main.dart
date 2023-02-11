// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, must_be_immutable, non_constant_identifier_names, deprecated_member_use

// import 'package/MainTxWid.dart';
import './chart.dart';
import 'package:flutter/material.dart';
import './newtx.dart';
import './transaction.dart';
import './txlistwid.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: MyHomePage(),
    ),
  );
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool showChart = false;
  List<Transaction> transaction = [
    Transaction(id: 't11', title: 'Khana', amt: 150, date: DateTime.now()),
    Transaction(id: 't124', title: 'Khazana', amt: 300, date: DateTime.now()),
  ];

  List<Transaction> get _recentTransactions {
    return transaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void AddTx(String name, double txamt, DateTime date) {
    Transaction addedTx = Transaction(
      id: DateTime.now().toString(),
      title: name,
      amt: txamt,
      date: date,
    );

    setState(() {
      transaction.add(addedTx);
    });
  }

  void DeleteTx(String id) {
    setState(() {
      transaction.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    void AddTxWid(BuildContext cx) {
      showModalBottomSheet(
          context: cx,
          builder: (_) {
            return NewTx(AddTx);
          });
    }

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amberAccent,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
              fontFamily: 'RobotoMono',
              fontStyle: FontStyle.italic,
              fontSize: 20),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
          title: Text(
            'Fulter Expenses',
            // style: TextStyle(fontFamily: 'RobotoMono'),
          ),
        ),
        body: transaction.isEmpty
            ? Container(
                width: double.infinity,
                height: 200,
                child: Column(
                  children: [
                    Text(
                      "Meri bandhi nikli andhi!",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Container(
                      child: Image.asset(
                        'assets/img/va.png',
                        fit: BoxFit.cover,
                      ),
                      height: 150,
                    )
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    if (isLandscape)
                      Row(
                        children: [
                          Text("Show Chart"),
                          Switch(
                              value: showChart,
                              onChanged: (val) {
                                setState(() {
                                  showChart = val;
                                });
                              }),
                        ],
                      ),
                    if(!isLandscape) ...[Chart(_recentTransactions), TxListWid(transaction, DeleteTx)],  
                    if(isLandscape) (showChart
                        ? Chart(_recentTransactions)
                        : TxListWid(transaction, DeleteTx))
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              onPressed: () => AddTxWid(context),
              child: Icon(Icons.add),
            );
          },
        ),
      ),
    );
  }
}
