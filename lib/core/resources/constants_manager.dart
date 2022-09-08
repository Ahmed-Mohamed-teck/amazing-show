import 'dart:io';

import 'package:path_provider/path_provider.dart';

class AppConstants {
  static const int splashDelay = 2;


 /// Api Routes
 static const String baseUrl = 'https://api.tvmaze.com';
}
class LocalStorageKey {
  static const String app = 'store';
  static const String favouritesKey = 'favourites_key';
}
const appFolder = '';
class FileHelper {
  static Future<String> createAppFolder() async {
    if (appFolder.isEmpty) {
      return '';
    }
    final _appDocDir = await getApplicationDocumentsDirectory();
    final _appDocDirFolder = Directory('${_appDocDir.path}/$appFolder');

    if (await _appDocDirFolder.exists()) {
      //if folder already exists return path
      return _appDocDirFolder.path;
    } else {
      //if folder not exists create folder and then return its path
      final _appDocDirNewFolder =
      await _appDocDirFolder.create(recursive: true);
      return _appDocDirNewFolder.path;
    }
  }
}
