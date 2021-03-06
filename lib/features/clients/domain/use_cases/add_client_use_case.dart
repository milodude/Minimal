import 'package:coda_test/features/clients/domain/repository/client_repository.dart';
import 'package:coda_test/features/clients/domain/use_cases/params/client_params.dart';
import 'package:dartz/dartz.dart';

import 'package:coda_test/core/error/failure.dart';
import 'package:coda_test/features/clients/domain/entities/client.dart';

import '../../../../core/use_cases/use_case.dart';

class AddClientUseCase implements UseCase<ClientData, ClientParams> {
  ClientRepository clientRepository;

  AddClientUseCase({
    required this.clientRepository,
  });

  @override
  Future<Either<Failure, ClientData>> call(ClientParams params) async {
    return await clientRepository.addClient(params.client);
  }

}

