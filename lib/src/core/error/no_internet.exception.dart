class NoInternetConnectionException implements Exception {
  final String message =
      "No internet connection detected.\nplease reconnect and try again";

  @override
  String toString() => message;
}
