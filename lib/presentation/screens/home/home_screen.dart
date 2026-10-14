import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_dimens.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/repositories/mock_magnet_repository.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/bottom_nav_bar_pill.dart';
import '../../widgets/magnet_header.dart';
import '../../widgets/offline_banner.dart';
import '../../widgets/profile_card.dart';
import '../../widgets/shop_section.dart';
import '../../widgets/social_feed_card.dart';
import '../../widgets/visitor_analytics_card.dart';
import '../../widgets/web_templates_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedNav = 2;
  final MockMagnetRepository _repository = const MockMagnetRepository();

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final analyticsData = _repository.getVisitorAnalytics();
    final socialPostData = _repository.getSocialPost();
    final shopItemData = _repository.getShopItem();
    final webTemplatesData = _repository.getWebTemplates();

    return Theme(
      data: AppTheme.light,
      child: Scaffold(
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 720;
              final horizontalPadding = isWide ? 32.0 : AppDimens.paddingMedium;

              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: AppDimens.maxContentWidth,
                  ),
                  child: Stack(
                    children: [
                      CustomScrollView(
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        slivers: [
                          // App Header
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                horizontalPadding,
                                10,
                                horizontalPadding,
                                0,
                              ),
                              child: MagnetHeader(
                                onLogoutTap: () =>
                                    authController.showLogoutDialog(context),
                              ),
                            ),
                          ),

                          SliverPadding(
                            padding: EdgeInsets.fromLTRB(
                              horizontalPadding,
                              14,
                              horizontalPadding,
                              100,
                            ),
                            sliver: SliverToBoxAdapter(
                              child: Obx(() {
                                final isOffline = !authController.isOnline.value;
                                final profile = _repository.getProfile(
                                  name: authController.userName.value,
                                  email: authController.userEmail.value,
                                  phone: authController.userPhone.value,
                                  photoUrl: authController.userPhoto.value,
                                );

                                if (isWide) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      OfflineBanner(isOffline: isOffline),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: Column(
                                              children: [
                                                ProfileCard(
                                                  profile: profile,
                                                  isOffline: isOffline,
                                                ),
                                                const SizedBox(height: 16),
                                                VisitorAnalyticsCard(
                                                  analytics: analyticsData,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          Expanded(
                                            flex: 6,
                                            child: Column(
                                              children: [
                                                SocialFeedCard(
                                                  post: socialPostData,
                                                ),
                                                const SizedBox(height: 20),
                                                ShopSection(
                                                  item: shopItemData,
                                                ),
                                                const SizedBox(height: 20),
                                                WebTemplatesSection(
                                                  templates: webTemplatesData,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                }

                                return Column(
                                  children: [
                                    OfflineBanner(isOffline: isOffline),
                                    ProfileCard(
                                      profile: profile,
                                      isOffline: isOffline,
                                    ),
                                    const SizedBox(height: 16),
                                    VisitorAnalyticsCard(
                                      analytics: analyticsData,
                                    ),
                                    const SizedBox(height: 18),
                                    SocialFeedCard(
                                      post: socialPostData,
                                    ),
                                    const SizedBox(height: 20),
                                    ShopSection(
                                      item: shopItemData,
                                    ),
                                    const SizedBox(height: 20),
                                    WebTemplatesSection(
                                      templates: webTemplatesData,
                                    ),
                                  ],
                                );
                              }),
                            ),
                          ),
                        ],
                      ),

                      Positioned(
                        left: horizontalPadding,
                        right: horizontalPadding,
                        bottom: 12,
                        child: BottomNavigationBarPill(
                          selectedIndex: _selectedNav,
                          onSelected: (index) {
                            setState(() => _selectedNav = index);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
