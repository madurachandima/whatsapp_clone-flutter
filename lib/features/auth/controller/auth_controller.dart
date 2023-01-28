import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/features/auth/repository/auth_repository.dart';

import '../../../models/user_model.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository, ref: ref);
});

final userDataAuthProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getUserData();
});

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;

  AuthController({required this.authRepository, required this.ref});

  Future<UserModel?> getUserData() async {
    UserModel? user = await authRepository.getCurrentUserData();
    return user;
  }

  void signInWithPhone(BuildContext context, String phoneNumber) {
    authRepository.signInWithPhone(context, phoneNumber);
  }

  void verifyOTP(BuildContext context, String userOTP, String verificationId) {
    authRepository.verifyOTP(
        context: context, userOTP: userOTP, verificationId: verificationId);
  }

  void saveUserDataToFiresbase(
      BuildContext context, String name, File? profilePic) {
    authRepository.saveUserDataToFirestore(
        name: name, profilePic: profilePic, ref: ref, context: context);
  }

  Stream<UserModel> userDataById(String userID) {
    return authRepository.userData(userID);
  }
}
