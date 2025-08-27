import 'dart:developer';

/// print full log
class Logger {
  factory Logger() => _instance;
  // Private constructor
  Logger._privateConstructor();

  // Single instance
  static final Logger _instance = Logger._privateConstructor();
  // Sample of abstract logging function
  static void print(String text, {bool isError = false}) {
    log('** $text, isError [$isError]');
  }
}
