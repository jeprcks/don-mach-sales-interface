import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
  
  @override
  List<Object?> get props => [];
}

// Event to create a new user
class CreateUserEvent extends UserEvent {
  final String username;
  final String email;
  final String password;

  const CreateUserEvent({
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [username, email, password];
}

// Event to edit an existing user's email and password
class EditUserEvent extends UserEvent {
  final String username;
  final String newEmail;
  final String newPassword;

  const EditUserEvent({
    required this.username,
    required this.newEmail,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [username, newEmail, newPassword];
}

// Event to delete a user
class DeleteUserEvent extends UserEvent {
  final String username;

  const DeleteUserEvent(this.username);

  @override
  List<Object?> get props => [username];
}
