import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/friend.dart';
import '../providers/friend_provider.dart';

class FriendCard extends StatelessWidget {
  final Friend friend;
  final VoidCallback? onTap;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;
  final VoidCallback? onUnfriend;
  final VoidCallback? onBlock;
  final bool showActions;

  const FriendCard({
    super.key,
    required this.friend,
    this.onTap,
    this.onAccept,
    this.onDecline,
    this.onUnfriend,
    this.onBlock,
    this.showActions = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        leading: CircleAvatar(
          radius: 24.r,
          backgroundImage: NetworkImage(friend.effectiveAvatarUrl),
          backgroundColor: Colors.grey.shade300,
          onBackgroundImageError: (exception, stackTrace) {
            // Fallback to colored avatar when image fails to load
            return null;
          },
          child: friend.avatarUrl == null
              ? Text(
                  friend.effectiveDisplayName[0].toUpperCase(),
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              : null,
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                friend.effectiveDisplayName,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (friend.isHighAchiever) ...[
              SizedBox(width: 4.w),
              Icon(
                Icons.star,
                size: 16.w,
                color: Colors.amber,
              ),
            ],
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (friend.isOnline) ...[
                  Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'Online',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ] else ...[
                  Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    friend.activityStatus,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
                if (friend.streak != null) ...[
                  SizedBox(width: 8.w),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.local_fire_department,
                        size: 12.w,
                        color: Colors.orange,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        '${friend.streak}d',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
            if (friend.xp != null || friend.level != null) ...[
              SizedBox(height: 4.h),
              Row(
                children: [
                  if (friend.level != null) ...[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        'Lvl ${friend.level}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                  ],
                  if (friend.xp != null) ...[
                    Text(
                      '${friend.xp!.toInt()} XP',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ],
              ),
            ],
            if (friend.cefrLevel != null) ...[
              SizedBox(height: 4.h),
              Text(
                'CEFR: ${friend.cefrLevel}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.blue.shade600,
                ),
              ),
            ],
          ],
        ),
        trailing: showActions ? _buildActionButtons(context) : null,
        onTap: onTap,
      ),
    );
  }

  Widget? _buildActionButtons(BuildContext context) {
    switch (friend.status) {
      case FriendStatus.pending:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.check, color: Colors.green),
              onPressed: onAccept,
              tooltip: 'Accept',
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.red),
              onPressed: onDecline,
              tooltip: 'Decline',
            ),
          ],
        );
      case FriendStatus.requested:
        return IconButton(
          icon: const Icon(Icons.close, color: Colors.grey),
          onPressed: () {
            showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Cancel Request'),
                content: const Text('Do you want to cancel this friend request?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // Implement cancel request
                    },
                    child: const Text('Yes'),
                  ),
                ],
              ),
            );
          },
          tooltip: 'Cancel Request',
        );
      case FriendStatus.friends:
        return PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'profile':
                onTap?.call();
                break;
              case 'unfriend':
                onUnfriend?.call();
                break;
              case 'block':
                onBlock?.call();
                break;
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'profile',
              child: Row(
                children: [
                  const Icon(Icons.person),
                  SizedBox(width: 8.w),
                  const Text('View Profile'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'unfriend',
              child: Row(
                children: [
                  const Icon(Icons.person_remove, color: Colors.red),
                  SizedBox(width: 8.w),
                  const Text('Unfriend'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'block',
              child: Row(
                children: [
                  const Icon(Icons.block, color: Colors.red),
                  SizedBox(width: 8.w),
                  const Text('Block'),
                ],
              ),
            ),
          ],
        );
      case FriendStatus.notFriend:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.person_add),
              onPressed: onAccept,
              tooltip: 'Add Friend',
            ),
          ],
        );
      default:
        return null;
    }
  }
}

/// Friend suggestion card
class FriendSuggestionCard extends ConsumerWidget {
  final Friend friend;
  final VoidCallback? onTap;

  const FriendSuggestionCard({
    super.key,
    required this.friend,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24.r,
                  backgroundImage: NetworkImage(friend.effectiveAvatarUrl),
                  backgroundColor: Colors.grey.shade300,
                  child: friend.avatarUrl == null
                      ? Text(
                          friend.effectiveDisplayName[0].toUpperCase(),
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                      : null,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        friend.effectiveDisplayName,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (friend.mutualFriends.isNotEmpty) ...[
                        SizedBox(height: 4.h),
                        Text(
                          '${friend.mutualFriends.length} mutual friends',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.blue.shade600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref.read(friendProvider.notifier).sendFriendRequest(userId: friend.id);
                    onTap?.call();
                  },
                  child: const Text('Add Friend'),
                ),
              ],
            ),
            if (friend.xp != null || friend.level != null) ...[
              SizedBox(height: 12.h),
              Row(
                children: [
                  if (friend.level != null) ...[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        'Level ${friend.level}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                  ],
                  if (friend.xp != null) ...[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        '${friend.xp!.toInt()} XP',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.amber.shade700,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
