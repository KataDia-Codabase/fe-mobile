import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final String? hintText;
  final bool autofocus;
  final bool showFilter;
  final VoidCallback? onFilterTap;

  const SocialSearchBar({
    super.key,
    required this.controller,
    this.onChanged,
    this.hintText,
    this.autofocus = false,
    this.showFilter = true,
    this.onFilterTap,
  });

  @override
  State<SocialSearchBar> createState() => _SocialSearchBarState();
}

class _SocialSearchBarState extends State<SocialSearchBar> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    if (widget.autofocus) {
      FocusScope.of(context).requestFocus(_focusNode);
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.w),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(28.r),
          border: Border.all(
            color: _isFocused
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline.withOpacity(0.3),
            width: 1.5.w,
          ),
          boxShadow: _isFocused
              ? [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    blurRadius: 8.r,
                    spreadRadius: 1.r,
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            // Search icon
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Icon(
                Icons.search,
                size: 20.w,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            // Text field
            Expanded(
              child: TextField(
                controller: widget.controller,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: widget.hintText ?? 'Search...',
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                ),
                style: Theme.of(context).textTheme.bodyLarge,
                onChanged: widget.onChanged,
                onTap: () {
                  setState(() {
                    _isFocused = true;
                  });
                },
                onSubmitted: (value) {
                  setState(() {
                    _isFocused = false;
                  });
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
            // Clear button
            AnimatedSize(
              duration: const Duration(milliseconds: 150),
              child: widget.controller.text.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: IconButton(
                        icon: Icon(
                          Icons.clear,
                          size: 20.w,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                        ),
                        onPressed: () {
                          widget.controller.clear();
                          widget.onChanged?.call('');
                        },
                        tooltip: 'Clear',
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            // Filter button
            if (widget.showFilter) ...[
              Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: IconButton(
                  icon: Icon(
                    Icons.tune,
                    size: 20.w,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  ),
                  onPressed: widget.onFilterTap,
                  tooltip: 'Filter',
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Modern search suggestion chip
class SearchSuggestionChip extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool isSelected;

  const SearchSuggestionChip({
    super.key,
    required this.label,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(label),
      onPressed: onTap,
      backgroundColor: isSelected
          ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
          : null,
      side: isSelected
          ? BorderSide(color: Theme.of(context).colorScheme.primary)
          : null,
    );
  }
}

/// Search history item
class SearchHistoryItem extends StatelessWidget {
  final String query;
  final DateTime timestamp;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const SearchHistoryItem({
    super.key,
    required this.query,
    required this.timestamp,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: Icon(
        Icons.history,
        size: 20.w,
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
      ),
      title: Text(query),
      subtitle: Text(
        _formatTimestamp(timestamp),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
        ),
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.close,
          size: 16.w,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
        ),
        onPressed: onDelete,
        tooltip: 'Remove',
      ),
      onTap: onTap,
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) return 'Just now';
    if (difference.inMinutes < 60) return '${difference.inMinutes}m ago';
    if (difference.inHours < 24) return '${difference.inHours}h ago';
    if (difference.inDays < 7) return '${difference.inDays}d ago';
    if (difference.inDays < 30) return '${(difference.inDays / 7).floor()}w ago';
    return '${timestamp.day}/${timestamp.month}';
  }
}

/// Search filter dialog
class SearchFilterDialog extends StatefulWidget {
  final Map<String, Set<String>> availableFilters;
  final Map<String, Set<String>> selectedFilters;

  const SearchFilterDialog({
    super.key,
    required this.availableFilters,
    required this.selectedFilters,
  });

  @override
  State<SearchFilterDialog> createState() => _SearchFilterDialogState();
}

class _SearchFilterDialogState extends State<SearchFilterDialog> {
  late Map<String, Set<String>> _selectedFilters;

  @override
  void initState() {
    super.initState();
    // Create a deep copy of selectedFilters
    _selectedFilters = widget.selectedFilters.map(
      (key, value) => MapEntry(key, Set<String>.from(value)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filter Results'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.6,
        child: ListView(
          children: widget.availableFilters.entries.map((entry) {
            final category = entry.key;
            final options = entry.value;
            final selectedOptions = _selectedFilters[category] ?? <String>{};

            return ExpansionTile(
              title: Text(_formatFilterCategory(category)),
              children: options.map((option) {
                final isSelected = selectedOptions.contains(option);
                return CheckboxListTile(
                  value: isSelected,
                  title: Text(option),
                  onChanged: (value) {
                    setState(() {
                      if (value == true) {
                        _selectedFilters[category] ??= <String>{};
                        _selectedFilters[category]!.add(option);
                      } else {
                        _selectedFilters[category]?.remove(option);
                      }
                    });
                  },
                );
              }).toList(),
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Clear all filters
            setState(() {
              _selectedFilters.clear();
            });
          },
          child: const Text('Clear All'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, _selectedFilters),
          child: const Text('Apply'),
        ),
      ],
    );
  }

  String _formatFilterCategory(String category) {
    switch (category) {
      case 'status':
        return 'Friend Status';
      case 'level':
        return 'CEFR Level';
      case 'activity':
        return 'Activity Status';
      default:
        return category[0].toUpperCase() + category.substring(1);
    }
  }
}
