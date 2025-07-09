import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:reede_ocr/home/widgets/custom_appbar.dart';
import 'package:reede_ocr/home/widgets/dev_info.dart';
import 'dart:io';

import 'package:reede_ocr/home/widgets/dialogs.dart';
import 'package:reede_ocr/home/widgets/extracted_text_view.dart';
import 'package:reede_ocr/home/widgets/image_source_selector.dart';

class OCRHomePage extends StatefulWidget {
  const OCRHomePage({super.key});

  @override
  OCRHomePageState createState() => OCRHomePageState();
}

class OCRHomePageState extends State<OCRHomePage> {
  File? _image;
  String _extractedText = '';
  bool _isProcessing = false;
  final ImagePicker _picker = ImagePicker();

  Future<void> _captureImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _image = File(image.path);
          _extractedText = '';
        });
        await _extractText();
      }
    } catch (e) {
      if (mounted) {
        showErrorDialog('Error al capturar imagen: $e', context);
      }
    }
  }

  Future<void> _pickFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _image = File(image.path);
          _extractedText = '';
        });
        await _extractText();
      }
    } catch (e) {
      if (mounted) {
        showErrorDialog('Error al capturar imagen: $e', context);
      }
    }
  }

  Future<void> _extractText() async {
    if (_image == null) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      final inputImage = InputImage.fromFile(_image!);
      final textRecognizer = TextRecognizer();
      final RecognizedText recognizedText = await textRecognizer.processImage(
        inputImage,
      );

      setState(() {
        _extractedText = recognizedText.text;
        _isProcessing = false;
      });

      textRecognizer.close();
    } catch (e) {
      setState(() {
        _isProcessing = false;
      });
      if (mounted) {
        showErrorDialog('Error al capturar imagen: $e', context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Icon(Icons.camera_alt, size: 48, color: Colors.teal),
                      SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () {
                          ImageSourceDialog.show(
                            context: context,
                            onCameraSelected: _captureImage,
                            onGallerySelected: _pickFromGallery,
                          );
                        },
                        icon: Icon(Icons.add_a_photo),
                        label: Text('Capturar/Seleccionar Imagen'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              if (_image != null)
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Imagen Capturada:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            _image!,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              SizedBox(height: 20),

              ExtractedTextView(
                isProcessing: _isProcessing,
                extractedText: _extractedText,
              ),

              SizedBox(height: 20),

              if (_image != null && !_isProcessing)
                ElevatedButton.icon(
                  onPressed: _extractText,
                  icon: Icon(Icons.refresh),
                  label: Text('Procesar Nuevamente'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const DeveloperInfoBottomBar(
        developerName: 'Kevin Féliz',
        email: 'kevinfeliz06@outlook.com',
        github: 'https://github.com/DevKevs',
        linkedin:
            'https://www.linkedin.com/in/kevin-féliz-encarnación-a20888200',
        portfolio: 'https://devkevs.netlify.app',
      ),
    );
  }
}
