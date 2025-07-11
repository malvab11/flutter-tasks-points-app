import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mission_up/domain/repositories/family_repository.dart';

class FamilyRepositoryImpl extends FamilyRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> saveFamilyCode({
    required String code,
    required String uidTutor,
  }) async {
    await _firestore.collection('familys').doc(code).set({
      'uidTutor': uidTutor,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
