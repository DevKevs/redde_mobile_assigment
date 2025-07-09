import 'package:flutter/material.dart';

class ExtractedTextView extends StatelessWidget {
  const ExtractedTextView({
    super.key,
    required bool isProcessing,
    required String extractedText,
  }) : _isProcessing = isProcessing,
       _extractedText = extractedText;

  final bool _isProcessing;
  final String _extractedText;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.text_fields, color: Colors.teal),
                SizedBox(width: 8),
                Text(
                  'Texto Extraído:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            if (_isProcessing)
              Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text('Procesando imagen...'),
                  ],
                ),
              )
            else if (_extractedText.isNotEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: SelectableText(
                  _extractedText,
                  style: TextStyle(fontSize: 16),
                ),
              )
            else
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Text(
                  'No se ha extraído texto aún. Captura una imagen para comenzar.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
