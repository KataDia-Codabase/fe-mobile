part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc {
  OnboardingState _state;
  final List<void Function(OnboardingState)> _listeners = [];

  OnboardingBloc() : _state = const OnboardingState(currentPage: 0);

  OnboardingState get state => _state;

  void add(OnboardingEvent event) {
    if (event is NextPageRequested) {
      _onNextPageRequested();
    } else if (event is PreviousPageRequested) {
      _onPreviousPageRequested();
    } else if (event is PageChanged) {
      _onPageChanged(event.pageIndex);
    } else if (event is SkipOnboardingRequested) {
      _onSkipOnboardingRequested();
    }
  }

  void _emit(OnboardingState newState) {
    _state = newState;
    for (final listener in _listeners) {
      listener(_state);
    }
  }

  void listen(void Function(OnboardingState) listener) {
    _listeners.add(listener);
  }

  void dispose() {
    _listeners.clear();
  }

  void _onNextPageRequested() {
    int nextPage = _state.currentPage + 1;
    bool isLastPage = nextPage >= 2; // Assuming 3 pages (0, 1, 2)
    
    _emit(_state.copyWith(
      currentPage: nextPage,
      isLastPage: isLastPage,
    ));
  }

  void _onPreviousPageRequested() {
    int previousPage = (_state.currentPage - 1).clamp(0, 2);
    bool isLastPage = previousPage >= 2;
    
    _emit(_state.copyWith(
      currentPage: previousPage,
      isLastPage: isLastPage,
    ));
  }

  void _onPageChanged(int pageIndex) {
    bool isLastPage = pageIndex >= 2;
    
    _emit(_state.copyWith(
      currentPage: pageIndex,
      isLastPage: isLastPage,
    ));
  }

  void _onSkipOnboardingRequested() {
    // TODO: Navigate to main app or login
    // This would typically complete onboarding and navigate away
    
  }
}
