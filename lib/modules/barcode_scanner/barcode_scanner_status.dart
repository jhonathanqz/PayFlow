import 'package:camera/camera.dart';

class BarcodeScannerStatus {
  final bool isAvailable;
  final String error;
  final String barcode;
  final bool stopScanner;

  BarcodeScannerStatus({
    this.isAvailable = false,
    this.error = "",
    this.stopScanner = false,
    this.barcode = "",
  });

  factory BarcodeScannerStatus.available() {
    return BarcodeScannerStatus(isAvailable: true, stopScanner: false);
  }

  factory BarcodeScannerStatus.error(String message) {
    return BarcodeScannerStatus(error: message, stopScanner: true);
  }

  factory BarcodeScannerStatus.barcode(String barcode) {
    return BarcodeScannerStatus(barcode: barcode, stopScanner: true);
  }

  bool get showCamera => isAvailable && error.isEmpty;
  bool get hasError => error.isNotEmpty;
  bool get hasBarcode => barcode.isNotEmpty;

  BarcodeScannerStatus copyWith({
    bool? isAvailable,
    String? error,
    String? barcode,
    bool? stopScanner,
    CameraController? cameraController,
  }) {
    return BarcodeScannerStatus(
      isAvailable: isAvailable ?? this.isAvailable,
      error: error ?? this.error,
      barcode: barcode ?? this.barcode,
      stopScanner: stopScanner ?? this.stopScanner,
    );
  }
}
