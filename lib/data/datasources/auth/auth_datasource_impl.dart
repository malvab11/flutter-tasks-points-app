import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mission_up/core/errors/AuthExceptions.dart';
import 'package:mission_up/data/datasources/auth/auth_datasource.dart';
import 'package:mission_up/data/models/user_model.dart';

class AuthDatasourceImpl extends AuthDatasource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> _generateInviteCode() async {
    const chars = '0123456789';
    final random = Random();
    String code;
    bool exists = true;
    int attemps = 0;

    // Genera hasta encontrar uno único
    do {
      code =
          List.generate(6, (_) => chars[random.nextInt(chars.length)]).join();
      final doc = await _firestore.collection('familys').doc(code).get();
      exists = doc.exists;
      attemps++;
      if (attemps >= 10) {
        throw AuthException(
          message: 'No se pudo generar el código de familia.',
        );
      }
    } while (exists);

    return code;
  }

  //Obtener la información del usuario actual logueado
  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw AuthException(message: 'No se encontró al usuario');
      }
      final data = await _firestore.collection('users').doc(user.uid).get();
      if (!data.exists) {
        throw AuthException(message: 'Usuario no encontrado');
      }
      return UserModel.fromJson(data.data()!, user.uid);
    } catch (e) {
      throw AuthException(message: 'Error al obtener el usuario: $e');
    }
  }

  //Cerrar Sesión
  @override
  Future<void> logOut() async {
    try {
      await GoogleSignIn().signOut();
      await _auth.signOut();
    } catch (e) {
      throw AuthException(message: 'Error al intentar cerrar sesión: $e');
    }
  }

  //Loguearse con codigo de invitación
  @override
  Future<UserModel> loginWithCode({
    required String user,
    required String familyCode,
  }) async {
    try {
      final userTrimmed = user.trim();
      final familyCodeTrimmed = familyCode.trim();

      final familiaDoc =
          await _firestore.collection('familys').doc(familyCodeTrimmed).get();
      if (!familiaDoc.exists) {
        throw AuthException(message: 'El código de familia no existe.');
      }

      final query =
          await _firestore
              .collection('users')
              .where('user', isEqualTo: userTrimmed)
              .where('familyCode', isEqualTo: familyCodeTrimmed)
              .limit(1)
              .get();
      if (query.docs.isNotEmpty) {
        final doc = query.docs.first;
        return UserModel.fromJson(doc.data(), doc.id);
      }

      final userCredential = await _auth.signInAnonymously();
      final uid = userCredential.user!.uid;

      final newUser = UserModel(
        id: uid,
        email: '',
        user: userTrimmed,
        rol: 'user',
        familyCode: familyCodeTrimmed,
      );

      await _firestore.collection('users').doc(uid).set(newUser.toJson());
      return newUser;
    } catch (e) {
      throw AuthException(message: 'Error al iniciar sesión con código: $e');
    }
  }

  //Loguearse con el correo
  @override
  Future<UserModel> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final data = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final doc =
          await _firestore.collection('users').doc(data.user!.uid).get();

      if (!doc.exists) {
        throw AuthException(message: 'El usuario no se encuentra registrado!!');
      }

      return UserModel.fromJson(doc.data()!, data.user!.uid);
    } catch (e) {
      throw AuthException(message: 'Error al iniciar sesión con correo : $e');
    }
  }

  //Loguearse con Google
  @override
  Future<UserModel?> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCred = await _auth.signInWithCredential(credentials);
      final user = userCred.user!;

      final doc = await _firestore.collection('users').doc(user.uid).get();

      if (doc.exists) {
        return UserModel.fromJson(doc.data()!, user.uid);
      } else {
        final userModel = UserModel(
          id: user.uid,
          email: user.email ?? '',
          user: user.displayName ?? '',
          rol: 'tutor',
          familyCode: await _generateInviteCode(),
        );

        await _firestore
            .collection('users')
            .doc(user.uid)
            .set(userModel.toJson());
        return userModel;
      }
    } catch (e) {
      throw AuthException(message: 'Error al iniciar sesión con Google: $e');
    }
  }

  //Registrarse con email
  @override
  Future<UserModel> registerWithEmail({
    required String email,
    required String user,
    required String password,
  }) async {
    try {
      final data = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = data.user!.uid;
      String? familyCode = await _generateInviteCode();

      await _firestore.collection('familys').doc(familyCode).set({
        'tutorId': uid,
        'tutorName': user,
        'createdAt': FieldValue.serverTimestamp(),
      });

      final userModel = UserModel(
        id: uid,
        email: email,
        rol: 'tutor',
        user: user,
        familyCode: familyCode,
      );

      await _firestore.collection('users').doc(uid).set(userModel.toJson());
      return userModel;
    } catch (e) {
      throw AuthException(message: 'Error al registrar al tutor: $e');
    }
  }
}
