import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/friend.dart';
import '../../domain/repositories/friend_repository.dart';
import '../../../../core/network/network_info.dart';

/// Friend state management
class FriendState {
  final List<Friend> friends;
  final List<Friend> friendSuggestions;
  final List<Friend> searchResults;
  final List<Friend> friendRequests;
  final FriendRequestStatus requestStatus;
  final SearchStatus searchStatus;
  final String? searchQuery;
  final bool isLoading;
  final String? errorMessage;
  final bool hasMoreData;
  final int currentPage;

  const FriendState({
    this.friends = const [],
    this.friendSuggestions = const [],
    this.searchResults = const [],
    this.friendRequests = const [],
    this.requestStatus = FriendRequestStatus.initial,
    this.searchStatus = SearchStatus.initial,
    this.searchQuery,
    this.isLoading = false,
    this.errorMessage,
    this.hasMoreData = true,
    this.currentPage = 0,
  });

  FriendState copyWith({
    List<Friend>? friends,
    List<Friend>? friendSuggestions,
    List<Friend>? searchResults,
    List<Friend>? friendRequests,
    FriendRequestStatus? requestStatus,
    SearchStatus? searchStatus,
    String? searchQuery,
    bool? isLoading,
    String? errorMessage,
    bool? hasMoreData,
    int? currentPage,
  }) {
    return FriendState(
      friends: friends ?? this.friends,
      friendSuggestions: friendSuggestions ?? this.friendSuggestions,
      searchResults: searchResults ?? this.searchResults,
      friendRequests: friendRequests ?? this.friendRequests,
      requestStatus: requestStatus ?? this.requestStatus,
      searchStatus: searchStatus ?? this.searchStatus,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

/// Friend request status enumeration
enum FriendRequestStatus {
  initial,
  loading,
  success,
  error,
}

enum SearchStatus {
  initial,
  loading,
  success,
  empty,
  error,
}

/// Friend provider
class FriendNotifier extends StateNotifier<FriendState> {
  final FriendRepository repository;
  final NetworkInfo networkInfo;

  FriendNotifier({
    required this.repository,
    required this.networkInfo,
  }) : super(const FriendState());

  /// Load all friends
  Future<void> loadFriends({
    FriendStatus? status,
    bool refresh = false,
    int limit = 20,
  }) async {
    if (state.isLoading && !refresh) return;

    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await repository.getFriends(
      status: status,
      limit: limit,
      offset: refresh ? 0 : state.currentPage * limit,
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to load friends: ${failure.message}',
        );
      },
      (friends) {
        state = state.copyWith(
          isLoading: false,
          friends: refresh ? friends : [...state.friends, ...friends],
          hasMoreData: friends.length >= limit,
          currentPage: refresh ? 1 : state.currentPage + 1,
        );
      },
    );
  }

  /// Load friend suggestions
  Future<void> loadFriendSuggestions({
    int limit = 10,
    List<String>? excludeIds,
  }) async {
    final result = await repository.getFriendSuggestions(
      limit: limit,
      excludeIds: excludeIds,
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          errorMessage: 'Failed to load suggestions: ${failure.message}',
        );
      },
      (suggestions) {
        state = state.copyWith(friendSuggestions: suggestions);
      },
    );
  }

  /// Search users
  Future<void> searchUsers({
    required String query,
    int limit = 20,
  }) async {
    // Clear previous results if new query
    if (query != state.searchQuery) {
      state = state.copyWith(
        searchResults: [],
        searchQuery: query,
        searchStatus: SearchStatus.initial,
      );
    }

    if (query.isEmpty) {
      state = state.copyWith(
        searchResults: [],
        searchStatus: SearchStatus.empty,
      );
      return;
    }

    state = state.copyWith(searchStatus: SearchStatus.loading);

    final result = await repository.searchUsers(
      query: query,
      limit: limit,
      offset: 0,
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          searchStatus: SearchStatus.error,
          errorMessage: 'Search failed: ${failure.message}',
        );
      },
      (users) {
        state = state.copyWith(
          searchResults: users,
          searchStatus: users.isEmpty ? SearchStatus.empty : SearchStatus.success,
        );
      },
    );
  }

  /// Send friend request
  Future<void> sendFriendRequest({
    required String userId,
  }) async {
    state = state.copyWith(requestStatus: FriendRequestStatus.loading);

    final result = await repository.sendFriendRequest(userId: userId);

    result.fold(
      (failure) {
        state = state.copyWith(
          requestStatus: FriendRequestStatus.error,
          errorMessage: 'Failed to send request: ${failure.message}',
        );
      },
      (_) {
        state = state.copyWith(requestStatus: FriendRequestStatus.success);
        // Refresh friends list (fire and forget)
        loadFriends(refresh: false);
      },
    );
  }

  /// Accept friend request
  Future<void> acceptFriendRequest({
    required String userId,
  }) async {
    final result = await repository.acceptFriendRequest(requestId: userId);

    await result.fold(
      (failure) async {
        state = state.copyWith(
          errorMessage: 'Failed to accept request: ${failure.message}',
        );
      },
      (_) async {
        // Refresh friends list
        await loadFriends(refresh: false);
      },
    );
  }

  /// Decline friend request
  Future<void> declineFriendRequest({
    required String userId,
  }) async {
    final result = await repository.declineFriendRequest(requestId: userId);

    await result.fold(
      (failure) async {
        state = state.copyWith(
          errorMessage: 'Failed to decline request: ${failure.message}',
        );
      },
      (_) async {
        // Refresh friends list
        await loadFriends(refresh: false);
      },
    );
  }

  /// Unfriend user
  Future<void> unfriend({
    required String userId,
  }) async {
    final result = await repository.unfriend(userId: userId);

    await result.fold(
      (failure) async {
        state = state.copyWith(
          errorMessage: 'Failed to unfriend: ${failure.message}',
        );
      },
      (_) async {
        // Refresh friends list
        await loadFriends(refresh: false);
      },
    );
  }

  /// Block user
  Future<void> blockUser({
    required String userId,
  }) async {
    final result = await repository.blockUser(userId: userId);

    await result.fold(
      (failure) async {
        state = state.copyWith(
          errorMessage: 'Failed to block user: ${failure.message}',
        );
      },
      (_) async {
        // Refresh friends list
        await loadFriends(refresh: false);
      },
    );
  }

  /// Unblock user
  Future<void> unblockUser({
    required String userId,
  }) async {
    final result = await repository.unblockUser(userId: userId);

    await result.fold(
      (failure) async {
        state = state.copyWith(
          errorMessage: 'Failed to unblock user: ${failure.message}',
        );
      },
      (_) async {
        // Refresh friends list
        await loadFriends(refresh: false);
      },
    );
  }

  /// Load friend requests
  Future<void> loadFriendRequests({
    RequestType? type,
    int limit = 20,
  }) async {
    final result = await repository.getFriendRequests(
      type: type,
      limit: limit,
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          errorMessage: 'Failed to load requests: ${failure.message}',
        );
      },
      (requests) {
        state = state.copyWith(friendRequests: requests);
      },
    );
  }

  /// Refresh all data
  Future<void> refresh() async {
    state = state.copyWith(currentPage: 0);
    await Future.wait([
      loadFriends(refresh: true),
      loadFriendSuggestions(),
      loadFriendRequests(),
    ]);
  }

  /// Clear search results
  void clearSearch() {
    state = state.copyWith(
      searchResults: [],
      searchQuery: null,
      searchStatus: SearchStatus.initial,
    );
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  /// Reset request status
  void resetRequestStatus() {
    state = state.copyWith(requestStatus: FriendRequestStatus.initial);
  }
}

/// Provider for friend functionality
final friendProvider = StateNotifierProvider<FriendNotifier, FriendState>((ref) {
  // Note: Inject actual dependencies
  throw UnimplementedError('Friend provider needs dependencies injected');
});

/// Convenience providers for specific data
final friendsListProvider = Provider<List<Friend>>((ref) {
  return ref.watch(friendProvider).friends;
});

final friendSuggestionsProvider = Provider<List<Friend>>((ref) {
  return ref.watch(friendProvider).friendSuggestions;
});

final searchResultsProvider = Provider<List<Friend>>((ref) {
  return ref.watch(friendProvider).searchResults;
});

final friendRequestsProvider = Provider<List<Friend>>((ref) {
  return ref.watch(friendProvider).friendRequests;
});

final isSearchLoadingProvider = Provider<bool>((ref) {
  return ref.watch(friendProvider).searchStatus == SearchStatus.loading;
});

final searchHasResultsProvider = Provider<bool>((ref) {
  return ref.watch(friendProvider).searchResults.isNotEmpty;
});

final isLoadingFriendsProvider = Provider<bool>((ref) {
  return ref.watch(friendProvider).isLoading;
});

final friendsErrorProvider = Provider<String?>((ref) {
  return ref.watch(friendProvider).errorMessage;
});
