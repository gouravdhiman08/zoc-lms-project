class Comment {
  final String id;
  final String user;
  final String content;
  final String timestamp;

  Comment({
    required this.id,
    required this.user,
    required this.content,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user': user,
      'content': content,
      'timestamp': timestamp,
    };
  }

  factory Comment.fromMap(String key, Map<dynamic, dynamic> map) {
    return Comment(
      id: key,
      user: map['user'] ?? '',
      content: map['content'] ?? '',
      timestamp: map['timestamp'] ?? '',
    );
  }
}
