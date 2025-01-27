import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signIn(String email, String password) async {
    isLoading(true);
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User? user = userCredential.user;
      if (user != null && user.emailVerified) {
        Get.snackbar('Success', 'Sign-in successful!');
        Get.offAllNamed('/profilePage');
      } else {
        _showVerifyEmailDialog();
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'An error occurred');
    } finally {
      isLoading(false);
    }
  }

  void _showVerifyEmailDialog() {
    bool isResendEnabled = true;

    Get.defaultDialog(
      title: 'Verify Your Email',
      titleStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      middleText: 'Please check your email to verify your account.',
      middleTextStyle: TextStyle(color: Colors.white70),
      backgroundColor: Colors.black87,
      actions: [
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [const Color(0xFFa343c9), const Color(0xFFc25457)],
          ).createShader(bounds),
          child: TextButton(
            onPressed: isResendEnabled
                ? () async {
                    isResendEnabled = false;
                    User? user = _auth.currentUser;
                    await user?.sendEmailVerification();
                    Get.snackbar(
                        'Verification Email', 'Verification email resent');

                    // Start cooldown timer
                    Future.delayed(const Duration(seconds: 60), () {
                      isResendEnabled = true;
                    });
                  }
                : null,
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.transparent,
              disabledForegroundColor: Colors.grey.withOpacity(0.38),
              textStyle: TextStyle(fontSize: 16),
            ),
            child:
                isResendEnabled ? Text('Resend Email') : Text('Retry in 60s'),
          ),
        ),
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [const Color(0xFFa343c9), const Color(0xFFc25457)],
          ).createShader(bounds),
          child: TextButton(
            onPressed: () {
              Get.back();
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.transparent,
              textStyle: TextStyle(fontSize: 16),
            ),
            child: Text('Close'),
          ),
        ),
      ],
    );
  }

  // Sign in with Google
  Future<void> signInWithGoogle() async {
    isLoading(true);
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await _auth.signInWithCredential(credential);
        Get.snackbar('Success', 'Google Sign-in successful!');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
