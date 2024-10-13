class Item {
  final int id;
  final String title;
  final String body;

  Item({required this.id, required this.title, required this.body});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
