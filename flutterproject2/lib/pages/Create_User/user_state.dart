import 'package:equatable/equatable.dart';
import 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
  
  @override
  List<Object?> get props => [];
}

// Initial state
class UserInitial extends UserState {}

// Loading state when creating a user
class UserCreating extends UserState {}

// State when users are loaded or updated
class UserCreated extends UserState {
  final List<User> users;

  const UserCreated(this.users);

  @override
  List<Object?> get props => [users];
}

// Error state
class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object?> get props => [message];
}
