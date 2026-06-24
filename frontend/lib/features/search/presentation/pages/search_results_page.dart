import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/search_bloc.dart';
import '../../data/models/search_models.dart';

class SearchResultsPage extends StatefulWidget {
  final String query;
  final String? initialTab;

  const SearchResultsPage({
    super.key,
    required this.query,
    this.initialTab,
  });

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 0;
  String _selectedFilter = 'all';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _setupScrollListener();
    
    // Set initial tab based on parameter
    if (widget.initialTab != null) {
      _selectTab(widget.initialTab!);
    }

    // Load initial search results
    context.read<SearchBloc>().add(SearchQuery(widget.query));
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.9) {
        context.read<SearchBloc>().add(LoadMoreResults(widget.query, _currentPage + 1));
        _currentPage++;
      }
    });
  }

  void _selectTab(String tabName) {
    switch (tabName.toLowerCase()) {
      case 'accounts':
        _tabController.animateTo(1);
        context.read<SearchBloc>().add(SearchAccounts(widget.query));
        break;
      case 'hashtags':
        _tabController.animateTo(2);
        context.read<SearchBloc>().add(SearchHashtags(widget.query));
        break;
      case 'audio':
        _tabController.animateTo(3);
        context.read<SearchBloc>().add(SearchSounds(widget.query));
        break;
      case 'places':
        _tabController.animateTo(4);
        context.read<SearchBloc>().add(SearchLocations(widget.query));
        break;
      case 'posts':
        _tabController.animateTo(5);
        context.read<SearchBloc>().add(SearchPosts(widget.query));
        break;
      default:
        _tabController.animateTo(0);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildFilterBar(),
          Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return _buildLoadingState();
                }
                return _buildSearchTabs();
              },
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: AppColors.textPrimary,
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        'Search: ${widget.query}',
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: false,
    );
  }

  Widget _buildFilterBar() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.border,
            width: 0.5,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildFilterChip('all', 'All'),
            const SizedBox(width: 8),
            _buildFilterChip('latest', 'Latest'),
            const SizedBox(width: 8),
            _buildFilterChip('trending', 'Trending'),
            const SizedBox(width: 8),
            _buildFilterChip('popular', 'Popular'),
            const SizedBox(width: 8),
            _buildFilterChip('verified', 'Verified'),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String value, String label) {
    final isSelected = _selectedFilter == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      backgroundColor: Colors.transparent,
      side: BorderSide(
        color: isSelected ? AppColors.primary : AppColors.border,
        width: 1,
      ),
      labelStyle: TextStyle(
        color: isSelected ? AppColors.primary : AppColors.textSecondary,
        fontWeight: FontWeight.w600,
      ),
      onSelected: (selected) {
        setState(() {
          _selectedFilter = value;
        });
      },
    );
  }

  Widget _buildSearchTabs() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColors.border,
                width: 0.5,
              ),
            ),
          ),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorColor: AppColors.primary,
            indicatorWeight: 2,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            labelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            onTap: (index) {
              switch (index) {
                case 1:
                  context.read<SearchBloc>().add(SearchAccounts(widget.query));
                  break;
                case 2:
                  context.read<SearchBloc>().add(SearchHashtags(widget.query));
                  break;
                case 3:
                  context.read<SearchBloc>().add(SearchSounds(widget.query));
                  break;
                case 4:
                  context.read<SearchBloc>().add(SearchLocations(widget.query));
                  break;
                case 5:
                  context.read<SearchBloc>().add(SearchPosts(widget.query));
                  break;
              }
            },
            tabs: const [
              Tab(text: 'Top'),
              Tab(text: 'Accounts'),
              Tab(text: 'Tags'),
              Tab(text: 'Audio'),
              Tab(text: 'Places'),
              Tab(text: 'Posts'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildTopResultsTab(),
              _buildAccountsTab(),
              _buildHashtagsTab(),
              _buildAudioTab(),
              _buildLocationsTab(),
              _buildPostsTab(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTopResultsTab() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoaded) {
          if (state.topResults.isEmpty) {
            return _buildEmptyState('No results found');
          }
          return ListView.builder(
            controller: _scrollController,
            itemCount: state.topResults.length,
            itemBuilder: (context, index) {
              final result = state.topResults[index];
              return _buildResultItem(result);
            },
          );
        }
        return _buildLoadingState();
      },
    );
  }

  Widget _buildAccountsTab() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is AccountSearchLoaded) {
          if (state.accounts.isEmpty) {
            return _buildEmptyState('No accounts found');
          }
          return ListView.builder(
            controller: _scrollController,
            itemCount: state.accounts.length,
            itemBuilder: (context, index) {
              final account = state.accounts[index];
              return _buildAccountResultItem(account);
            },
          );
        }
        return _buildLoadingState();
      },
    );
  }

  Widget _buildHashtagsTab() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is HashtagSearchLoaded) {
          if (state.hashtags.isEmpty) {
            return _buildEmptyState('No hashtags found');
          }
          return ListView.builder(
            controller: _scrollController,
            itemCount: state.hashtags.length,
            itemBuilder: (context, index) {
              final hashtag = state.hashtags[index];
              return _buildHashtagResultItem(hashtag);
            },
          );
        }
        return _buildLoadingState();
      },
    );
  }

  Widget _buildAudioTab() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SoundSearchLoaded) {
          if (state.sounds.isEmpty) {
            return _buildEmptyState('No audio found');
          }
          return ListView.builder(
            controller: _scrollController,
            itemCount: state.sounds.length,
            itemBuilder: (context, index) {
              final sound = state.sounds[index];
              return _buildSoundResultItem(sound);
            },
          );
        }
        return _buildLoadingState();
      },
    );
  }

  Widget _buildLocationsTab() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is LocationSearchLoaded) {
          if (state.locations.isEmpty) {
            return _buildEmptyState('No locations found');
          }
          return ListView.builder(
            controller: _scrollController,
            itemCount: state.locations.length,
            itemBuilder: (context, index) {
              final location = state.locations[index];
              return _buildLocationResultItem(location);
            },
          );
        }
        return _buildLoadingState();
      },
    );
  }

  Widget _buildPostsTab() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is PostSearchLoaded) {
          if (state.posts.isEmpty) {
            return _buildEmptyState('No posts found');
          }
          return GridView.builder(
            controller: _scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemCount: state.posts.length,
            itemBuilder: (context, index) {
              final post = state.posts[index];
              return _buildPostGridItem(post);
            },
          );
        }
        return _buildLoadingState();
      },
    );
  }

  Widget _buildResultItem(SearchResult result) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(result.imageUrl),
        backgroundColor: AppColors.backgroundTertiary,
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              result.title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          if (result.isVerified)
            const Icon(Icons.verified, color: AppColors.info, size: 16),
        ],
      ),
      subtitle: Text(
        result.subtitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: AppColors.textSecondary),
      ),
      trailing: Text(
        '${(result.relevanceScore * 100).toStringAsFixed(0)}%',
        style: const TextStyle(
          color: AppColors.textTertiary,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildAccountResultItem(SearchAccount account) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(account.avatar),
        backgroundColor: AppColors.backgroundTertiary,
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              account.username,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          if (account.isVerified)
            const Icon(Icons.verified, color: AppColors.info, size: 16),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            account.fullName,
            style: const TextStyle(color: AppColors.textSecondary),
          ),
          Text(
            '${_formatCount(account.followersCount)} followers',
            style: const TextStyle(
              color: AppColors.textTertiary,
              fontSize: 12,
            ),
          ),
        ],
      ),
      trailing: ElevatedButton(
        onPressed: () {
          context.read<SearchBloc>().add(FollowUserFromSearch(
            userId: account.id,
            isCurrentlyFollowing: account.isFollowing,
          ));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: account.isFollowing
              ? AppColors.backgroundSecondary
              : AppColors.primary,
          foregroundColor:
              account.isFollowing ? AppColors.textPrimary : Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        child: Text(account.isFollowing ? 'Following' : 'Follow'),
      ),
    );
  }

  Widget _buildHashtagResultItem(SearchHashtag hashtag) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.backgroundTertiary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: hashtag.thumbnailUrl != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: hashtag.thumbnailUrl!,
                  fit: BoxFit.cover,
                ),
              )
            : Icon(
                Icons.tag,
                color: AppColors.primary,
                size: 24,
              ),
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              '#${hashtag.name}',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          if (hashtag.isTrending)
            Icon(Icons.trending_up, color: AppColors.warning, size: 16),
        ],
      ),
      subtitle: Text(
        '${_formatCount(hashtag.postsCount)} posts',
        style: const TextStyle(color: AppColors.textSecondary),
      ),
      onTap: () {
        // Navigate to hashtag feed page
        Navigator.of(context).pushNamed(
          '/hashtag_feed',
          arguments: hashtag,
        );
      },
    );
  }

  Widget _buildSoundResultItem(SearchSound sound) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: CachedNetworkImageProvider(sound.coverUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              sound.title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          if (sound.isTrending)
            Icon(Icons.trending_up, color: AppColors.warning, size: 16),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sound.artist,
            style: const TextStyle(color: AppColors.textSecondary),
          ),
          Text(
            '${_formatCount(sound.usageCount)} uses • ${sound.duration}s',
            style: const TextStyle(
              color: AppColors.textTertiary,
              fontSize: 12,
            ),
          ),
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.play_arrow, color: AppColors.primary),
        onPressed: () {
          // Play sound
        },
      ),
    );
  }

  Widget _buildLocationResultItem(SearchLocation location) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: location.thumbnailUrl != null
              ? DecorationImage(
                  image: CachedNetworkImageProvider(location.thumbnailUrl!),
                  fit: BoxFit.cover,
                )
              : null,
          color: AppColors.backgroundTertiary,
        ),
        child: location.thumbnailUrl == null
            ? Icon(Icons.location_on, color: AppColors.primary)
            : null,
      ),
      title: Text(
        location.name,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            location.address,
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
          ),
          Text(
            '${_formatCount(location.postsCount)} posts',
            style: const TextStyle(
              color: AppColors.textTertiary,
              fontSize: 12,
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context).pushNamed(
          '/location_feed',
          arguments: location,
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
        color: AppColors.backgroundTertiary,
        child: post.imageUrl != null
            ? CachedNetworkImage(
                imageUrl: post.imageUrl,
                fit: BoxFit.cover,
              )
            : const Center(
                child: Icon(Icons.image, color: AppColors.textTertiary),
              ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: AppColors.primary,
            strokeWidth: 3,
          ),
          const SizedBox(height: 16),
          Text(
            'Searching...',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
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

// BLoC Events for loading more results
class LoadMoreResults extends SearchEvent {
  final String query;
  final int page;

  LoadMoreResults(this.query, this.page);
}
