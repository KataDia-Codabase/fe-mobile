import 'package:equatable/equatable.dart';

/// Friend entity for social networking features
class Friend extends Equatable {
  final String id;
  final String userId;
  final String friendId;
  final String username;
  final String displayName;
  final String? avatarUrl;
  final FriendStatus status;
  final double? xp;
  final int? level;
  final int? streak;
  final String? cefrLevel;
  final FriendshipLevel friendshipLevel;
  final DateTime? lastInteraction;
  final List<String> mutualFriends;
  final bool isOnline;
  final DateTime? lastSeen;
  final bool isBlocked;
  final PrivacySettings privacy;

  const Friend({
    required this.id,
    required this.userId,
    required this.friendId,
    required this.username,
    required this.displayName,
    this.avatarUrl,
    this.status = FriendStatus.pending,
    this.xp,
    this.level,
    this.streak,
    this.cefrLevel,
    this.friendshipLevel = FriendshipLevel.newFriend,
    this.lastInteraction,
    this.mutualFriends = const [],
    this.isOnline = false,
    this.lastSeen,
    this.isBlocked = false,
    this.privacy = const PrivacySettings(),
  });

  /// Create a friend from user data for sending friend request
  factory Friend.fromUser({
    required String userId,
    required String username,
    required String displayName,
    String? avatarUrl,
    double? xp,
    int? level,
    int? streak,
    String? cefrLevel,
    bool isOnline = false,
    DateTime? lastSeen,
  }) {
    return Friend(
      id: '${userId}_request',
      userId: userId,
      friendId: currentUser, // This would be injected from auth state
      username: username,
      displayName: displayName,
      avatarUrl: avatarUrl,
      xp: xp,
      level: level,
      streak: streak,
      cefrLevel: cefrLevel,
      isOnline: isOnline,
      lastSeen: lastSeen,
      status: FriendStatus.notFriend,
    );
  }

  /// Check if this friend is currently a confirmed friend
  bool get isFriend => status == FriendStatus.friends;

  /// Check if friend request is pending (sent or received)
  bool get isPending => status == FriendStatus.pending || status == FriendStatus.requested;

  /// Get display name with fallback to username
  String get effectiveDisplayName => displayName.isNotEmpty ? displayName : username;

  /// Get avatar URL with fallback
  String get effectiveAvatarUrl => avatarUrl ?? getDefaultAvatar();

  /// Check if user has high achievements
  bool get isHighAchiever => (xp != null && xp! > 5000.0) || (level != null && level! > 10);

  /// Get activity status text
  String get activityStatus {
    if (isOnline) return 'Online';
    if (lastSeen == null) return 'Unknown';
    
    final now = DateTime.now();
    final difference = now.difference(lastSeen!);
    
    if (difference.inMinutes < 1) return 'Just now';
    if (difference.inMinutes < 60) return '${difference.inMinutes}m ago';
    if (difference.inHours < 24) return '${difference.inHours}h ago';
    if (difference.inDays < 7) return '${difference.inDays} days ago';
    
    return 'Offline';
  }

  /// Get friendship progress percentage (0-100)
  double get friendshipProgress {
    switch (friendshipLevel) {
      case FriendshipLevel.newFriend:
        return 20.0;
      case FriendshipLevel.goodFriend:
        return 40.0;
      case FriendshipLevel.closeFriend:
        return 60.0;
      case FriendshipLevel.bestFriend:
        return 80.0;
      case FriendshipLevel.ultimateFriend:
        return 100.0;
    }
  }

  /// Get default avatar URL based on username
  String getDefaultAvatar() {
    // Generate avatar from username initial
    final initial = displayName.isNotEmpty ? displayName[0].toUpperCase() : 
                   username.isNotEmpty ? username[0].toUpperCase() : 'U';
    return 'https://ui-avatars.com/api/?name=$initial&background=1976D2&color=fff&size=128';
  }

  Friend copyWith({
    String? id,
    String? userId,
    String? friendId,
    String? username,
    String? displayName,
    String? avatarUrl,
    FriendStatus? status,
    double? xp,
    int? level,
    int? streak,
    String? cefrLevel,
    FriendshipLevel? friendshipLevel,
    DateTime? lastInteraction,
    List<String>? mutualFriends,
    bool? isOnline,
    DateTime? lastSeen,
    bool? isBlocked,
    PrivacySettings? privacy,
  }) {
    return Friend(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      friendId: friendId ?? this.friendId,
      username: username ?? this.username,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      status: status ?? this.status,
      xp: xp ?? this.xp,
      level: level ?? this.level,
      streak: streak ?? this.streak,
      cefrLevel: cefrLevel ?? this.cefrLevel,
      friendshipLevel: friendshipLevel ?? this.friendshipLevel,
      lastInteraction: lastInteraction ?? this.lastInteraction,
      mutualFriends: mutualFriends ?? this.mutualFriends,
      isOnline: isOnline ?? this.isOnline,
      lastSeen: lastSeen ?? this.lastSeen,
      isBlocked: isBlocked ?? this.isBlocked,
      privacy: privacy ?? this.privacy,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        friendId,
        username,
        displayName,
        avatarUrl,
        status,
        xp,
        level,
        streak,
        cefrLevel,
        friendshipLevel,
        lastInteraction,
        mutualFriends,
        isOnline,
        lastSeen,
        isBlocked,
        privacy,
      ];
}

/// Friend status enumeration
enum FriendStatus {
  notFriend,
  requested,       // You sent request
  pending,         // They sent request (incoming)
  blocked,
  friends,         // Confirmed friendship
  muted,
}

/// Friendship level based on interaction history
enum FriendshipLevel {
  newFriend,       // Just became friends
  goodFriend,      // Regular interaction
  closeFriend,     // Frequent interaction
  bestFriend,      // Very close relationship
  ultimateFriend,  // Maximum friendship level
}

/// Privacy settings for friend interactions
class PrivacySettings extends Equatable {
  final bool shareProgress;
  final bool shareAchievements;
  final bool shareLearningData;
  final bool allowMessages;
  final bool allowChallenges;
  final bool showOnlineStatus;
  final bool allowFriendSuggestions;

  const PrivacySettings({
    this.shareProgress = true,
    this.shareAchievements = true,
    this.shareLearningData = false,
    this.allowMessages = true,
    this.allowChallenges = true,
    this.showOnlineStatus = true,
    this.allowFriendSuggestions = true,
  });

  @override
  List<Object?> get props => [
        shareProgress,
        shareAchievements,
        shareLearningData,
        allowMessages,
        allowChallenges,
        showOnlineStatus,
        allowFriendSuggestions,
      ];
}

/// Current user placeholder (this would come from auth state)
const String currentUser = 'current_user_id';
