import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class BottomNavigationBarPill extends StatelessWidget {
  const BottomNavigationBarPill({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    const icons = [
      Icons.fingerprint_rounded,
      Icons.rss_feed_rounded,
      Icons.hub_rounded,
      Icons.person_outline_rounded,
      Icons.more_horiz_rounded,
    ];

    return Material(
      elevation: 8,
      color: Colors.white,
      borderRadius: BorderRadius.circular(40),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(icons.length, (index) {
            final selected = selectedIndex == index;

            return InkWell(
              onTap: () => onSelected(index),
              borderRadius: BorderRadius.circular(30),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: selected ? AppColors.primaryLight : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icons[index],
                  color: selected ? AppColors.primary : AppColors.ink,
                  size: selected ? 24 : 21,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
