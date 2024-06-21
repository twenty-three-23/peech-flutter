
class Paragraph {
  int? id;
  String? paragraph;

  Paragraph({required this.id, required this.paragraph});

  factory Paragraph.fromJson(Map<String, dynamic> json) {
    return Paragraph(id: json["id"], paragraph: json["paragraph"]);
  }
}