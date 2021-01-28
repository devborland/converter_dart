import 'package:prompter_sg/prompter_sg.dart';
import 'dart:io';
import 'package:image/image.dart';

void main(List<String> args) {
  final prompter = Prompter();
  final choice = prompter.askBinary('Do you want convert a image?');

  if (!choice) {
    exit(0);
  }

  final format = prompter.askMultiple('Select format:', buildFormatOptions());
  final selectedFile =
      prompter.askMultiple('Select an image to convert', buildFileOptions());

  print(selectedFile);
  print(format);
}

List<Option> buildFormatOptions() {
  return [
    Option('Convert to jpeg', 'jpeg'),
    Option('Convert to png', 'png'),
  ];
}

List<Option> buildFileOptions() {
  return Directory.current.listSync().where((entity) {
    return FileSystemEntity.isFileSync(entity.path) &&
        entity.path.contains(RegExp(r'\.(png|jpg|jpeg)'));
  }).map((entity) {
    final fileName = entity.path.split(Platform.pathSeparator).last;
    return Option(fileName, entity);
  }).toList();
}
