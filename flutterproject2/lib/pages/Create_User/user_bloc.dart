import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_event.dart';
import 'user_state.dart';

// User Model
class User {
  final String username;
  final String email;
  final String password;

  User({
    required this.username,
    required this.email,
    required this.password,
  });
}

class UserBloc extends Bloc<UserEvent, UserState> {
  final List<User> _users = []; // Internal list to store users

  UserBloc() : super(UserInitial()) {
    on<CreateUserEvent>(_onCreateUser);
    on<EditUserEvent>(_onEditUser);
    on<DeleteUserEvent>(_onDeleteUser);
  }

  // Handler for creating a user
  Future<void> _onCreateUser(CreateUserEvent event, Emitter<UserState> emit) async {
    emit(UserCreating());


    await Future.delayed(const Duration(seconds: 1));

    // Check for duplicate usernames (case-insensitive)
    if (_users.any((user) => user.username.toLowerCase() == event.username.toLowerCase())) {
      emit(const UserError("Username already exists!"));
    } else {
      final newUser = User(
        username: event.username,
        email: event.email,
        password: event.password,
      );
      _users.add(newUser);
      emit(UserCreated(List.from(_users))); // Emit a copy of the updated list
    }
  }

  // Handler for editing a user
  void _onEditUser(EditUserEvent event, Emitter<UserState> emit) {
    final userIndex = _users.indexWhere(
      (user) => user.username.toLowerCase() == event.username.toLowerCase(),
    );

    if (userIndex == -1) {
      emit(const UserError("User not found!"));
    } else {
      _users[userIndex] = User(
        username: event.username, // Username remains unchanged
        email: event.newEmail,
        password: event.newPassword,
      );
      emit(UserCreated(List.from(_users))); // Emit updated list
    }
  }

  // Handler for deleting a user
  void _onDeleteUser(DeleteUserEvent event, Emitter<UserState> emit) {
    final initialLength = _users.length;
    _users.removeWhere(
      (user) => user.username.toLowerCase() == event.username.toLowerCase(),
    );

    if (_users.length < initialLength) {
      emit(UserCreated(List.from(_users))); // Emit updated list if deletion occurred
    } else {
      emit(const UserError("User not found!"));
    }
  }
}
