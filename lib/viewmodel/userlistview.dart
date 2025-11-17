import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/usermodel.dart';
import 'package:flutter_application_1/service/userservice.dart';

class UserListViewModel extends ChangeNotifier {
  final UserService userService;

  UserListViewModel(this.userService);

  List<User> users = [];
  List<User> filtered = [];

  bool isLoading = false;

  String errorMessage = '';

  String searchQuery = '';

  Future<void> loadUsers() async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    try {
      users = await userService.fetchUsers();
      applyFilter();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void applyFilter() {
    if (searchQuery.isEmpty) {
      filtered = List.from(users);
    } else {
      final q = searchQuery.toLowerCase();
      filtered = users.where((user) {
        return user.fullName.toLowerCase().contains(q) ||
            user.email.toLowerCase().contains(q) ||
            user.city.toLowerCase().contains(q);
      }).toList();
    }
  }

  void updateSearch(String value) {
    searchQuery = value;
    applyFilter();
    notifyListeners();
  }
}
