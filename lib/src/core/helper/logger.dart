import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(
    colors: true,
    // printEmojis: false,
    printTime: true,
  ),
);
