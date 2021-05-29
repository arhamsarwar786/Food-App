import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'constants.dart';

class HistoryRecord extends StatefulWidget {
  final dataKey;
  HistoryRecord(this.dataKey);
  @override
  _HistoryRecordState createState() => _HistoryRecordState();
}

class _HistoryRecordState extends State<HistoryRecord> {
  var hKeys, hValues;
  var data;
  @override
  void initState() {
    super.initState();
    hKeys = Hive.box("hKeys");
    hValues = Hive.box("hValues");
  }

  @override
  Widget build(BuildContext context) {
    data = hValues.get(widget.dataKey);
    print(data[5]);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "History Record",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: redTheme,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Name : \t\t\t\t\t\t\t\t\t\t\t\t",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Text("${data[0]}", style: TextStyle(fontSize: 17)),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Number  : \t\t\t\t\t\t",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Text("${data[2]}", style: TextStyle(fontSize: 17)),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Email  : \t\t\t\t\t\t\t\t\t\t\t\t",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                        child:
                            Text("${data[1]}", style: TextStyle(fontSize: 17))),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Address : \t\t\t\t\t\t\t\t",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                        child: Text("${data[3]}\n",
                            style: TextStyle(fontSize: 17))),
                  ],
                ),
                Table(
                  border: TableBorder.all(
                      color: Colors.grey[400],
                      style: BorderStyle.solid,
                      width: 1),
                  children: [
                    TableRow(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Items',
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Quantities',
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Unit Price',
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    for (int i = 0; i < data[5].length; i++)
                      TableRow(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${data[5][i]}',
                                    style: TextStyle(fontSize: 12.0)),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${data[7][i]}',
                                  style: TextStyle(fontSize: 14.0),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${data[6][i]}',
                                    style: TextStyle(fontSize: 14.0)),
                              ),
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Total : \t\t\t\t\t",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange),
                      ),
                      Text("${(data[8] == null) ? data[6][0] : data[8]}/-",
                          style: TextStyle(fontSize: 25, color: Colors.orange)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
