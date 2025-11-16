import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katadia_app/features/lessons/domain/entities/lesson_content.dart';
import 'package:katadia_app/features/lessons/domain/entities/lesson_progress.dart';
import 'package:katadia_app/features/pronunciation/presentation/screens/pronunciation_practice_screen.dart';
import 'package:katadia_app/shared/theme/app_colors.dart';

class LessonContentRenderer extends ConsumerStatefulWidget {
  final LessonContent content;
  final LessonProgress? progress;
  final void Function(LessonContent)? onProgressUpdate;

  const LessonContentRenderer({
    Key? key,
    required this.content,
    this.progress,
    this.onProgressUpdate,
  }) : super(key: key);

  @override
  ConsumerState<LessonContentRenderer> createState() => _LessonContentRendererState();
}

class _LessonContentRendererState extends ConsumerState<LessonContentRenderer>
    with TickerProviderStateMixin {
  bool _isCompleted = false;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _isCompleted = widget.progress?.contentProgress
        .any((cp) => cp.contentId == widget.content.id && cp.status == CompletionStatus.completed) 
        ?? false;
    
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: _isCompleted
            ? Border.all(color: AppColors.success, width: 2)
            : Border.all(color: AppColors.borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          _buildHeader(),
          
          // Content
          _buildContentRenderer(),
          
          // Actions
          if (widget.content.contentType != ContentType.exercise)
            _buildActions(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          // Order number
          Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: _isCompleted ? AppColors.success : AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Center(
              child: _isCompleted
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 18.w,
                    )
                  : Text(
                      '${widget.content.order}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
            ),
          ),
          SizedBox(width: 12.w),
          
          // Title and type
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.content.title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  widget.content.contentType.displayName,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: _getContentTypeColor(),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          
          // Content type icon
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: _getContentTypeColor().withOpacity(0.1),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Center(
              child: Icon(
                _getContentTypeIcon(),
                size: 20.w,
                color: _getContentTypeColor(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentRenderer() {
    switch (widget.content.contentType) {
      case ContentType.text:
        return _buildTextContent();
      case ContentType.audio:
        return _buildAudioContent();
      case ContentType.image:
        return _buildImageContent();
      case ContentType.video:
        return _buildVideoContent();
      case ContentType.interactive:
        return _buildInteractiveContent();
      case ContentType.exercise:
        return _buildExerciseContent();
    }
  }

  Widget _buildTextContent() {
    final translation = widget.content.translation;
    
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main text
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              widget.content.text ?? 'No content available',
              style: TextStyle(
                fontSize: 16.sp,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
          ),
          
          // Phonetic transcription if available
          if (widget.content.phoneticTranscription != null) ...[
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.record_voice_over,
                    size: 16.w,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      widget.content.phoneticTranscription!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontStyle: FontStyle.italic,
                        color: AppColors.primary,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          
          // Translation if available
          if (translation != null) ...[
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Translation:',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    translation,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.blue.shade900,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAudioContent() {
    final translation = widget.content.translation;
    
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text if available
          if (widget.content.text != null) ...[
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                widget.content.text!,
                style: TextStyle(
                  fontSize: 14.sp,
                  height: 1.4,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 12.h),
          ],
          
          // Phonetic transcription
          if (widget.content.phoneticTranscription != null) ...[
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                widget.content.phoneticTranscription!,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontStyle: FontStyle.italic,
                  color: AppColors.primary,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            SizedBox(height: 12.h),
          ],
          
          // Audio player placeholder
          Container(
            height: 80.h,
            decoration: BoxDecoration(
              color: AppColors.pronunciationColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.play_circle_outline,
                    size: 32.w,
                    color: AppColors.pronunciationColor,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Tap to play audio',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.pronunciationColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Translation if available
          if (translation != null) ...[
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Translation:',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    translation,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.blue.shade900,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildImageContent() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder
          Container(
            height: 200.h,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image,
                    size: 48.w,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Image Content',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Caption if available
          if (widget.content.text != null) ...[
            SizedBox(height: 12.h),
            Text(
              widget.content.text!,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildVideoContent() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Video placeholder
          Container(
            height: 200.h,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.play_circle_filled,
                    size: 48.w,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Video Content',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Description if available
          if (widget.content.text != null) ...[
            SizedBox(height: 12.h),
            Text(
              widget.content.text!,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black87,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInteractiveContent() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Container(
        height: 150.h,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.touch_app,
                size: 48.w,
                color: Colors.grey[400],
              ),
              SizedBox(height: 8.h),
              Text(
                'Interactive Content',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Tap to interact',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExerciseContent() {
    // Check if this is a pronunciation practice exercise
    final interactiveData = widget.content.interactiveData;
    if (interactiveData != null && interactiveData['type'] == 'pronunciation_practice') {
      return Padding(
        padding: EdgeInsets.all(16.w),
        child: Container(
          height: 150.h,
          decoration: BoxDecoration(
            color: AppColors.pronunciationColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.mic,
                  size: 48.w,
                  color: AppColors.pronunciationColor,
                ),
                SizedBox(height: 8.h),
                Text(
                  'Pronunciation Practice',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.pronunciationColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Practice speaking with AI feedback',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    
    // Default exercise content
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Container(
        height: 150.h,
        decoration: BoxDecoration(
          color: AppColors.warning.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.assignment,
                size: 48.w,
                color: AppColors.warning,
              ),
              SizedBox(height: 8.h),
              Text(
                'Exercise',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.warning,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Practice your skills',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActions() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          // Practice button
          Expanded(
            child: ElevatedButton.icon(
              onPressed: _isCompleted ? null : _markAsCompleted,
              icon: Icon(
                _isCompleted ? Icons.check : 
                (widget.content.interactiveData?['type'] == 'pronunciation_practice' 
                    ? Icons.mic : Icons.assignment),
                size: 16.w,
              ),
              label: Text(
                _isCompleted ? 'Completed' : 
                (widget.content.interactiveData?['type'] == 'pronunciation_practice' 
                    ? 'Start Practice' : 'Practice'),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: _isCompleted ? AppColors.success : 
                (widget.content.interactiveData?['type'] == 'pronunciation_practice' 
                    ? AppColors.pronunciationColor : AppColors.primary),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12.h),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          
          // More options button
          IconButton(
            onPressed: _showMoreOptions,
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }

  void _markAsCompleted() async {
    // Check if this is a pronunciation practice exercise
    final interactiveData = widget.content.interactiveData;
    if (interactiveData != null && interactiveData['type'] == 'pronunciation_practice') {
      // Get the target text for pronunciation practice
      final phrases = interactiveData['phrases'] as List<dynamic>? ?? [];
      if (phrases.isNotEmpty) {
        final firstPhrase = phrases.first as Map<String, dynamic>;
        final targetText = firstPhrase['text'] as String? ?? 'Hello';
        final targetAudioUrl = firstPhrase['audio'] as String?;
        
        // Navigate to pronunciation practice screen
        await Navigator.of(context).push<void>(
          MaterialPageRoute<void>(
            builder: (context) => PronunciationPracticeScreen(
              targetText: targetText,
              targetAudioUrl: targetAudioUrl,
              lessonId: widget.content.lessonId,
              sessionId: 'session_${DateTime.now().millisecondsSinceEpoch}',
            ),
          ),
        );
        
        // Mark as completed after returning from practice
        setState(() {
          _isCompleted = true;
        });
        
        // Pulse animation
        _pulseController.forward().then((_) {
          _pulseController.reverse();
        });
        
        widget.onProgressUpdate?.call(widget.content);
        return;
      }
    }
    
    // Default behavior for other content types
    setState(() {
      _isCompleted = true;
    });
    
    // Pulse animation
    _pulseController.forward().then((_) {
      _pulseController.reverse();
    });
    
    widget.onProgressUpdate?.call(widget.content);
  }

  void _showMoreOptions() {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.speaker),
              title: Text('Play Slow'),
              onTap: () {
                Navigator.pop(context);
                // Need to implement slow playback
              },
            ),
            ListTile(
              leading: Icon(Icons.repeat),
              title: Text('Loop Audio'),
              onTap: () {
                Navigator.pop(context);
                // Need to implement loop functionality
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('View Details'),
              onTap: () {
                Navigator.pop(context);
                // Need to show content details
              },
            ),
          ],
        ),
      ),
    );
  }

  Color _getContentTypeColor() {
    switch (widget.content.contentType) {
      case ContentType.text:
        return Colors.blue;
      case ContentType.audio:
        return AppColors.pronunciationColor;
      case ContentType.image:
        return Colors.purple;
      case ContentType.video:
        return Colors.red;
      case ContentType.interactive:
        return Colors.indigo;
      case ContentType.exercise:
        return AppColors.warning;
    }
  }

  IconData _getContentTypeIcon() {
    switch (widget.content.contentType) {
      case ContentType.text:
        return Icons.text_fields;
      case ContentType.audio:
        return Icons.audiotrack;
      case ContentType.image:
        return Icons.image;
      case ContentType.video:
        return Icons.videocam;
      case ContentType.interactive:
        return Icons.touch_app;
      case ContentType.exercise:
        return Icons.assignment;
    }
  }
}
