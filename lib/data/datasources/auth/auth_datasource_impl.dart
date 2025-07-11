import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

    // Genera hasta encontrar uno único
    do {
      code =
          List.generate(6, (_) => chars[random.nextInt(chars.length)]).join();
      final doc = await _firestore.collection('familys').doc(code).get();
      exists = doc.exists;
    } while (exists);

    return code;
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final id = await _firestore.collection('users').doc(user.uid).get();
    if (!id.exists) return null;

    return UserModel.fromJson(id.data()!, user.uid);
  }

  @override
  Future<void> logOut() async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
  }

  @override
  Future<UserModel> loginWithCode({
    required String user,
    required String code,
  }) async {
    final userTrimmed = user.trim();
    final codeTrimmed = code.trim();

    // 1. Verificar que el código de familia exista
    final familiaDoc =
        await _firestore.collection('familys').doc(codeTrimmed).get();
    if (!familiaDoc.exists) {
      throw Exception('El código de familia no existe');
    }

    // 2. Buscar si ya existe ese alumno con ese nombre y código
    final query =
        await _firestore
            .collection('users')
            .where('user', isEqualTo: userTrimmed)
            .where('codigoFamilia', isEqualTo: codeTrimmed)
            .limit(1)
            .get();

    if (query.docs.isNotEmpty) {
      final doc = query.docs.first;
      return UserModel.fromJson(doc.data(), doc.id);
    }

    // 3. Autenticar al alumno de forma anónima
    final userCredential = await FirebaseAuth.instance.signInAnonymously();
    final uid = userCredential.user!.uid;

    // 4. Crear usuario en Firestore
    final newUser = UserModel(
      uid: uid,
      email: '',
      user: userTrimmed,
      rol: 'user',
      photoUrl: null,
      codigoFamilia: codeTrimmed,
    );

    await _firestore.collection('users').doc(uid).set(newUser.toJson());

    return newUser;
  }

  @override
  Future<UserModel> loginWithEmail({
    required String email,
    required String password,
  }) async {
    final data = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final id = await _firestore.collection('users').doc(data.user!.uid).get();

    if (!id.exists) throw Exception('El usuario no se encuentra registrado!!');

    return UserModel.fromJson(id.data()!, data.user!.uid);
  }

  @override
  Future<UserModel?> loginWithGoogle({required String rol}) async {
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
    final id = await _firestore.collection('users').doc(user.uid).get();

    if (id.exists) {
      return UserModel.fromJson(id.data()!, user.uid);
    } else {
      final userModel = UserModel(
        uid: user.uid,
        email: user.email ?? '',
        user: user.displayName,
        photoUrl: user.photoURL,
        rol: rol,
      );

      await _firestore
          .collection('users')
          .doc(user.uid)
          .set(userModel.toJson());
      return userModel;
    }
  }

  @override
  Future<UserModel> registerWithEmail({
    required String email,
    required String user,
    required String password,
    required String rol,
  }) async {
    final data = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = data.user!.uid;
    String? codigoFamilia;

    // Si el rol es tutor, generar código de invitación único y crear familia
    if (rol == 'tutor') {
      codigoFamilia = await _generateInviteCode();

      await _firestore.collection('familys').doc(codigoFamilia).set({
        'tutorId': uid,
        'tutorName': user,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

    final userModel = UserModel(
      uid: uid,
      email: email,
      rol: rol,
      user: user,
      photoUrl: null,
      codigoFamilia: codigoFamilia,
    );

    await _firestore.collection('users').doc(uid).set(userModel.toJson());
    return userModel;
  }
}
