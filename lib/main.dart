import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/userservice.dart';
import 'package:flutter_application_1/view/userlistscreen.dart';
import 'package:flutter_application_1/viewmodel/userlistview.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final userService = UserService();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserListViewModel(userService)..loadUsers(),
        ),
      ],
      child: MaterialApp(
        title: 'Users App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.indigo,
          scaffoldBackgroundColor: const Color(0xfff5f5f5),
        ),
        home: const UserListScreen(),
      ),
    );
  }
}
