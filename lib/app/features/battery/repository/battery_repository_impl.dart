import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'battery_repository.dart';

class BatteryRepositoryImpl extends BatteryRepository {
  // TODO add your methods here
}

final batteryRepositoryProvider = Provider<BatteryRepository>((ref) {
  return BatteryRepositoryImpl();
});
