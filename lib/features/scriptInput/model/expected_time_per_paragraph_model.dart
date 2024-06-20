
class ExpectedTimePerParagraph {
  int? paragraphId;
  String? time;

  ExpectedTimePerParagraph({required this.paragraphId, required this.time});

  factory ExpectedTimePerParagraph.fromJson(Map<String, dynamic> json) {
    return ExpectedTimePerParagraph(paragraphId: json["paragraphId"], time: json["time"]);
  }
}