import 'package:coda_test/features/clients/domain/repository/client_repository.dart';
import 'package:dartz/dartz.dart';

import 'package:coda_test/core/error/failure.dart';

import '../../../../core/use_cases/use_case.dart';

class DeleteClientUseCase implements UseCase<void, int> {
  ClientRepository clientRepository;

  DeleteClientUseCase({
    required this.clientRepository,
  });
  
  @override
  Future<Either<Failure, void>> call(int clientId) async{
   return await clientRepository.deleteClient(clientId);
  }
}
