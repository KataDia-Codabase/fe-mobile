import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/friend_provider.dart';
import '../../domain/entities/friend.dart';
import '../../../../shared/widgets/loading_widget.dart' as loading;
import '../widgets/friend_card.dart';

// Import search_bar with alias to avoid name conflict
import '../widgets/search_bar.dart' as social;

class FriendsListScreen extends ConsumerStatefulWidget {
  const FriendsListScreen({super.key});

  @override
  ConsumerState<FriendsListScreen> createState() => _FriendsListScreenState();
}

class _FriendsListScreenState extends ConsumerState<FriendsListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    // Load initial data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    await Future.wait([
      ref.read(friendProvider.notifier).loadFriends(),
      ref.read(friendProvider.notifier).loadFriendSuggestions(),
      ref.read(friendProvider.notifier).loadFriendRequests(),
    ]);
  }

  void _onSearchChanged(String query) {
    if (query.isEmpty) {
      ref.read(friendProvider.notifier).clearSearch();
    } else {
      ref.read(friendProvider.notifier).searchUsers(query: query);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(friendProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friends'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Requests'),
            Tab(text: 'Suggestions'),
            Tab(text: 'Search'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: _showFindFriendsDialog,
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAllFriendsTab(state),
          _buildRequestsTab(state),
          _buildSuggestionsTab(state),
          _buildSearchTab(state),
        ],
      ),
    );
  }

  Widget _buildAllFriendsTab(FriendState state) {
    if (state.isLoading && state.friends.isEmpty) {
      return const loading.FullScreenLoader(message: 'Loading friends...');
    }

    if (state.friends.isEmpty) {
      return _buildEmptyState(
        icon: Icons.people_outline,
        title: 'No friends yet',
        subtitle: 'Find and add friends to see them here',
        action: 'Find Friends',
        onAction: _showFindFriendsDialog,
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(friendProvider.notifier).refresh(),
      child: Column(
        children: [
          // Friends count
          Container(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Text(
                  '${state.friends.length} friends',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.sort),
                  onPressed: _showSortOptions,
                ),
              ],
            ),
          ),
          // Friends list
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: state.friends.length + (state.hasMoreData ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == state.friends.length && state.hasMoreData) {
                  // Load more indicator
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                  // Trigger next page load
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) => ref.read(friendProvider.notifier).loadFriends(),
                  );
                  return const SizedBox.shrink();
                }

                if (index >= state.friends.length) return const SizedBox.shrink();

                final friend = state.friends[index];
                return FriendCard(
                  friend: friend,
                  onAccept: friend.isPending
                      ? () => _acceptFriendRequest(friend.id)
                      : null,
                  onDecline: friend.isPending
                      ? () => _declineFriendRequest(friend.id)
                      : null,
                  onUnfriend: friend.isFriend
                      ? () => _unfriendUser(friend.id)
                      : null,
                  onBlock: () => _blockUser(friend.id),
                  onTap: () => _navigateToFriendProfile(friend),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestsTab(FriendState state) {
    final pendingRequests = state.friendRequests.where(
      (friend) => friend.isPending,
    );

    if (pendingRequests.isEmpty) {
      return _buildEmptyState(
        icon: Icons.inbox_outlined,
        title: 'No friend requests',
        subtitle: 'You have no pending friend requests',
        action: null,
        onAction: null,
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: pendingRequests.length,
      itemBuilder: (context, index) {
        final request = pendingRequests.elementAt(index);
        return FriendCard(
          friend: request,
          onAccept: () => _acceptFriendRequest(request.id),
          onDecline: () => _declineFriendRequest(request.id),
          onTap: () => _navigateToFriendProfile(request),
        );
      },
    );
  }

  Widget _buildSuggestionsTab(FriendState state) {
    if (state.friendSuggestions.isEmpty) {
      return _buildEmptyState(
        icon: Icons.person_search,
        title: 'No suggestions',
        subtitle: 'Friend suggestions will appear here',
        action: 'Refresh',
        onAction: () => ref.read(friendProvider.notifier).loadFriendSuggestions(),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: state.friendSuggestions.length,
      itemBuilder: (context, index) {
        final suggestion = state.friendSuggestions[index];
        return FriendCard(
          friend: suggestion,
          onAccept: () => _sendFriendRequest(suggestion.id),
          onTap: () => _navigateToFriendProfile(suggestion),
        );
      },
    );
  }

  Widget _buildSearchTab(FriendState state) {
    return Column(
      children: [
        // Search input
        social.SocialSearchBar(
          controller: _searchController,
          onChanged: _onSearchChanged,
          hintText: 'Search users...',
        ),
        // Search results
        Expanded(
          child: _buildSearchResults(state),
        ),
      ],
    );
  }

  Widget _buildSearchResults(FriendState state) {
    if (_searchController.text.isEmpty) {
      return _buildEmptyState(
        icon: Icons.search,
        title: 'Search for friends',
        subtitle: 'Enter a username to search',
        action: null,
        onAction: null,
      );
    }

    if (state.isLoading) {
      return const loading.FullScreenLoader(message: 'Searching...');
    }

    if (state.searchStatus == SearchStatus.empty) {
      return _buildEmptyState(
        icon: Icons.search_off,
        title: 'No results found',
        subtitle: 'Try a different search term',
        action: null,
        onAction: null,
      );
    }

    if (state.searchStatus == SearchStatus.error) {
      return _buildErrorState(
        icon: Icons.error_outline,
        title: 'Search failed',
        subtitle: state.errorMessage ?? 'An error occurred',
        action: 'Retry',
        onAction: () => _onSearchChanged(_searchController.text),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: state.searchResults.length,
      itemBuilder: (context, index) {
        final result = state.searchResults[index];
        return FriendCard(
          friend: result,
          onAccept: () => _sendFriendRequest(result.id),
          onTap: () => _navigateToFriendProfile(result),
        );
      },
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
    String? action,
    VoidCallback? onAction,
  }) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64.w,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
            ),
            SizedBox(height: 16.h),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
              textAlign: TextAlign.center,
            ),
            if (action != null && onAction != null) ...[
              SizedBox(height: 24.h),
              ElevatedButton(
                onPressed: onAction,
                child: Text(action),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState({
    required IconData icon,
    required String title,
    required String subtitle,
    required String action,
    required VoidCallback onAction,
  }) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64.w,
              color: Theme.of(context).colorScheme.error,
            ),
            SizedBox(height: 16.h),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: onAction,
              child: Text(action),
            ),
          ],
        ),
      ),
    );
  }

  void _showFindFriendsDialog() {
    // Implementation for finding friends dialog
  }

  void _showSortOptions() {
    // Implementation for sorting options
  }

  void _acceptFriendRequest(String userId) {
    ref.read(friendProvider.notifier).acceptFriendRequest(userId: userId);
    _showSuccessMessage('Friend request accepted');
  }

  void _declineFriendRequest(String userId) {
    ref.read(friendProvider.notifier).declineFriendRequest(userId: userId);
  }

  void _sendFriendRequest(String userId) {
    ref.read(friendProvider.notifier).sendFriendRequest(userId: userId);
    _showSuccessMessage('Friend request sent');
  }

  void _unfriendUser(String userId) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Unfriend?'),
        content: const Text('Are you sure you want to unfriend this person?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(friendProvider.notifier).unfriend(userId: userId);
            },
            child: const Text('Unfriend'),
          ),
        ],
      ),
    );
  }

  void _blockUser(String userId) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Block User'),
        content: const Text('Are you sure you want to block this person?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(friendProvider.notifier).blockUser(userId: userId);
            },
            child: const Text('Block'),
          ),
        ],
      ),
    );
  }

  void _navigateToFriendProfile(Friend friend) {
    // Navigation to friend profile
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
