// ignore_for_file: file_names, unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';

class UserDocumentHelper{
 
  FilePickerResult? filePickerResult;
  String ?base64Image;
   File ?uploadedFile;
  Future<void> uploadFile() async {
   
    filePickerResult = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg'],
    );
    if (filePickerResult == null) {
      print("No file selected");
      
    } else {
      uploadedFile = File(filePickerResult!.files.single.path!);
      List<int> imageBytes =uploadedFile!.readAsBytesSync();
      print(imageBytes);
      base64Image = "data:image/${uploadedFile!.path.split('.').last};base64,"+base64Encode(imageBytes);
      print(base64Image);
    }
  }

  void endUploadFile() {
    filePickerResult = null;
    base64Image=null;
    uploadedFile=null;
  }
}