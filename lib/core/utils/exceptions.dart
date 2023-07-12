
class ServerException implements Exception {
  final String message ;
  const ServerException({required this.message});
}
class OfflineException implements Exception {}
class UnknownError implements Exception {}
