class Comment {
  final String text;
  final String author;
  final String avatar;
  final DateTime timestamp;
  final bool isHost;

  Comment({
    required this.text,
    required this.author,
    this.avatar = '',
    required this.timestamp,
    this.isHost = false,
  });
}
