import 'package:equatable/equatable.dart';

/// Base class for bloc states with loading, data, and error states
///
/// This class provides a standardized way to handle state management
/// across the application with common states for loading, success, and error.
abstract class BaseState<T> extends Equatable {
  final bool isLoading;
  final T? data;
  final String? errorMessage;

  const BaseState({
    this.isLoading = false,
    this.data,
    this.errorMessage,
  });

  /// Returns true if the state represents a loading state
  bool get isLoadingState => isLoading;

  /// Returns true if the state contains data and is not loading or error
  bool get isSuccessWithData => data != null && !isLoading && errorMessage == null;

  /// Returns true if the state represents an error state
  bool get isErrorState => errorMessage != null && !isLoading;

  BaseState<T> copyWith({
    bool? isLoading,
    T? data,
    String? errorMessage,
  });

  @override
  List<Object?> get props => [isLoading, data, errorMessage];
}

// /// Loading state with optional previous data
// class LoadingState<T> extends BaseState<T> {
//   const LoadingState({super.data}) : super(isLoading: true);
// }

// /// Data state with required data
// class DataState<T> extends BaseState<T> {
//   const DataState(T data) : super(data: data);
// }

// /// Error state with required error message and optional previous data
// class ErrorState<T> extends BaseState<T> {
//   const ErrorState(String errorMessage, {super.data})
//       : super(errorMessage: errorMessage);
// }
