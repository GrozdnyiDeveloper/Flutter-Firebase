class Book {
  final String id;
  final String title;
  final String author;
  final String description;

  Book({
    this.id = "",
    required this.title, 
    required this.author, 
    this.description = "",
  });
}