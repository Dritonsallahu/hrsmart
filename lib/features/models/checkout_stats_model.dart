import 'package:business_menagament/core/consts/utils.dart';

class CheckoutData {
  final String? year;
  final double? sales;

  CheckoutData({this.year, this.sales});

  factory CheckoutData.fromJson(Map<String, dynamic> json) {
    return CheckoutData(year: getMonthName(json['_id']), sales: json['totalDifference'].toDouble());
  }
}
