class VinReaderModel{

  String vin;
  bool isBackup;

  VinReaderModel({required this.vin, this.isBackup=false});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VinReaderModel &&
          runtimeType == other.runtimeType &&
          vin == other.vin &&
          isBackup == other.isBackup;

  @override
  int get hashCode => vin.hashCode ^ isBackup.hashCode;
}