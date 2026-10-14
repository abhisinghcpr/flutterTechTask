import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../data/models/profile_model.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.profile,
    required this.isOffline,
  });

  final ProfileModel profile;
  final bool isOffline;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          // Banner
          Container(
            height: 100,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              gradient: LinearGradient(
                colors: [
                  AppColors.mint,
                  AppColors.softPink,
                  AppColors.lavender,
                ],
              ),
            ),
            alignment: Alignment.topRight,
            padding: const EdgeInsets.all(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isOffline ? Icons.cloud_off_rounded : Icons.person_outline,
                    size: 13,
                    color: isOffline ? AppColors.offline : AppColors.ink,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    isOffline ? AppStrings.offlineBadge : AppStrings.personalBadge,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isOffline ? AppColors.offline : AppColors.ink,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Profile Body
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 20),
            child: Transform.translate(
              offset: const Offset(0, -30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 26,
                      backgroundColor: const Color(0xFFE9F6F7),
                      backgroundImage: (!isOffline &&
                              profile.photoUrl != null &&
                              profile.photoUrl!.isNotEmpty)
                          ? NetworkImage(profile.photoUrl!)
                          : null,
                      child: (isOffline ||
                              profile.photoUrl == null ||
                              profile.photoUrl!.isEmpty)
                          ? const Icon(
                              Icons.person,
                              color: AppColors.purple,
                              size: 30,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // User Name
                  Text(
                    profile.name.isNotEmpty ? profile.name : 'User',
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      color: AppColors.ink,
                    ),
                  ),
                  const SizedBox(height: 3),

                  // User Email
                  Text(
                    profile.email.isNotEmpty ? profile.email : 'No email available',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.muted,
                    ),
                  ),

                  // If offline: show only name and email as required
                  if (isOffline) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.offlineBackground,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.storage_rounded, size: 14, color: AppColors.offline),
                          SizedBox(width: 6),
                          Text(
                            'Name and email loaded from local cache',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: AppColors.offline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    // Online extras: Job Title, Location, Stats
                    const SizedBox(height: 4),
                    Text(
                      profile.jobTitle,
                      style: const TextStyle(fontSize: 11, color: AppColors.ink),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      profile.location,
                      style: const TextStyle(fontSize: 11, color: AppColors.muted),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Divider(color: AppColors.border),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _MiniStat(
                            icon: Icons.visibility_outlined,
                            count: profile.viewsCount,
                            label: AppStrings.profileViews,
                            color: AppColors.cyan,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _MiniStat(
                            icon: Icons.bookmark_border_rounded,
                            count: profile.savedCount,
                            label: AppStrings.profileSaved,
                            color: AppColors.peach,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({
    required this.icon,
    required this.count,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String count;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Icon(icon, size: 17, color: color),
        ),
        const SizedBox(width: 7),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                count,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                  color: AppColors.ink,
                ),
              ),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 10, color: AppColors.muted),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
