// lib/widgets/gamification/avatar_customizer.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/avatar_asset.dart';

class AvatarCustomizer extends StatelessWidget {
  final String selectedAvatarPath;
  final Function(String) onAvatarSelected;
  final bool showSelector;

  const AvatarCustomizer({
    super.key,
    required this.selectedAvatarPath,
    required this.onAvatarSelected,
    this.showSelector = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: AppConstants.defaultAnimationDuration,
          padding: const EdgeInsets.all(AppConstants.spacing),
          decoration: BoxDecoration(
            color: AppColors.secondaryColor.withOpacity(0.5),
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.accentColor, width: 3),
            boxShadow: [
              BoxShadow(
                color: AppColors.accentColor.withOpacity(0.5),
                blurRadius: 15,
                spreadRadius: 5,
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              selectedAvatarPath,
              width: AppConstants.avatarSize * 1.5,
              height: AppConstants.avatarSize * 1.5,
              fit: BoxFit.cover,
            ),
          ),
        ),
        if (showSelector) ...[
          const SizedBox(height: AppConstants.padding),
          Text(
            'Choose Your Avatar',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.textColor),
          ),
          const SizedBox(height: AppConstants.spacing),
          SizedBox(
            height: AppConstants.avatarSize + AppConstants.padding * 2, // Adjusted height for selector
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: AppConstants.defaultAvatarAssets.length,
              itemBuilder: (context, index) {
                final avatar = AppConstants.defaultAvatarAssets[index];
                return GestureDetector(
                  onTap: () => onAvatarSelected(avatar.assetPath),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacing),
                    child: AnimatedContainer(
                      duration: AppConstants.defaultAnimationDuration,
                      padding: const EdgeInsets.all(AppConstants.spacing / 2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: selectedAvatarPath == avatar.assetPath ? AppColors.accentColor : AppColors.borderColor,
                          width: selectedAvatarPath == avatar.assetPath ? 3 : 1,
                        ),
                        boxShadow: [
                          if (selectedAvatarPath == avatar.assetPath)
                            BoxShadow(
                              color: AppColors.accentColor.withOpacity(0.3),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          avatar.assetPath,
                          width: AppConstants.avatarSize,
                          height: AppConstants.avatarSize,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}
