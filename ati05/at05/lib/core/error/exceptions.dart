class ServerException implements Exception {
  final String message;

  ServerException([this.message = 'Erro ao obter dados do servidor']);

  @override
  String toString() => 'ServerException: $message';
}
