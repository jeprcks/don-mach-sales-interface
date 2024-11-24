import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_bloc.dart';
import 'user_event.dart';
import 'user_state.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreateUserPageState createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Function to show the edit dialog
  void _showEditDialog(BuildContext context, String username,
      String currentUsername, String currentPassword) {
    final passwordController = TextEditingController(text: currentPassword);
    final usernameController = TextEditingController(text: currentUsername);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit User'),
        content: SingleChildScrollView(
          // To prevent overflow
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              final newPassword = passwordController.text.trim();
              final newUsername = usernameController.text.trim();

              if (newUsername.isEmpty || newPassword.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please fill in all fields.")),
                );
                return;
              }

              context.read<UserBloc>().add(EditUserEvent(
                    username: username,
                    newPassword: newPassword,
                  ));

              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  // Function to show delete confirmation dialog
  void _showDeleteConfirmation(BuildContext context, String username) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete User'),
          content: Text('Are you sure you want to delete user "$username"?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<UserBloc>().add(DeleteUserEvent(username));
                Navigator.of(context).pop(); // Close dialog
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // No need to provide UserBloc here as it's provided in main.dart
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create User'),
        backgroundColor: Colors.brown,
      ),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserCreated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("User created successfully!")),
            );
            _usernameController.clear();
            _passwordController.clear();
          } else if (state is UserError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(builder: (context, constraints) {
            // Define breakpoints for responsive design
            bool isSmallScreen =
                constraints.maxWidth < 600; // Example breakpoint

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Creation Form
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
                const SizedBox(height: 10),

                const SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),

                const SizedBox(height: 20),
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state is UserCreating
                          ? null // Disable the button if creating
                          : () {
                              final username = _usernameController.text.trim();
                              final password = _passwordController.text.trim();

                              if (username.isEmpty ||
                                  username.isEmpty ||
                                  password.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Please fill in all fields.")),
                                );
                                return; // Prevent event from being added
                              }

                              context.read<UserBloc>().add(CreateUserEvent(
                                    username: username,
                                    password: password,
                                  ));
                            },
                      child: const Text('Create User'),
                    );
                  },
                ),

                const SizedBox(height: 20),

                // Responsive User List Table
                Expanded(
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      if (state is UserCreated) {
                        if (state.users.isEmpty) {
                          return const Center(
                              child: Text('No users created yet.'));
                        }

                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: constraints.maxWidth,
                            ),
                            child: DataTable(
                              columns: [
                                DataColumn(
                                  label: Text(
                                    'Username',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: isSmallScreen ? 12 : 16,
                                    ),
                                  ),
                                ),
                                if (!isSmallScreen)
                                  DataColumn(
                                    label: Text(
                                      'Password',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: isSmallScreen ? 12 : 16,
                                      ),
                                    ),
                                  ),
                                DataColumn(
                                  label: Text(
                                    'Actions',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: isSmallScreen ? 12 : 16,
                                    ),
                                  ),
                                ),
                              ],
                              columnSpacing: isSmallScreen ? 20 : 40,
                              horizontalMargin: isSmallScreen ? 10 : 20,
                              rows: state.users.map((user) {
                                return DataRow(cells: [
                                  DataCell(Text(
                                    user.username,
                                    style: TextStyle(
                                        fontSize: isSmallScreen ? 12 : 16),
                                  )),
                                  if (!isSmallScreen)
                                    DataCell(Text(
                                      '*' *
                                          user.password
                                              .length, // Masked password for security
                                      style: TextStyle(
                                          fontSize: isSmallScreen ? 12 : 16),
                                    )),
                                  DataCell(Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit,
                                            color: Colors.blue),
                                        onPressed: () => _showEditDialog(
                                          context,
                                          user.username,
                                          user.username,
                                          user.password,
                                        ),
                                        tooltip: 'Edit User',
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () {
                                          _showDeleteConfirmation(
                                              context, user.username);
                                        },
                                        tooltip: 'Delete User',
                                      ),
                                    ],
                                  )),
                                ]);
                              }).toList(),
                            ),
                          ),
                        );
                      } else if (state is UserCreating) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is UserError) {
                        return Center(child: Text(state.message));
                      }

                      return const SizedBox.shrink(); // Default empty state
                    },
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
