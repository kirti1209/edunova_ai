import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
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

  // Apple Sign-In
  Future<UserCredential?> signInWithApple() async {
    try {
      // Request credential for the currently signed in Apple account
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // Create an `OAuthCredential` from the credential returned by Apple
      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      // Sign in to Firebase with the Apple credential
      final userCredential =
          await _auth.signInWithCredential(oauthCredential);

      // Update display name if available
      if (appleCredential.givenName != null ||
          appleCredential.familyName != null) {
        await userCredential.user?.updateDisplayName(
          '${appleCredential.givenName ?? ''} ${appleCredential.familyName ?? ''}'.trim(),
        );
      }

      // Save to SharedPreferences
      await _saveLoginInfo(userCredential.user?.email ?? '', 'Apple');

      return userCredential;
    } catch (e) {
      throw Exception('Apple sign-in failed: $e');
    }
  }

  // Microsoft Sign-In (using OAuth provider)
  // Note: This requires setting up Microsoft OAuth in Firebase Console
  // Steps to configure:
  // 1. Go to Firebase Console > Authentication > Sign-in method
  // 2. Add Microsoft as a custom OAuth provider
  // 3. Configure Client ID and Client Secret from Azure AD
  Future<UserCredential?> signInWithMicrosoft() async {
    try {
      // Microsoft OAuth requires custom provider setup in Firebase Console
      // This is a placeholder - you need to configure Microsoft OAuth first
      // For a complete implementation, you would:
      // 1. Get authorization code from Microsoft OAuth
      // 2. Exchange it for tokens
      // 3. Use OAuthProvider('microsoft.com').credential() with the tokens
      
      throw UnimplementedError(
        'Microsoft sign-in requires OAuth configuration in Firebase Console.\n\n'
        'Steps to enable:\n'
        '1. Go to Firebase Console > Authentication > Sign-in method\n'
        '2. Add Microsoft as a custom OAuth provider\n'
        '3. Configure Client ID and Client Secret from Azure AD\n'
        '4. Update this method to use the OAuth flow',
      );
    } catch (e) {
      throw Exception('Microsoft sign-in failed: $e');
    }
  }

  // One Tap Login (Google One Tap)
  Future<UserCredential?> signInWithOneTap() async {
    try {
      // Google One Tap is essentially Google Sign-In with automatic selection
      // We'll use Google Sign-In with the oneTap option
      final GoogleSignInAccount? googleUser = await _googleSignIn.signInSilently();

      if (googleUser == null) {
        // If silent sign-in fails, try regular sign-in
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
