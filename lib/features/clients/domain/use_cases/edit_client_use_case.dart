import 'package:coda_test/features/clients/domain/repository/client_repository.dart';
import 'package:coda_test/features/clients/domain/use_cases/params/client_params.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_cases/use_case.dart';
import '../entities/client.dart';

class EditClientUseCase implements UseCase<ClientData, ClientParams> {
  ClientRepository clientRepository;

  EditClientUseCase({
    required this.clientRepository,
  });

  @override
  Future<Either<Failure, ClientData>> call(ClientParams params) async {
    return await clientRepository.editClient(params.client);
  }

}

