import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product_text_extractor/product_text_extractor.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

class TextExtractorService {
  final ImagePicker _picker = ImagePicker();
  final _logger = Logger('TextExtractorService');

  Future<String?> extractTextFromImage(String imagePath) async {
    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFilePath(imagePath);
    final TextRecognizer textRecognizer =
        FirebaseVision.instance.textRecognizer();
    final VisionText visionText =
        await textRecognizer.processImage(visionImage);

    await textRecognizer.close();
    return visionText.text;
  }

  Future<ProductInfo?> extractProductInfo() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image == null) return null;

      final String? extractedText = await extractTextFromImage(image.path);
      if (extractedText == null) return null;

      return _parseProductInfo(extractedText, image.path);
    } catch (e) {
      _logger.severe('Error extracting product info', e);
      return null;
    }
  }

  ProductInfo _parseProductInfo(String text, String imagePath) {
    // Implement your parsing logic here
    // This is a simplified version - you'll need more sophisticated parsing
    
    String name = '';
    DateTime? manufactureDate;
    DateTime? expiryDate;
    
    // Example simple parsing (you'll need to improve this)
    final lines = text.split('\n');
    if (lines.isNotEmpty) {
      name = lines[0]; // First line as product name
    }
    
    // Look for dates in the text
    final datePattern = RegExp(r'(\d{2}[\/\-\.]\d{2}[\/\-\.]\d{2,4})');
    final dates = datePattern.allMatches(text).toList();
    
    if (lines.isNotEmpty) {
      manufactureDate = _parseDate(dates[0].group(0));
    }
    if (dates.length >= 2) {
      expiryDate = _parseDate(dates[1].group(0));
    }
    
    return ProductInfo(
      name: name,
      manufactureDate: manufactureDate,
      expiryDate: expiryDate,
      extractedText: text,
      imagePath: imagePath,
    );
  }
  
  DateTime? _parseDate(String? dateString) {
    if (dateString == null) return null;
    try {
      // Handle different date formats
      final formats = ['dd/MM/yyyy', 'dd-MM-yyyy', 'dd.MM.yyyy', 'MM/dd/yyyy'];
      for (var format in formats) {
        try {
          return DateFormat(format).parse(dateString);
        } catch (_) {}
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}