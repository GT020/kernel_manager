class Battery {
  final String technology;
  final String health;
  final String totalCapacity;
  final String temperatureNode;
  final String currentNode;
  final String voltageNode;
  final String percentageNode;
  final String statusNode;

  Battery(
      this.technology,
      this.health,
      this.totalCapacity,
      this.temperatureNode,
      this.currentNode,
      this.voltageNode,
      this.percentageNode,
      this.statusNode);
}
