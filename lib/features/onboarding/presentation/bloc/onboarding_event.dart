part of 'onboarding_bloc.dart';

abstract class OnboardingEvent {
  const OnboardingEvent();

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => runtimeType.hashCode;
}

class NextPageRequested extends OnboardingEvent {}

class SkipOnboardingRequested extends OnboardingEvent {}

class PreviousPageRequested extends OnboardingEvent {}

class PageChanged extends OnboardingEvent {
  final int pageIndex;

  const PageChanged(this.pageIndex);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is PageChanged && other.pageIndex == pageIndex;

  @override
  int get hashCode => pageIndex.hashCode;
}
