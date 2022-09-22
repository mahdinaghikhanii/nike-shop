class CommentEntity {
  final int id;
  final String title;
  final String content;
  final String data;
  final String email;

  CommentEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        content = json['content'],
        data = json['data'],
        email = json['author']['email'];
}
