// ignore_for_file: file_names
class Advertisement {
  String id;
  String title;
  String photo;
  String tags;
  int price;
  String author;
  String description;

  Advertisement(
      {required this.id,
      required this.title,
      required this.description,
      required this.photo,
      required this.tags,
      required this.price,
      required this.author});
}
