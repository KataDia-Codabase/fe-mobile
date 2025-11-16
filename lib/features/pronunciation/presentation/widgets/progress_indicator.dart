import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum PronunciationStep {
  preparation,
  recording,
  uploading,
  processing,
  completed,
  error,
}

class PronunciationProgressIndicator extends StatelessWidget {
  final PronunciationStep currentStep;
  final int totalSteps;

  const PronunciationProgressIndicator({
    super.key,
    required this.currentStep,
    this.totalSteps = 5,
  });

  @override
  Widget build(BuildContext context) {
    final stepIndex = _getStepIndex(currentStep);
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(totalSteps, (index) {
              final step = _getStepByIndex(index);
              final isActive = index == stepIndex;
              final isCompleted = _isStepCompleted(stepIndex, index);
              final hasError = currentStep == PronunciationStep.error && 
                             index >= stepIndex;
              
              return Expanded(
                child: _buildStepDot(
                  step: step,
                  isActive: isActive,
                  isCompleted: isCompleted,
                  hasError: hasError,
                  index: index,
                ),
              );
            }),
          ),
          SizedBox(height: 8.h),
          Row(
            children: List.generate(totalSteps - 1, (index) {
              final isCompleted = _isStepCompleted(stepIndex, index);
              final hasError = currentStep == PronunciationStep.error && 
                             index >= stepIndex - 1;
              
              return Expanded(
                child: _buildProgressLine(
                  isCompleted: isCompleted,
                  hasError: hasError,
                ),
              );
            }),
          ),
          SizedBox(height: 16.h),
          Text(
            _getStepTitle(currentStep),
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: _getStepColor(currentStep),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            _getStepDescription(currentStep),
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepDot({
    required PronunciationStep step,
    required bool isActive,
    required bool isCompleted,
    required bool hasError,
    required int index,
  }) {
    return Column(
      children: [
        Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _getStepDotColor(isActive: isActive, isCompleted: isCompleted, hasError: hasError),
            border: Border.all(
              color: _getStepDotBorderColor(
                isActive: isActive, 
                isCompleted: isCompleted, 
                hasError: hasError
              ),
              width: 2.w,
            ),
          ),
          child: Center(
            child: _buildStepIcon(isActive: isActive, isCompleted: isCompleted, hasError: hasError),
          ),
        ),
        SizedBox(height: 8.h),
        if (index == 0 || index == totalSteps - 1)
          Text(
            _getStepDotTitle(step),
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              color: _getStepTextColor(currentStep: step),
            ),
            textAlign: TextAlign.center,
          ),
      ],
    );
  }

  Widget _buildStepIcon({
    required bool isActive,
    required bool isCompleted,
    required bool hasError,
  }) {
    if (hasError) {
      return Icon(
        Icons.error,
        size: 16.w,
        color: Colors.white,
      );
    }
    
    if (isCompleted) {
      return Icon(
        Icons.check,
        size: 16.w,
        color: Colors.white,
      );
    }
    
    if (isActive) {
      return Container(
        width: 8.w,
        height: 8.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
      );
    }
    
    return Container(
      width: 8.w,
      height: 8.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
      ),
    );
  }

  Widget _buildProgressLine({
    required bool isCompleted,
    required bool hasError,
  }) {
    return Container(
      height: 2.h,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: hasError 
            ? Colors.red.withOpacity(0.3)
            : isCompleted 
                ? Colors.green.withOpacity(0.3)
                : Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(1.r),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: hasError ? 0.5 : (isCompleted ? 1.0 : 0.0),
        child: Container(
          height: 2.h,
          decoration: BoxDecoration(
            color: hasError 
                ? Colors.red
                : isCompleted 
                    ? Colors.green
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(1.r),
          ),
        ),
      ),
    );
  }

  int _getStepIndex(PronunciationStep step) {
    switch (step) {
      case PronunciationStep.preparation:
        return 0;
      case PronunciationStep.recording:
        return 1;
      case PronunciationStep.uploading:
        return 2;
      case PronunciationStep.processing:
        return 3;
      case PronunciationStep.completed:
        return 4;
      case PronunciationStep.error:
        return 3; // Show error at processing step
    }
  }

  PronunciationStep _getStepByIndex(int index) {
    switch (index) {
      case 0:
        return PronunciationStep.preparation;
      case 1:
        return PronunciationStep.recording;
      case 2:
        return PronunciationStep.uploading;
      case 3:
        return PronunciationStep.processing;
      case 4:
        return PronunciationStep.completed;
      default:
        return PronunciationStep.preparation;
    }
  }

  bool _isStepCompleted(int currentStepIndex, int stepIndex) {
    return stepIndex < currentStepIndex;
  }

  String _getStepTitle(PronunciationStep step) {
    switch (step) {
      case PronunciationStep.preparation:
        return 'Preparation';
      case PronunciationStep.recording:
        return 'Recording';
      case PronunciationStep.uploading:
        return 'Uploading';
      case PronunciationStep.processing:
        return 'Processing';
      case PronunciationStep.completed:
        return 'Completed';
      case PronunciationStep.error:
        return 'Error';
    }
  }

  String _getStepDescription(PronunciationStep step) {
    switch (step) {
      case PronunciationStep.preparation:
        return 'Get ready to pronounce the target phrase';
      case PronunciationStep.recording:
        return 'Recording your pronunciation';
      case PronunciationStep.uploading:
        return 'Uploading your audio for analysis';
      case PronunciationStep.processing:
        return 'Analyzing your pronunciation using AI';
      case PronunciationStep.completed:
        return 'Results are ready! Check your score';
      case PronunciationStep.error:
        return 'Something went wrong. Please try again';
    }
  }

  String _getStepDotTitle(PronunciationStep step) {
    switch (step) {
      case PronunciationStep.preparation:
        return 'Ready';
      case PronunciationStep.recording:
        return 'Record';
      case PronunciationStep.uploading:
        return 'Upload';
      case PronunciationStep.processing:
        return 'Analyze';
      case PronunciationStep.completed:
        return 'Done';
      case PronunciationStep.error:
        return 'Error';
    }
  }

  Color _getStepDotColor({
    required bool isActive,
    required bool isCompleted,
    required bool hasError,
  }) {
    if (hasError) return Colors.red.withOpacity(0.2);
    if (isActive) return Colors.blue.withOpacity(0.2);
    if (isCompleted) return Colors.green.withOpacity(0.2);
    return Colors.grey.withOpacity(0.1);
  }

  Color _getStepDotBorderColor({
    required bool isActive,
    required bool isCompleted,
    required bool hasError,
  }) {
    if (hasError) return Colors.red;
    if (isActive) return Colors.blue;
    if (isCompleted) return Colors.green;
    return Colors.grey.shade300;
  }

  Color _getStepTextColor({
    required PronunciationStep currentStep,
  }) {
    switch (currentStep) {
      case PronunciationStep.preparation:
        return Colors.blue;
      case PronunciationStep.recording:
        return Colors.orange;
      case PronunciationStep.uploading:
        return Colors.purple;
      case PronunciationStep.processing:
        return Colors.indigo;
      case PronunciationStep.completed:
        return Colors.green;
      case PronunciationStep.error:
        return Colors.red;
    }
  }

  Color _getStepColor(PronunciationStep step) {
    switch (step) {
      case PronunciationStep.preparation:
        return Colors.blue;
      case PronunciationStep.recording:
        return Colors.orange;
      case PronunciationStep.uploading:
        return Colors.purple;
      case PronunciationStep.processing:
        return Colors.indigo;
      case PronunciationStep.completed:
        return Colors.green;
      case PronunciationStep.error:
        return Colors.red;
    }
  }
}
