abstract class RamProvider {
  Future<double> getTotalCapacity();
  Future<String> getUsedRamNode();
  Future<String> getZramNode();
}
