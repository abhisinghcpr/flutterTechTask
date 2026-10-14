import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';

class MagnetHeader extends StatelessWidget {
  const MagnetHeader({
    super.key,
    required this.onLogoutTap,
  });

  final VoidCallback onLogoutTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.hub_rounded, color: AppColors.primary, size: 28),
        const SizedBox(width: 6),
        const Text(
          AppStrings.brandTitle,
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w900,
            color: AppColors.ink,
          ),
        ),
        const Spacer(),
        _circleIconButton(
          icon: Icons.receipt_long_outlined,
          tooltip: 'Invoices',
          onTap: () {},
        ),
        const SizedBox(width: 10),
        Stack(
          clipBehavior: Clip.none,
          children: [
            _circleIconButton(
              icon: Icons.notifications_none_rounded,
              tooltip: 'Notifications',
              onTap: () {},
            ),
            Positioned(
              right: -3,
              top: -4,
              child: Container(
                width: 19,
                height: 19,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Text(
                  '4',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 10),
        _circleIconButton(
          icon: Icons.logout_rounded,
          tooltip: AppStrings.logout,
          onTap: onLogoutTap,
          iconColor: AppColors.primary,
        ),
      ],
    );
  }

  Widget _circleIconButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onTap,
    Color iconColor = AppColors.ink,
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(9),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Color(0x0A4B2A10),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, size: 19, color: iconColor),
        ),
      ),
    );
  }
}
