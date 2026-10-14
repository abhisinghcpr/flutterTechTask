import 'package:flutter/material.dart';
import '../../core/constants/app_strings.dart';
import '../models/profile_model.dart';
import '../models/shop_item_model.dart';
import '../models/social_post_model.dart';
import '../models/visitor_analytics_model.dart';
import '../models/web_template_model.dart';

class MockMagnetRepository {
  const MockMagnetRepository();

  ProfileModel getProfile({
    String? name,
    String? email,
    String? photoUrl,
  }) {
    return ProfileModel(
      name: (name != null && name.trim().isNotEmpty) ? name : 'Rashmika Singh',
      email: (email != null && email.trim().isNotEmpty) ? email : 'rashmika@example.com',
      photoUrl: photoUrl,
      jobTitle: AppStrings.defaultJobTitle,
      location: AppStrings.defaultLocation,
      viewsCount: AppStrings.defaultViewsCount,
      savedCount: AppStrings.defaultSavedCount,
      isPersonal: true,
    );
  }

  VisitorAnalyticsModel getVisitorAnalytics() {
    return const VisitorAnalyticsModel(
      title: AppStrings.visitors,
      subtitle: AppStrings.totalView,
      totalViews: AppStrings.totalViewCount,
      growthText: AppStrings.analyticsGrowth,
    );
  }

  SocialPostModel getSocialPost() {
    return const SocialPostModel(
      authorName: AppStrings.authorName,
      authorRole: AppStrings.authorRole,
      content: AppStrings.postContent,
      tags: AppStrings.postTags,
      imageUrl: 'https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=900&q=85',
      likesCount: AppStrings.likesCount,
      commentsCount: AppStrings.commentsCount,
      sharesCount: AppStrings.sharesCount,
    );
  }

  ShopItemModel getShopItem() {
    return const ShopItemModel(
      title: AppStrings.shopItemTitle,
      subtitle: AppStrings.shopItemSubtitle,
      price: AppStrings.shopItemPrice,
      rating: AppStrings.shopItemRating,
      imageUrl: 'https://images.unsplash.com/photo-1607344645866-009c320b63e0?w=900&q=85',
    );
  }

  List<WebTemplateModel> getWebTemplates() {
    return const [
      WebTemplateModel(
        name: 'Marilyn Monroe',
        role: 'Influencer',
        tagline: AppStrings.templateTagline,
        color: Color(0xFFD6714B),
        imageUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=600&q=80',
      ),
      WebTemplateModel(
        name: 'John Doe',
        role: 'Architect',
        tagline: AppStrings.templateTagline,
        color: Color(0xFF333333),
        imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=600&q=80',
      ),
      WebTemplateModel(
        name: 'Sara Khan',
        role: 'Designer',
        tagline: AppStrings.templateTagline,
        color: Color(0xFF5B7F95),
        imageUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=600&q=80',
      ),
    ];
  }
}
