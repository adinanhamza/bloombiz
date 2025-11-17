import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/usermodel.dart';
import 'package:flutter_application_1/service/userservice.dart';

class UserDetailViewModel extends ChangeNotifier {
  final UserService _userService;
  final int userId;

  UserDetailViewModel(this._userService, this.userId);

  User? user;

  bool isLoading = false;

  String errorMessage = '';

  Future<void> loadUser() async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    try {
      user = await _userService.fetchUserById(userId);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
