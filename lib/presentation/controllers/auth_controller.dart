import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/home/home_screen.dart';
import '../screens/login/login_screen.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  final Connectivity _connectivity = Connectivity();

  late final Future<void> _googleSignInInitialization =
      _googleSignIn.initialize();

  final isLoading = false.obs;
  final isOnline = true.obs;
  final isCheckingSession = true.obs;

  final userName = ''.obs;
  final userEmail = ''.obs;
  final userPhoto = ''.obs;
  final userPhone = ''.obs;

  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  @override
  void onInit() {
    super.onInit();
    unawaited(_loadCachedProfile());
    _listenConnectivity();
  }

  Future<void> _loadCachedProfile() async {
    final prefs = await SharedPreferences.getInstance();
    userName.value = prefs.getString('userName') ?? '';
    userEmail.value = prefs.getString('userEmail') ?? '';
    userPhoto.value = prefs.getString('userPhoto') ?? '';
    userPhone.value = prefs.getString('userPhone') ?? '';
  }

  Future<void> _saveProfile(User user) async {
    final prefs = await SharedPreferences.getInstance();

    final name = user.displayName;
    final email = user.email;
    final photo = user.photoURL;
    final phone = user.phoneNumber;

    if (name != null && name.isNotEmpty) {
      await prefs.setString('userName', name);
    }
    if (email != null && email.isNotEmpty) {
      await prefs.setString('userEmail', email);
    }
    if (photo != null && photo.isNotEmpty) {
      await prefs.setString('userPhoto', photo);
    }
    if (phone != null && phone.isNotEmpty) {
      await prefs.setString('userPhone', phone);
    }

    await _loadCachedProfile();
  }

  Future<void> checkCurrentUser() async {
    isCheckingSession.value = true;
    try {
      await _loadCachedProfile();
      final User? user = _auth.currentUser;

      if (user != null) {
        await _saveProfile(user);
        Get.offAll(() => const HomeScreen());
      } else {
        Get.offAll(() => const LoginScreen());
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Unable to check your login status.',
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.offAll(() => const LoginScreen());
    } finally {
      isCheckingSession.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;
      await _googleSignInInitialization;

      if (!_googleSignIn.supportsAuthenticate()) {
        throw Exception(
          'Interactive Google sign-in is not supported on this platform.',
        );
      }

      final GoogleSignInAccount googleUser =
          await _googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth =
          googleUser.authentication;

      final String? idToken = googleAuth.idToken;

      if (idToken == null || idToken.isEmpty) {
        throw Exception(
          'Google ID token missing. Check Firebase and Google configuration.',
        );
      }

      final OAuthCredential credential =
          GoogleAuthProvider.credential(idToken: idToken);

      final UserCredential result =
          await _auth.signInWithCredential(credential);

      final User? user = result.user;
      if (user == null) {
        throw Exception('Firebase user information was not returned.');
      }

      await _saveProfile(user);

      Get.offAll(() => const HomeScreen());
      Get.snackbar(
        'Success',
        'Google login successful!',
        snackPosition: SnackPosition.BOTTOM,
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Firebase login failed',
        e.message ?? e.code,
        snackPosition: SnackPosition.BOTTOM,
      );
    } on GoogleSignInException catch (e) {
      final errorText = e.toString().toLowerCase();
      final isCancelled = errorText.contains('cancel');

      Get.snackbar(
        isCancelled ? 'Login cancelled' : 'Google login failed',
        isCancelled
            ? 'Google sign-in was cancelled.'
            : 'Unable to sign in with Google. Check your configuration.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Login failed',
        'Please check your internet connection and Firebase setup.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void _listenConnectivity() {
    _connectivitySubscription = _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      final online = results.any((result) => result != ConnectivityResult.none);
      isOnline.value = online;
    });

    _connectivity.checkConnectivity().then((results) {
      final online = results.any((result) => result != ConnectivityResult.none);
      isOnline.value = online;
    }).catchError((Object _) {
      isOnline.value = false;
    });
  }

  Future<void> logout() async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;
      await _googleSignInInitialization;
      await _auth.signOut();
      await _googleSignIn.signOut();

      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('userName');
      await prefs.remove('userEmail');
      await prefs.remove('userPhoto');
      await prefs.remove('userPhone');

      userName.value = '';
      userEmail.value = '';
      userPhoto.value = '';
      userPhone.value = '';

      Get.offAll(() => const LoginScreen());
    } catch (e) {
      Get.snackbar(
        'Logout failed',
        'Unable to sign out. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void showLogoutDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: const Text('Confirm Logout'),
        content: const Text(
          'Are you sure you want to sign out and clear locally cached profile data?',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Get.back();
              logout();
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  @override
  void onClose() {
    _connectivitySubscription?.cancel();
    super.onClose();
  }
}
