part of 'onboarding_bloc.dart';

class OnboardingState {
  final int currentPage;
  final bool isLastPage;

  const OnboardingState({
    required this.currentPage,
    this.isLastPage = false,
  });

  OnboardingState copyWith({
    int? currentPage,
    bool? isLastPage,
  }) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      isLastPage: isLastPage ?? this.isLastPage,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OnboardingState &&
          runtimeType == other.runtimeType &&
          currentPage == other.currentPage &&
          isLastPage == other.isLastPage;

  @override
  int get hashCode => currentPage.hashCode ^ isLastPage.hashCode;
}
