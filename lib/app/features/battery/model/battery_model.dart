class BatteryModel {
  final String technology;
  final String health;
  final String totalCapacity;
  final String temperatureNode;
  final String currentNode;
  final String voltageNode;
  final String percentageNode;
  final String statusNode;
  final double currentMax;
  final double voltageMax;
  BatteryModel(
    this.technology,
    this.health,
    this.totalCapacity,
    this.temperatureNode,
    this.currentNode,
    this.voltageNode,
    this.percentageNode,
    this.statusNode, this.currentMax, this.voltageMax,
  );
}
