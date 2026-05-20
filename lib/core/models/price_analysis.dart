import 'package:miruvor/core/models/price_observation.dart';

class PriceAnalysis {
  const PriceAnalysis({
    required this.purchasePrice,
    required this.observations,
  });

  final int purchasePrice;
  final List<PriceObservation> observations;

  bool get hasMarketData => observations.isNotEmpty;

  int? get minPrice {
    if (observations.isEmpty) {
      return null;
    }
    return observations.map((price) => price.price).reduce(_min);
  }

  int? get maxPrice {
    if (observations.isEmpty) {
      return null;
    }
    return observations.map((price) => price.price).reduce(_max);
  }

  int? get averagePrice {
    if (observations.isEmpty) {
      return null;
    }
    final total = observations.fold<int>(
      0,
      (sum, observation) => sum + observation.price,
    );
    return (total / observations.length).round();
  }

  double? get ratioToAverage {
    final average = averagePrice;
    if (average == null || average == 0) {
      return null;
    }
    return purchasePrice / average;
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
  unknown('시장가 없음'),
  good('싸게 삼'),
  fair('적정가'),
  expensive('비싸게 삼');

  const PriceJudgement(this.label);

  final String label;
}
