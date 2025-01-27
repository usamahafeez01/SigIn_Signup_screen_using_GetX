import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SignupController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;
  final passwordStrength = ''.obs;

  @override
  void onInit() {
    super.onInit();
    passwordController.addListener(_checkPasswordStrength);
  }

  @override
  void onClose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    passwordController.removeListener(_checkPasswordStrength);
    super.onClose();
  }

  void _checkPasswordStrength() {
    final password = passwordController.text;
    if (password.isEmpty) {
      passwordStrength.value = '';
    } else if (password.length < 6) {
      passwordStrength.value = 'Weak';
    } else {
      passwordStrength.value = 'Strong';
    }
  }

  Future<void> signupWithEmail() async {
    if (formKey.currentState?.validate() ?? false) {
      isLoading.value = true;
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user?.uid)
            .set({
          'name': nameController.text.trim(),
          'email': emailController.text.trim(),
        });

        await userCredential.user?.sendEmailVerification();

        Get.snackbar(
          'Signup Successful',
          'Verification email sent to ${emailController.text.trim()}',
          snackPosition: SnackPosition.BOTTOM,
        );

        Get.offAllNamed('/login');
      } on FirebaseAuthException catch (e) {
        Get.snackbar('Error', e.message ?? 'Signup failed',
            snackPosition: SnackPosition.BOTTOM);
      } catch (e) {
        Get.snackbar('Error', 'An unexpected error occurred. Please try again.',
            snackPosition: SnackPosition.BOTTOM);
      } finally {
        isLoading.value = false;
      }
    }
  }

  Color getDotColor(int index) {
    if (passwordController.text.isEmpty) {
      return Colors.grey;
    } else if (passwordController.text.length < 6) {
      return index == 0 ? Colors.red : Colors.grey;
    } else if (passwordController.text.length < 8) {
      return index < 2 ? Colors.yellow : Colors.grey;
    } else {
      return Colors.green;
    }
  }
}
