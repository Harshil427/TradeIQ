// ignore_for_file: use_key_in_widget_constructors, file_names, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tradeiq/Utils/Functions.dart';

import '../Screens/Pages/SignalDetailsPage.dart';

class StockList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('stock_entries').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          final List<DocumentSnapshot> documents = snapshot.data!.docs;

          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final stockEntry =
                  documents[index].data() as Map<String, dynamic>;

              return GestureDetector(
                onTap: () {
                  moveNextPage(
                    context,
                    SignalDetailsPage(
                      stockEntry: stockEntry,
                    ),
                  );
                },
                child: Card(
                  elevation: 4,
                  margin: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 16,
                          top: 16,
                          right: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${stockEntry['stockName']}',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              stockEntry['signal'] == 'SignalType.Buy'
                                  ? 'BUY'
                                  : 'SELL',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: stockEntry['signal'] == 'SignalType.Buy'
                                    ? Colors.blue
                                    : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10).copyWith(
                          top: 6,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              stockEntry['status'] == 'StatusType.Running'
                                  ? 'Running'
                                  : 'Closed',
                              style: TextStyle(
                                fontSize: 18,
                                color:
                                    stockEntry['status'] == 'StatusType.Running'
                                        ? Colors.green
                                        : Colors.red,
                              ),
                            ),
                            Text(
                              '${showTime(stockEntry['currentTime'])}',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String formatTimeOnly(DateTime timestamp) {
    final timeFormat = DateFormat.jm();
    return timeFormat.format(timestamp);
  }

  showTime(var data) {
    final timestamp = DateTime.parse(data);
    final formattedTime = formatTimeOnly(timestamp);
    return formattedTime;
  }
}
