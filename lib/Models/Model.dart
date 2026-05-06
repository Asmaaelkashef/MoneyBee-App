class ExchangeRateModel {
  final double rate;
  final String updatedAt;

  ExchangeRateModel({
    required this.rate,
    required this.updatedAt,
  });

  factory ExchangeRateModel.fromJson(Map<String, dynamic> json) {
    return ExchangeRateModel(
      rate: (json['rates']['EGP'] as num).toDouble(),
      updatedAt: json['time_last_update_utc']
          .toString()
          .substring(0, 16),
    );
  }
}