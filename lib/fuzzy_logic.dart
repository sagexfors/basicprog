Map<String, double> fuzzyRuleEvaluation(double score) {
  double low(double x) => (x >= 25 && x <= 50) ? (50 - x) / 25 : 0;
  double medium(double x) => (x >= 25 && x <= 75)
      ? 1
      : (x >= 75 && x <= 100)
          ? (x - 75) / 25
          : 0;
  double high(double x) => (x >= 75 && x <= 100) ? (x - 75) / 25 : 0;

  Map<String, double> fuzzyResult = {};
  fuzzyResult['Pass'] = medium(score) * high(score);
  fuzzyResult['Fail'] = low(score) * medium(score);
  return fuzzyResult;
}

double defuzzification(Map<String, double> fuzzyResult) {
  double numerator = 0;
  double denominator = 0;
  fuzzyResult.forEach((key, value) {
    if (key == 'Pass') {
      numerator += value * 100;
    } else {
      numerator += value * 0;
    }
    denominator += value;
  });
  double centroid = (denominator != 0) ? numerator / denominator : 0;
  return centroid;
}
