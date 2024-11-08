// import 'package:google_sign_in/google_sign_in.dart';
//
// const List<String> scopes = <String>[
//   'email',
//   'https://www.googleapis.com/auth/contacts.readonly',
// ];
// class AuthService {
//
//
//   void googleSignIn() {
// // In mobile, being authenticated means being authorized...
//     bool isAuthorized = account != null;
// // However, on web...
//     if (kIsWeb && account != null) {
//       isAuthorized = await _googleSignIn.canAccessScopes(scopes);
//     }
//   GoogleSignIn _googleSignIn = GoogleSignIn(
//   // Optional clientId
//   // clientId: 'your-client_id.apps.googleusercontent.com',
//   scopes: scopes,
//   );
// }
//
// }