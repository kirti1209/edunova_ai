import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _userEmailKey = 'user_email';
  static const String _loginMethodKey = 'login_method';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Auth state stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    return _auth.currentUser != null;
  }

  // Get user email
  Future<String?> getUserEmail() async {
    if (_auth.currentUser != null) {
      return _auth.currentUser!.email;
    }
    // Fallback to SharedPreferences
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_userEmailKey);
    } catch (e) {
      return null;
    }
  }

  // Google Sign-In
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User canceled the sign-in
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final userCredential = await _auth.signInWithCredential(credential);

      // Save to SharedPreferences
      await _saveLoginInfo(userCredential.user?.email ?? '', 'Google');

      return userCredential;
    } catch (e) {
      throw Exception('Google sign-in failed: $e');
    }
  }

  // Apple Sign-In disabled
  Future<UserCredential?> signInWithApple() async {
    throw UnimplementedError(
      'Apple sign-in is disabled. Please try another login method.',
    );
  }

  
  Future<UserCredential?> signInWithMicrosoft() async {
    try {
      
      throw UnimplementedError(
        'error login with microsoft, try another method ',
      );
    } catch (e) {
      throw Exception('Microsoft sign-in failed: $e');
    }
  }

  // One Tap Login (Google One Tap)
  Future<UserCredential?> signInWithOneTap() async {
    try {
      
      final GoogleSignInAccount? googleUser = await _googleSignIn.signInSilently();

      if (googleUser == null) {
        
        return await signInWithGoogle();
      }

      // Obtain the auth details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      final userCredential = await _auth.signInWithCredential(credential);

      // Save to SharedPreferences
      await _saveLoginInfo(userCredential.user?.email ?? '', 'OneTap');

      return userCredential;
    } catch (e) {
      // If silent sign-in fails, fall back to regular Google sign-in
      return await signInWithGoogle();
    }
  }

  // Save login info to SharedPreferences
  Future<void> _saveLoginInfo(String email, String method) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_isLoggedInKey, true);
      await prefs.setString(_userEmailKey, email);
      await prefs.setString(_loginMethodKey, method);
    } catch (e) {
      // Ignore errors
    }
  }

  // Logout
  Future<bool> logout() async {
    try {
      // Sign out from Google
      await _googleSignIn.signOut();
      
      // Sign out from Firebase
      await _auth.signOut();

      // Clear SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_isLoggedInKey, false);
      await prefs.remove(_userEmailKey);
      await prefs.remove(_loginMethodKey);

      return true;
    } catch (e) {
      return false;
    }
  }

  // Delete account
  Future<bool> deleteAccount() async {
    try {
      final user = _auth.currentUser;
      
      if (user != null) {
        // Delete from Firebase Auth
        await user.delete();
      }

      // Sign out from Google
      await _googleSignIn.signOut();

      // Clear SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      return true;
    } catch (e) {
      return false;
    }
  }
}
