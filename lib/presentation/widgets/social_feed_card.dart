import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../data/models/social_post_model.dart';

class SocialFeedCard extends StatelessWidget {
  const SocialFeedCard({
    super.key,
    required this.post,
  });

  final SocialPostModel post;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A4B2A10),
            blurRadius: 14,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.socialFeeds,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Color(0xFFE9F6F7),
                child: Icon(Icons.person, color: AppColors.purple),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.authorName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                        color: AppColors.ink,
                      ),
                    ),
                    Text(
                      post.authorRole,
                      style: const TextStyle(fontSize: 10, color: AppColors.muted),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.more_horiz, color: AppColors.muted),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            post.content,
            style: const TextStyle(fontSize: 12, height: 1.6, color: AppColors.ink),
          ),
          const SizedBox(height: 10),
          Text(
            post.tags,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              post.imageUrl,
              height: 190,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 190,
                color: const Color(0xFF6D9D9D),
                child: const Center(
                  child: Icon(Icons.landscape, color: Colors.white, size: 55),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.favorite_border, size: 17, color: AppColors.ink),
              const SizedBox(width: 4),
              Text(post.likesCount, style: const TextStyle(fontSize: 11)),
              const SizedBox(width: 13),
              const Icon(Icons.mode_comment_outlined, size: 17, color: AppColors.ink),
              const SizedBox(width: 4),
              Text(post.commentsCount, style: const TextStyle(fontSize: 11)),
              const SizedBox(width: 13),
              const Icon(Icons.share_outlined, size: 17, color: AppColors.ink),
              const SizedBox(width: 4),
              Text(post.sharesCount, style: const TextStyle(fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }
}
