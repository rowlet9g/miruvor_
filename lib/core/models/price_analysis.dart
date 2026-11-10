import 'package:miruvor/core/models/price_observation.dart';

class PriceAnalysis {
  const PriceAnalysis({
    required this.purchasePrice,
    required this.observations,
  });

  final num? purchasePrice;
  final List<PriceObservation> observations;

  List<PriceObservation> get _eligible =>
      observations.where((p) => p.price > 0).toList();

  bool get hasMarketData => _eligible.isNotEmpty;

  int? get minPrice {
    if (_eligible.isEmpty) {
      return null;
    }
    return _eligible.map((price) => price.price).reduce(_min);
  }

  int? get maxPrice {
    if (_eligible.isEmpty) {
      return null;
    }
    return _eligible.map((price) => price.price).reduce(_max);
  }

  int? get averagePrice {
    if (_eligible.isEmpty) {
      return null;
    }
    final total = _eligible.fold<int>(
      0,
      (sum, observation) => sum + observation.price,
    );
    return (total / _eligible.length).round();
  }

  double? get ratioToAverage {
    final average = averagePrice;
    if (average == null || average == 0 || purchasePrice == null) {
      return null;
    }
    return purchasePrice! / average;
  }

  PriceJudgement get judgement {
    final ratio = ratioToAverage;
    if (ratio == null) {
      return PriceJudgement.unknown;
    }
    if (ratio <= 0.9) {
      return PriceJudgement.good;
    }
    if (ratio >= 1.1) {
      return PriceJudgement.expensive;
    }
    return PriceJudgement.fair;
  }

  static int _min(int a, int b) => a < b ? a : b;

  static int _max(int a, int b) => a > b ? a : b;
}

enum PriceJudgement {
  unknown('비교 자료 없음'),
  good('싸게 삼'),
  fair('적정가'),
  expensive('비싸게 삼');

  const PriceJudgement(this.label);

  final String label;
}
