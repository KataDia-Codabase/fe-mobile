part of 'onboarding_bloc.dart';

class OnboardingState {
  final int currentPage;
  final bool isLastPage;
  final bool isCompleted;

  const OnboardingState({
    required this.currentPage,
    this.isLastPage = false,
    this.isCompleted = false,
  });

  OnboardingState copyWith({
    int? currentPage,
    bool? isLastPage,
    bool? isCompleted,
  }) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      isLastPage: isLastPage ?? this.isLastPage,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OnboardingState &&
          runtimeType == other.runtimeType &&
          currentPage == other.currentPage &&
          isLastPage == other.isLastPage &&
          isCompleted == other.isCompleted;

  @override
  int get hashCode => currentPage.hashCode ^ isLastPage.hashCode ^ isCompleted.hashCode;
}
