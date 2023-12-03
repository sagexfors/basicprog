// Adjusted membership functions for better granularity and representation
double low(double x) => (x <= 30)
    ? 1
    : (x > 30 && x < 50)
        ? (50 - x) / 20
        : 0;
double medium(double x) => (x > 40 && x < 60)
    ? (x - 40) / 20
    : (x >= 60 && x <= 80)
        ? (80 - x) / 20
        : 0;
double high(double x) => (x >= 70) ? (x - 70) / 30 : 0;

// Modified fuzzy rule evaluation to account for more nuanced scenarios
Map<String, double> fuzzyRuleEvaluation(double score) {
  Map<String, double> fuzzyResult = {
    'HighPass': high(score),
    'LowPass': medium(score) * high(score),
    'Uncertain': medium(score),
    'LowFail': low(score) * medium(score),
    'HighFail': low(score),
  };
  return fuzzyResult;
}

// Enhanced defuzzification function for more accurate results
double defuzzification(Map<String, double> fuzzyResult) {
  double numerator = 0;
  double denominator = 0;
  Map<String, double> weights = {
    'HighPass': 100,
    'LowPass': 75,
    'Uncertain': 50,
    'LowFail': 25,
    'HighFail': 0,
  };

  fuzzyResult.forEach((key, value) {
    numerator += value * weights[key]!;
    denominator += value;
  });

  return (denominator != 0) ? numerator / denominator : 0;
}
