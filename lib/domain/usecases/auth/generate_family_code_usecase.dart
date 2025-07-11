import 'dart:math';

class GenerateFamilyCodeUsecase {
  String call() {
    final random = Random();
    final code = random.nextInt(900000) + 100000;
    return code.toString();
  }
}
