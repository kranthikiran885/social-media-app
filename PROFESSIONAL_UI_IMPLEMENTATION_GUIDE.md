# Professional Instagram-Style UI Implementation Guide

## Quick Start for All Screens

This guide provides code patterns and principles for applying Instagram-style professional design to every screen in the app.

---

## Import Statements (Add to Every Screen)

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/widgets/app_components.dart';
```

---

## Screen Structure Template

Every screen should follow this professional structure:

```dart
class ProfessionalScreen extends StatefulWidget {
  const ProfessionalScreen({super.key});

  @override
  State<ProfessionalScreen> createState() => _ProfessionalScreenState();
}

class _ProfessionalScreenState extends State<ProfessionalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: InstagramAppBar(
        title: 'Screen Title',
        showBackButton: true,
        showBorder: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Content goes here with proper spacing
                const SizedBox(height: 12),
                // Section 1
                const SizedBox(height: 24),
                // Section 2
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

---

## Home Feed Screen - Implementation Checklist

### Stories Section
```dart
Widget _buildStoriesSection() {
  return SizedBox(
    height: 100,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      itemCount: stories.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: _buildStoryItem(stories[index]),
        );
      },
    ),
  );
}

Widget _buildStoryItem(Story story) {
  return Container(
    width: 70,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: AppColors.border, width: 0.5),
      boxShadow: AppShadows.depthLevel1,
      image: DecorationImage(
        image: NetworkImage(story.image),
        fit: BoxFit.cover,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: story.hasNewStory ? AppColors.primary : Colors.white,
              width: 2,
            ),
            boxShadow: AppShadows.small,
          ),
          child: ProfilePicture(
            imageUrl: story.userImage,
            size: 36,
            showBorder: false,
          ),
        ),
        const SizedBox(height: 8),
      ],
    ),
  );
}
```

### Key Points for Home Feed
- Stories section: 100pt height, horizontal scroll
- Story items: 70pt width, 16pt border radius
- Posts: Use enhanced_post_card component
- Spacing between sections: 16-24pt
- Pull-to-refresh: Enabled with primary color
- Loading state: Shimmer loaders for cards

---

## Search Page - Professional Pattern

```dart
class ProfessionalSearchPage extends StatefulWidget {
  const ProfessionalSearchPage({super.key});

  @override
  State<ProfessionalSearchPage> createState() => _ProfessionalSearchPageState();
}

class _ProfessionalSearchPageState extends State<ProfessionalSearchPage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: AppTextField(
                hintText: 'Search users, tags, places',
                prefixIcon: Icons.search,
                suffixIcon: _searchQuery.isNotEmpty ? Icons.close : null,
                onChanged: (value) => setState(() => _searchQuery = value),
              ),
            ),
            AppDivider(),
            // Results or suggestions
            Expanded(
              child: _searchQuery.isEmpty
                  ? _buildSearchSuggestions()
                  : _buildSearchResults(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchSuggestions() {
    return ListView.separated(
      itemCount: 10,
      separatorBuilder: (_, __) => AppDivider(),
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.history, color: AppColors.textTertiary),
          title: Text('Recent search term', style: AppTextStyles.bodyMedium),
          trailing: IconButton(
            icon: const Icon(Icons.close, size: 18),
            color: AppColors.textTertiary,
            onPressed: () {},
          ),
        );
      },
    );
  }

  Widget _buildSearchResults() {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: 30,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border, width: 0.5),
            boxShadow: AppShadows.depthLevel1,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network('', fit: BoxFit.cover),
              ),
            ),
          ),
        );
      },
    );
  }
}
```

---

## Profile Page - Professional Layout

```dart
class ProfessionalProfilePage extends StatefulWidget {
  final String userId;
  const ProfessionalProfilePage({super.key, required this.userId});

  @override
  State<ProfessionalProfilePage> createState() => _ProfessionalProfilePageState();
}

class _ProfessionalProfilePageState extends State<ProfessionalProfilePage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: InstagramAppBar(
        title: 'Username',
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Profile header
            Padding(
              padding: const EdgeInsets.all(16),
              child: _buildProfileHeader(),
            ),
            AppDivider(),
            // Action buttons
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: 'Follow',
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                      label: 'Message',
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.backgroundSecondary,
                        foregroundColor: AppColors.textPrimary,
                        side: const BorderSide(color: AppColors.border),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AppDivider(),
            // Tabs
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(icon: Icon(Icons.grid_3x3), text: 'Posts'),
                Tab(icon: Icon(Icons.bookmark), text: 'Saved'),
                Tab(icon: Icon(Icons.tag), text: 'Tagged'),
              ],
            ),
            // Tab content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildPostsGrid(),
                  _buildSavedGrid(),
                  _buildTaggedGrid(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        ProfilePicture(imageUrl: 'user_image_url', size: 80),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('1.2K', style: AppTextStyles.headlineSmall),
                  Text('532', style: AppTextStyles.headlineSmall),
                  Text('89', style: AppTextStyles.headlineSmall),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Posts', style: AppTextStyles.bodySmall),
                  Text('Followers', style: AppTextStyles.bodySmall),
                  Text('Following', style: AppTextStyles.bodySmall),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPostsGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border, width: 0.5),
            boxShadow: AppShadows.depthLevel1,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network('', fit: BoxFit.cover),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSavedGrid() => _buildPostsGrid();
  Widget _buildTaggedGrid() => _buildPostsGrid();
}
```

---

## Post Details Page - Comment Threading

```dart
class ProfessionalPostDetailsPage extends StatefulWidget {
  final String postId;
  const ProfessionalPostDetailsPage({super.key, required this.postId});

  @override
  State<ProfessionalPostDetailsPage> createState() =>
      _ProfessionalPostDetailsPageState();
}

class _ProfessionalPostDetailsPageState
    extends State<ProfessionalPostDetailsPage> {
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: InstagramAppBar(
        title: 'Post',
        showBackButton: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Post card
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: AppCard(
                        padding: EdgeInsets.zero,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Post header, media, actions
                          ],
                        ),
                      ),
                    ),
                    AppDivider(),
                    // Comments section
                    _buildCommentsSection(),
                  ],
                ),
              ),
            ),
            // Comment input
            _buildCommentInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentsSection() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      separatorBuilder: (_, __) => AppDivider(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfilePicture(imageUrl: '', size: 32),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: AppTextStyles.bodyMedium,
                        children: [
                          TextSpan(
                            text: 'username',
                            style: AppTextStyles.titleSmall,
                          ),
                          const TextSpan(text: ' Great post!'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('2h ago', style: AppTextStyles.bodySmall),
                  ],
                ),
              ),
              Icon(Icons.favorite_border, size: 16, color: AppColors.textTertiary),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCommentInput() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border, width: 0.5)),
      ),
      child: Row(
        children: [
          ProfilePicture(imageUrl: '', size: 32),
          const SizedBox(width: 12),
          Expanded(
            child: AppTextField(
              controller: _commentController,
              hintText: 'Add a comment...',
              maxLines: null,
              minLines: 1,
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => _commentController.clear(),
            child: Icon(
              Icons.send,
              color: AppColors.primary,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
```

---

## Live Streaming Screen - Professional Design

Use this structure for live streaming UI:

```dart
Stack(
  children: [
    // Video area
    Container(
      color: Colors.black,
      child: Center(
        child: Icon(
          Icons.videocam,
          size: 80,
          color: Colors.grey[700],
        ),
      ),
    ),
    // Overlays
    Positioned(
      top: 12,
      left: 12,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.error,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Text('LIVE', style: AppTextStyles.labelLarge.copyWith(color: Colors.white)),
          ],
        ),
      ),
    ),
    // Bottom controls with proper spacing
  ],
)
```

---

## Shopping Interface - Grid Layout

```dart
Widget _buildProductGrid() {
  return GridView.builder(
    padding: const EdgeInsets.all(12),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 0.7,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
    ),
    itemCount: 20,
    itemBuilder: (context, index) {
      return AppCard(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.network('', fit: BoxFit.cover),
              ),
            ),
            // Product info
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Product Name', style: AppTextStyles.titleSmall),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text('4.8 (231)', style: AppTextStyles.bodySmall),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('\$99.99', style: AppTextStyles.titleMedium),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
```

---

## Content Creation Page - Clean Interface

```dart
class ProfessionalContentCreationPage extends StatefulWidget {
  const ProfessionalContentCreationPage({super.key});

  @override
  State<ProfessionalContentCreationPage> createState() =>
      _ProfessionalContentCreationPageState();
}

class _ProfessionalContentCreationPageState
    extends State<ProfessionalContentCreationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: InstagramAppBar(
        title: 'Create',
        showBackButton: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Caption input
                Text('Caption', style: AppTextStyles.titleMedium),
                const SizedBox(height: 8),
                AppTextField(
                  hintText: 'Write a caption...',
                  maxLines: 5,
                  minLines: 3,
                ),
                const SizedBox(height: 24),
                // Tags
                Text('Tags', style: AppTextStyles.titleMedium),
                const SizedBox(height: 8),
                AppTextField(
                  hintText: '#tag1 #tag2 #tag3',
                  prefixIcon: Icons.tag,
                ),
                const SizedBox(height: 24),
                // Permissions
                Text('Permissions', style: AppTextStyles.titleMedium),
                const SizedBox(height: 12),
                _buildPermissionOption('Like and Comments', true),
                _buildPermissionOption('Allow Sharing', true),
                _buildPermissionOption('Show on Profile', true),
                const SizedBox(height: 32),
                // Post button
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    label: 'Post',
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPermissionOption(String title, bool enabled) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: AppTextStyles.bodyMedium),
      trailing: Switch(
        value: enabled,
        onChanged: (value) {},
        activeColor: AppColors.primary,
      ),
    );
  }
}
```

---

## Common Patterns Summary

### Proper Padding Hierarchy
```
Screen Padding:   16pt horizontal, 12pt vertical
Card Padding:     16pt all sides
List Item:        12pt vertical, 16pt horizontal
Section Gap:      24pt between major sections
```

### Color Usage
- Text: Use AppColors.textPrimary, textSecondary, textTertiary
- Actions: Use AppColors.primary for CTAs, secondary for accents
- States: Use AppColors.error, success, warning, info
- Backgrounds: Use AppColors.background, backgroundSecondary

### Typography Consistency
- Page title: AppTextStyles.headlineSmall
- Section headers: AppTextStyles.titleLarge
- Body text: AppTextStyles.bodyMedium
- Secondary text: AppTextStyles.bodySmall
- Labels: AppTextStyles.labelMedium

### Shadow Application
- Cards: AppShadows.depthLevel1
- Buttons hover: AppShadows.medium
- Modals: AppShadows.large
- FABs: AppShadows.extraLarge

---

## Final Checklist for Every Screen

- [ ] Imports all professional design imports
- [ ] Uses InstagramAppBar or custom professional bar
- [ ] AppColors for all colors (no hardcoded colors)
- [ ] AppTextStyles for all text
- [ ] Proper spacing on 8pt/4pt grid
- [ ] Uses AppCard, AppButton, AppTextField components
- [ ] Shadows from AppShadows
- [ ] No clutter, clean hierarchy
- [ ] Responsive for phone and tablet
- [ ] Touch targets 44pt minimum
- [ ] Haptic feedback on interactions
- [ ] Smooth animations (200-300ms)
- [ ] Empty states handled
- [ ] Loading states shown
- [ ] Error states displayed

---

Apply these patterns consistently across all 12 screens for a professional, polished Instagram-like user experience.
