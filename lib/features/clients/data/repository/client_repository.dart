
import 'package:dartz/dartz.dart';

import 'package:coda_test/features/clients/domain/entities/client.dart';

import 'package:coda_test/core/error/failure.dart';

import '../../domain/repository/client_repository.dart';

class ClientRepositoryImpl extends ClientRepository{
  
  @override
  Future<Either<Failure, List<ClientData>>> getClientList() {
    throw UnimplementedError();
  }

}