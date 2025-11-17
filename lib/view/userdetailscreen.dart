import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/userservice.dart';
import 'package:flutter_application_1/viewmodel/userdetailview.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/view/widgets/infowidget.dart';


class UserDetailScreen extends StatelessWidget {
  final int userId;

  const UserDetailScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          UserDetailViewModel(UserService(), userId)..loadUser(),
      child: const _UserDetailBody(),
    );
  }
}

class _UserDetailBody extends StatelessWidget {
  const _UserDetailBody();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<UserDetailViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        centerTitle: true,
      ),
      body: Builder(
        builder: (_) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.errorMessage.isNotEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline, size: 40, color: Colors.red),
                    const SizedBox(height: 12),
                    const Text(
                      'Failed to load user',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      vm.errorMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: vm.loadUser,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          final user = vm.user;
          if (user == null) {
            return const Center(child: Text('User not found'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(user.image),
                ),
                const SizedBox(height: 16),
                Text(
                  user.fullName,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Chip(label: Text(user.gender.toUpperCase())),
                const SizedBox(height: 16),

                InfoCard(
                  title: 'Contact',
                  rows: [
                    InfoRow(label: 'Email', value: user.email),
                    InfoRow(label: 'Phone', value: user.phone),
                  ],
                ),
                InfoCard(
                  title: 'Personal',
                  rows: [
                    InfoRow(label: 'Age', value: '${user.age}'),
                    InfoRow(label: 'Birth Date', value: user.birthDate),
                  ],
                ),
                InfoCard(
                  title: 'Address',
                  rows: [
                    InfoRow(label: 'City', value: user.city),
                    InfoRow(label: 'Address', value: user.address),
                  ],
                ),
                InfoCard(
                  title: 'Company',
                  rows: [
                    InfoRow(label: 'Company', value: user.companyName),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
