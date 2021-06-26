

class BarcodeScannerStatus {
  final bool isCameraAvailable;
  final String error;
  final String barcode;
  final bool stopScanner;

  BarcodeScannerStatus({
    this.isCameraAvailable = false,
    this.error = "",
    this.stopScanner = false,
    this.barcode = "",
  });

  factory BarcodeScannerStatus.available() =>
      BarcodeScannerStatus(isCameraAvailable: true, stopScanner: false);

  factory BarcodeScannerStatus.error(String message) => BarcodeScannerStatus(
        error: message,
        stopScanner: true,
      );

  factory BarcodeScannerStatus.barcode(String barcode) => BarcodeScannerStatus(
        barcode: barcode,
        stopScanner: true,
      );

  bool get showCamera => isCameraAvailable && error.isEmpty;

  bool get hasError => error.isNotEmpty;

  bool get hasBarcode => barcode.isNotEmpty;

 // BarcodeScannerStatus copyWith({
 //   bool? isAvailable,
 //   String? error,
 //   String? barcode,
 //   bool? stopScanner,
 //   CameraController? cameraController,
 // }) {
 //   return BarcodeScannerStatus(
 //     isCameraAvailable: isAvailable ?? this.isCameraAvailable,
 //     error: error ?? this.error,
 //     barcode: barcode ?? this.barcode,
 //     stopScanner: stopScanner ?? this.stopScanner,
 //   );
 // }
}
