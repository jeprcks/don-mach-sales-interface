// // settings_page.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutterproject2/bloc/product_bloc.dart';
// import 'package:flutterproject2/bloc/product_event.dart';
// import 'package:flutterproject2/bloc/product_state.dart';

// class SettingsPage extends StatefulWidget {
//   const SettingsPage({super.key});

//   @override
//   _SettingsPageState createState() => _SettingsPageState();
// }

// class _SettingsPageState extends State<SettingsPage> {
//   File? _imageFile;
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();

//   Future<void> _pickImage() async {
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Settings"),
//         backgroundColor: Colors.brown,
//       ),
//       body: BlocProvider(
//         create: (context) => SettingsBloc(),
//         child: BlocListener<SettingsBloc, SettingsState>(
//           listener: (context, state) {
//             if (state is SettingsSuccess) {
//               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
//             } else if (state is SettingsFailure) {
//               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
//             }
//           },
//           child: BlocBuilder<SettingsBloc, SettingsState>(
//             builder: (context, state) {
//               return Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     // Profile Picture
//                     GestureDetector(
//                       onTap: _pickImage,
//                       child: CircleAvatar(
//                         radius: 50,
//                         backgroundImage: _imageFile != null
//                             ? FileImage(_imageFile!)
//                             : const AssetImage('assets/donmac.jpg') as ImageProvider,
//                         child: _imageFile == null
//                             ? const Icon(Icons.camera_alt, size: 50, color: Colors.white)
//                             : null,
//                       ),
//                     ),
//                     const SizedBox(height: 20),

//                     // Password Fields
//                     TextField(
//                       controller: _passwordController,
//                       obscureText: true,
//                       decoration: const InputDecoration(
//                         labelText: "New Password",
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     TextField(
//                       controller: _confirmPasswordController,
//                       obscureText: true,
//                       decoration: const InputDecoration(
//                         labelText: "Confirm Password",
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     const SizedBox(height: 20),

//                     // Save Changes Button
//                     ElevatedButton(
//                       onPressed: () {
//                         // Check if the passwords match before dispatching the UpdatePassword event
//                         if (_passwordController.text.isEmpty || _confirmPasswordController.text.isEmpty) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text("Password fields cannot be empty!")),
//                           );
//                           return;
//                         }

//                         if (_passwordController.text != _confirmPasswordController.text) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text("Passwords do not match!")),
//                           );
//                           return;
//                         }

//                         if (_imageFile != null) {
//                           context.read<SettingsBloc>().add(UpdateProfilePicture(_imageFile!));
//                         }

//                         context.read<SettingsBloc>().add(UpdatePassword(_passwordController.text));
//                       },
//                       child: state is SettingsLoading
//                           ? const CircularProgressIndicator(color: Colors.white)
//                           : const Text("Save Changes"),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }