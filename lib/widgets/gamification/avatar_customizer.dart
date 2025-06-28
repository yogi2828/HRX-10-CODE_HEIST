// lib/widgets/gamification/avatar_customizer.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/avatar_asset.dart';

class AvatarCustomizer extends StatelessWidget {
  final String? selectedAvatarPath;
  final ValueChanged<AvatarAsset> onAvatarSelected;

  const AvatarCustomizer({
    super.key,
    this.selectedAvatarPath,
    required this.onAvatarSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Choose Your Avatar',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textColor,
          ),
        ),
        const SizedBox(height: AppConstants.spacing * 2),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(AppConstants.padding),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppConstants.padding,
              mainAxisSpacing: AppConstants.padding,
              childAspectRatio: 1.0,
            ),
            itemCount: AppConstants.defaultAvatarAssets.length,
            itemBuilder: (context, index) {
              final avatar = AppConstants.defaultAvatarAssets[index];
              final bool isSelected = avatar.assetPath == selectedAvatarPath;
              return GestureDetector(
                onTap: () => onAvatarSelected(avatar),
                child: AnimatedContainer(
                  duration: AppConstants.defaultAnimationDuration,
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: AppColors.cardColor.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                    border: Border.all(
                      color: isSelected ? AppColors.accentColor : AppColors.borderColor,
                      width: isSelected ? 3 : 1,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppColors.accentColor.withOpacity(0.4),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ]
                        : [],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        avatar.assetPath,
                        width: AppConstants.avatarSize * 1.5,
                        height: AppConstants.avatarSize * 1.5,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: AppConstants.spacing),
                      Text(
                        avatar.name,
                        style: TextStyle(
                          color: isSelected ? AppColors.accentColor : AppColors.textColor,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}