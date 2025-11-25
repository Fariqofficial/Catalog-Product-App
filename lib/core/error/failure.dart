import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure({required this.message});

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message});
}

class ConnectionFailure extends Failure {
  const ConnectionFailure({required super.message});
}

class TimeOutFailure extends Failure {
  const TimeOutFailure({required super.message});
}

class CachedFailure extends Failure {
  const CachedFailure({required super.message});
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({required super.message});
}

class BadRequestFailure extends Failure {
  const BadRequestFailure({required super.message});
}
