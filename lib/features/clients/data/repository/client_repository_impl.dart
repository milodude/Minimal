
import 'package:coda_test/features/clients/data/data_source/client_data_source.dart';
import 'package:dartz/dartz.dart';

import 'package:coda_test/features/clients/domain/entities/client.dart';

import 'package:coda_test/core/error/failure.dart';

import '../../domain/repository/client_repository.dart' as domain;

class ClientRepositoryImpl extends domain.ClientRepository{
  final ClientDataSource clientDataSource;

  ClientRepositoryImpl({required this.clientDataSource});
  
  @override
  Future<Either<Failure, List<ClientData>>> getClientList() async {
     try {
      var result = await clientDataSource.getClients();
      return Right(result);
    } on ServerFailure catch(e){
     return Left(ServerFailure('Server error while sending the request: $e'));
    }catch(e){
     return Left(ServerFailure('Server error while sending the request'));
    }
  }
  
  @override
  Future<Either<Failure, ClientData>> addClient(ClientData clientData) {
    throw UnimplementedError();
  }

}