class Security {
  int safe;
  int weak;
  int risk;
  List<String> securityTitles;
  double securedPercentage;
  List<double> strengths;

  Security(
      {required this.safe,
      required this.weak,
      required this.risk,
      required this.securityTitles,
      required this.securedPercentage,
      required this.strengths});
}
