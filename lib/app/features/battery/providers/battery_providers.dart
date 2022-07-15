abstract class BatteryProviders {
  Future<String> getTechnology();
  Future<String> getHealth();
  Future<String> getTotalCapacity();
  Future<String> getTemperatureNode();
  Future<String> getCurrentNode();
  Future<String> getVoltageNode();
  Future<String> getPercentageNode();
  Future<String> getStatusNode();
}
