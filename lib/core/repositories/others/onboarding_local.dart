import 'package:hive/hive.dart';

class OnboardingRepository {
  final _boxKey = 'intro';
  final _dataKey = 'isIntroDone';

  Future<OnboardingRepository> init() async {
    await Hive.openBox(_boxKey);
    return this;
  }

  bool isIntroDone() {
    var box = Hive.box(_boxKey);
    return box.get(_dataKey) ?? false;
  }

  void saveIntroDone() {
    var box = Hive.box(_boxKey);
    box.put(_dataKey, true);
  }
}
