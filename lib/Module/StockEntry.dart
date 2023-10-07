// ignore_for_file: file_names

class StockEntry {
  String stockName;
  String stockentryController;
  double takeProfit;
  double stopLoss;
  String imageUrl;
  String signal;
  String currentTime;
  String remark;
  String status;
  String documentId; // Add a field to store the Firestore document ID

  StockEntry(
    this.stockName,
    this.stockentryController,
    this.takeProfit,
    this.stopLoss,
    this.imageUrl,
    this.signal,
    this.currentTime,
    this.remark,
    this.status,
    this.documentId, // Include it in the constructor
  );

  // Define a factory constructor to create a StockEntry object from Firestore data
  factory StockEntry.fromJson(Map<String, dynamic> json) {
    return StockEntry(
      json['stockName'],
      json['stockentryController'],
      json['takeProfit'].toDouble(),
      json['stopLoss'].toDouble(),
      json['imageUrl'],
      json['signal'],
      json['currentTime'],
      json['remark'],
      json['status'],
      json['documentId'], // Initialize it from Firestore data
    );
  }

  // Define a toJson method to convert the object to a Map
  Map<String, dynamic> toJson() {
    return {
      'stockName': stockName,
      'stockentryController': stockentryController,
      'takeProfit': takeProfit,
      'stopLoss': stopLoss,
      'imageUrl': imageUrl,
      'signal': signal,
      'currentTime': currentTime,
      'remark': remark,
      'status': status,
      'documentId': documentId, // Include it in the JSON representation
    };
  }
}
