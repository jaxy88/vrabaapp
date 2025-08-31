import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:app/api/api.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:image/image.dart' as img;
import '../socket/socket_io_client.dart';

class UploadFile {
  var api = Api();

  final SocketIoClient socketIoClient = SocketIoClient();

  Future<File> fixImageOrientation(File file) async {
    final bytes = await file.readAsBytes();
    final originalImage = img.decodeImage(bytes);

    final fixedImage = img.bakeOrientation(originalImage!);

    final fixedFile = File(file.path)
      ..writeAsBytesSync(img.encodeJpg(fixedImage));
    return fixedFile;
  }

  Future<void> pickFile(BuildContext context, orden) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
      ],
    );

    if (result != null) {
      var file = result.files.single.path;
      if (file != null) {
        File fileRf = File(file);
        //await uploadDocsManifiestosCarga(fileRf, context, orden);
      }
    }
  }

  void messageAlert(BuildContext context, String message) {
    showOkAlertDialog(
      context: context,
      title: "Notificación",
      message: message,
    );
  }
}
