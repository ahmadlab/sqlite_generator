

library sqlite_generator;
import 'dart:io';
import './databaseServiceTemplate.dart';
import './databaseModelsTemplate.dart';

/// A Calculator.
class Main {}

void sqliteGenerator(List<String>? argumentsValue) {
  if (argumentsValue!.isEmpty) {
    printError("Please provide '--database-name' argument");
    return;
  } else {
    int checkDatbaseName = argumentsValue
        .indexWhere((element) => element.contains("database-name="));
    if (checkDatbaseName == -1) {
      printError("Please provide '--database-name' argument");
      return;
    } else {
    String databaseName = argumentsValue[checkDatbaseName].replaceAll('--database-name=', '');

    /* generate models */
    String modelsTemplate = databaseModelsTemplate;
    File file = File('lib/databases/DatabaseModels.dart');
    file.createSync(recursive: true);
    file.writeAsStringSync(modelsTemplate);
    printWarning("File ./lib/databases/DatabaseModels.dart created");
    /* generate services */
    String serviceTemplate = databaseServiceTemplate.replaceAll('DATABASE_NAME', databaseName);;
    File fileService = File('lib/databases/DatabaseService.dart');
    fileService.createSync(recursive: true);
    fileService.writeAsStringSync(serviceTemplate);
    printWarning("File ./lib/databases/DatabaseService.dart created");
    printSuccess("\\(*_*)/ Database template of '$databaseName' generated successfully!");
    }
  }
}

void printWarning(String text) {
  print('\x1B[33m$text\x1B[0m');
}

void printError(String text) {
  print('\x1B[31m$text\x1B[0m');
}

void printSuccess(String text) {
  print('\x1B[32m$text\x1B[0m');
}
