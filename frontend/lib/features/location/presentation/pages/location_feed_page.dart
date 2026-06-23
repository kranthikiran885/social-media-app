import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../feed/presentation/bloc/feed_bloc.dart';
import '../../../search/data/models/search_models.dart';

class LocationFeedPage extends StatefulWidget {
  final SearchLocation location;

  const LocationFeedPage({
    super.key,
    required this.location,
  });

  @override
  State<LocationFeedPage> createState() => _LocationFeedPageState();
}

class _LocationFeedPageState extends State<LocationFeedPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _setupScrollListener();
    context.read<FeedBloc>().add(LoadFeed());
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.9) {
        context.read<FeedBloc>().add(LoadMorePosts());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: _buildLocationHeader(),
          ),
          SliverToBoxAdapter(
            child: _buildLocationInfo(),
          ),
          SliverToBoxAdapter(
            child: _buildActionButtons(),
          ),
          _buildPostsSection(),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      pinned: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.location.name,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            widget.location.city,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(
            _isSaved ? Icons.bookmark : Icons.bookmark_outline,
            color: AppColors.primary,
          ),
          onPressed: () {
            setState(() {
              _isSaved = !_isSaved;
            });
          },
        ),
      ],
    );
  }

  Widget _buildLocationHeader() {
    return SizedBox(
      height: 200,
      child: Stack(
        fit: StackFit.expand,
        children: [
          widget.location.thumbnailUrl != null
              ? CachedNetworkImage(
                  imageUrl: widget.location.thumbnailUrl!,
                  fit: BoxFit.cover,
                )
              : Container(
                  color: AppColors.backgroundTertiary,
                  child: Icon(
                    Icons.location_on,
                    size: 64,
                    color: AppColors.primary,
                  ),
                ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.location.name,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.location.address,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationInfo() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.location_on, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                '${widget.location.city}, ${widget.location.country}',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.backgroundSecondary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildInfoColumn(
                  '${_formatCount(widget.location.postsCount)}',
                  'Posts',
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: AppColors.border,
                ),
                _buildInfoColumn(
                  '${_formatCount(widget.location.visitsCount)}',
                  'Visits',
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: AppColors.border,
                ),
                _buildInfoColumn(
                  '${_formatCount(widget.location.followersCount)}',
                  'Followers',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          if (widget.location.description != null)
            Text(
              widget.location.description!,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Location saved')),
                );
              },
              icon: const Icon(Icons.bookmark_outline),
              label: const Text('Save'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.backgroundSecondary,
                foregroundColor: AppColors.textPrimary,
                elevation: 0,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // Share location
              },
              icon: const Icon(Icons.share_outlined),
              label: const Text('Share'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostsSection() {
    return BlocBuilder<FeedBloc, FeedState>(
      builder: (context, state) {
        if (state is FeedLoading) {
          return SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              ),
            ),
          );
        }

        if (state is FeedLoaded || state is FeedLoadingMore) {
          final posts = state is FeedLoaded ? state.posts : (state as FeedLoadingMore).posts;

          if (posts.isEmpty) {
            return SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      Icon(
                        Icons.image_not_supported,
                        size: 64,
                        color: AppColors.textTertiary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No posts from this location yet',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index >= posts.length) {
                    return state is FeedLoadingMore
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : null;
                  }
                  final post = posts[index];
                  return _buildPostGridItem(post);
                },
                childCount:
                    state is FeedLoadingMore ? posts.length + 1 : posts.length,
              ),
            ),
          );
        }

        return SliverToBoxAdapter(
          child: Center(
            child: Text(
              'Error loading posts',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPostGridItem(dynamic post) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/post_details',
          arguments: post,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.backgroundTertiary,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: post.imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: post.imageUrl,
                      fit: BoxFit.cover,
                    )
                  : Icon(
                      Icons.image,
                      color: AppColors.textTertiary,
                    ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.3),
                  ],
                ),
              ),
            ),
            if (post.likesCount != null || post.commentsCount != null)
              Positioned(
                bottom: 8,
                left: 8,
                child: Row(
                  children: [
                    Icon(Icons.favorite, color: Colors.red, size: 14),
                    const SizedBox(width: 2),
                    Text(
                      _formatCount(post.likesCount ?? 0),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }
}
