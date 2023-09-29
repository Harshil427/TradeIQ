// ignore_for_file: file_names

class StockData {
  final Map<String, dynamic> data;

  StockData(this.data);

  factory StockData.fromJson(Map<String, dynamic> json) {
    return StockData(json);
  }
}