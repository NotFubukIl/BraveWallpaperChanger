import 'dart:io';
import 'dart:core';
import 'package:image/image.dart';
import 'package:path/path.dart' as path;
import 'dart:convert';

void main() async {
  final __dirname = path.dirname(Platform.script.toFilePath());
  if (!Directory("./images").existsSync()) {
    Directory("./images").createSync();
    Logs("Please Put Images in $__dirname\\images", true);
  }
  
  String bravePNGPath = resolvePaths("${Platform.environment['LOCALAPPDATA']}\\BraveSoftware\\Brave-Browser\\User Data\\aoojcmojmmcbpfgoecoadbdpnagfchel");
  if (bravePNGPath == "false") {
    Logs("Cannot Locate Brave's images path.", true);
  }
  
  if (!Directory("./oldbackgrounds").existsSync()) {
    Directory("./oldbackgrounds").createSync();
  }
  
  final directory = Directory(bravePNGPath);
  directory.listSync().whereType<File>().where((file) => file.path.endsWith('.jpg')).forEach((file) {
    final newPath = './oldbackgrounds/${file.path.split(Platform.pathSeparator).last}';
    file.renameSync(newPath);
  });
  
  var i = 1;
  String fil = File(bravePNGPath + "/photo.json").readAsStringSync();
  final photos = json.decode(fil);
  photos['images'] = [];
  
  final imageDirectory = Directory('./images');
  await for (final entity in imageDirectory.list()) {
    if (entity is File && (entity.path.endsWith('.jpg') || entity.path.endsWith('.png'))) {
      final newI = i++;
      final imagePath = entity.path;
      final braveImagePath = '$bravePNGPath\\not-fubuki-$newI.jpg';
      
      copyFile(imagePath, braveImagePath);
      
      photos['images'].add({
        'name': 'Bouki$newI',
        'source': 'not-fubuki-$newI.jpg',
        'focalPoint': [getFileDimension(imagePath)],
        'author': 'NotFubukii',
        'link': 'https://github.com/NotFubukil',
        'originalUrl': 'Github Link',
        'license': 'used with permission',
      });
    }
  }
  Logs("$i Backgrounds Changed !", false);
  
  String JSON = jsonEncode(photos);
  File(bravePNGPath + "/photo.json").writeAsStringSync(JSON);
  stdin.readLineSync(encoding: utf8);
}

void copyFile(String sourcePath, String destinationPath) {
  File sourceFile = File(sourcePath);
  File destinationFile = File(destinationPath);

  try {
    if (sourceFile.existsSync()) {
      List<int> contents = sourceFile.readAsBytesSync();
      destinationFile.writeAsBytesSync(contents);
    } else {
      Logs("File Not Found", true);
    }
  } catch (e) {
    Logs('Une erreur s\'est produite lors de la copie du fichier : $e', true);
  }
}

Map<String, int> getFileDimension(String path) {
  final imageFile = File(path);
  
  if (imageFile.existsSync()) {
    final bytes = imageFile.readAsBytesSync();
    final image = decodeImage(bytes);
    
    if (image != null) {
      final dimensions = {
        "x": image.width,
        "y": image.height
      };
      
      return dimensions;
    } else {
      print('Impossible de décoder l\'image.');
    }
  }

  return {};
}

void Logs(String msg, bool err) {
  const colors = {
    'Noir': '\x1B[0m',
    'Rouge': '\x1B[31m',
    'Vert': '\x1B[32m',
    'Jaune': '\x1B[33m',
    'Bleu': '\x1B[34m',
    'Magenta': '\x1B[35m',
    'Cyan': '\x1B[36m',
    'Blanc': '\x1B[37m',
  };

  if (err) {
    print('${colors['Rouge']}$msg${colors['Blanc']}');
    exit(0);
  } else {
    print('${colors['Vert']}$msg${colors['Blanc']}');
  }
} 

String resolvePaths(String part) {
  if (!Directory(part).existsSync()) return "false";
  final files = Directory(part).listSync();
  return '${files[0].path}';
}