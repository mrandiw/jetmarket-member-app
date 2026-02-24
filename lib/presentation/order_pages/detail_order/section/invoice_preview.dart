import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class InvoicePreview extends StatelessWidget {
  static const route = '/invoice';

  final File file;

  const InvoicePreview({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice', style: text16BlackSemiBold),
        actions: [
          IconButton(
            onPressed: () async {
              Share.shareXFiles([XFile(file.path)]);
            },
            icon: const Icon(
              Icons.share,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: SfPdfViewer.file(file),
    );
  }
}
