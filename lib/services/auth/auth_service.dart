import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;// אימות משתמש

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;// מסד נתונים(צאט)

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<UserCredential> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password
      );

      _firebaseFirestore.collection('Users').doc(userCredential.user!.uid).set(
        {
        'uid': userCredential.user!.uid,
        email: email,
        },
        SetOptions(merge: true),
      );

      return userCredential;
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }

  // פונקציה להרשמה עם דוא"ל וסיסמה
  Future<UserCredential> signUpWithEmailPassword(String email, password) async {
    try {
      // יצירת משתמש חדש עם דוא"ל וסיסמה
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // שמירת פרטי המשתמש במסמך נפרד במסד הנתונים
      try {
        await _firebaseFirestore.collection('Users').doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'email': email,
        });
      } catch (e) {
        print('Error writing to Firestore: $e');
      }

      // החזרת אישור המשתמש
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // במקרה של שגיאת הרשמה, זריקת חריגה עם קוד השגיאה
      throw Exception(e.code);
    }
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  String getErrorMessage(String errocode) {
    switch (errocode) {
      case 'Exception: wrong-password':
        return 'סיסמא שגויה. אנא נסה שוב';
      case 'Exception: user-not-found':
        return 'לא נמצא משתמש עם הדוא״ל הזה. אנא הירשם';
      case 'Exception: invalid-email':
        return 'הדוא״ל אינו קיים';

        default: 
          return 'הייתה שגיאה';
    }
  }

}