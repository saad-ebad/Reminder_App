// lib/features/join_success/viewmodel/join_success_state.dart
class JoinSuccessState {
  final bool isLoadingHome;

  const JoinSuccessState({this.isLoadingHome = false});

  JoinSuccessState copyWith({bool? isLoadingHome}) {
    return JoinSuccessState(
      isLoadingHome: isLoadingHome ?? this.isLoadingHome,
    );
  }
}
