class ProductInfo {
  final String name;
  final DateTime? manufactureDate;
  final DateTime? expiryDate;
  final String? batchNumber;
  final String? barcode;
  final String? additionalInfo;
  final String? extractedText;
  final String? imagePath;

  ProductInfo({
    required this.name,
    this.manufactureDate,
    this.expiryDate,
    this.batchNumber,
    this.barcode,
    this.additionalInfo,
    this.extractedText,
    this.imagePath,
  });

  // Add fromJson/toJson methods if needed
}