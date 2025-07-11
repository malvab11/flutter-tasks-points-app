import 'package:mission_up/domain/repositories/family_repository.dart';

class SaveFamilyCodeUsecase {
  final FamilyRepository _repository;

  SaveFamilyCodeUsecase(this._repository);

  Future<void> call({required String code, required String uidTutor}) async {
    await _repository.saveFamilyCode(code: code, uidTutor: uidTutor);
  }
}
