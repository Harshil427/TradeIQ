// ignore_for_file: file_names, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tradeiq/Constants/Colors.dart';
import 'package:tradeiq/Module/StockEntry.dart';
import 'package:tradeiq/Services/Auth_Services.dart';
import 'package:tradeiq/Services/DatabaseServices.dart';
import '../../Constants/Variable.dart';
import '../../Module/User.dart';
import '../../Utils/Functions.dart';
import '../Pages/SignalDetailsPage.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<StockEntry> stockEntries;
  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
    String uid = AuthServices().getUid();
    User? data = await DatabaseServices().fetchUserData(uid);
    setState(() {
      userData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final heigth = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text('TradeIQ'),
        // centerTitle: true,
      ),
      body: homeScreenBody(),
    );
  }

  homeScreenBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildTempBody(),

          SizedBox(
            height: MediaQuery.of(context).size.height *
                0.8, // Adjust the height as needed
            child: buildStockList(),
          ),
          // Expanded(
          //   child: buildStockList(),
          // )
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  buildTempBody() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(
        left: 20,
        top: 10,
      ),
      child: userData != null
          ? Text(
              '👋 Hi ! , ${userData!.name}',
              style: TextStyle(
                fontSize: 26,
              ),
            )
          : Text('Loading user data...'),
    );
  }
}

buildStockList() {
  // final CollectionReference stockEntries =
  //     FirebaseFirestore.instance.collection('stock_entries');

  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('stock_entries').snapshots(),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      }

      final List<DocumentSnapshot> documents = snapshot.data!.docs;

      // Data is ready, let's display it
      return ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: documents.length,
        itemBuilder: (context, index) {
          final stockEntry = documents[index].data() as Map<String, dynamic>;

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
                            color: stockEntry['status'] == 'StatusType.Running'
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
