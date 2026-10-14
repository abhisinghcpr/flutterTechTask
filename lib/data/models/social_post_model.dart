class SocialPostModel {
  const SocialPostModel({
    required this.authorName,
    required this.authorRole,
    required this.content,
    required this.tags,
    required this.imageUrl,
    required this.likesCount,
    required this.commentsCount,
    required this.sharesCount,
  });

  final String authorName;
  final String authorRole;
  final String content;
  final String tags;
  final String imageUrl;
  final String likesCount;
  final String commentsCount;
  final String sharesCount;
}
