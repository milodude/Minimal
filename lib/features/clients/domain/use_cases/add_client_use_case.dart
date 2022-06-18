import 'package:coda_test/features/clients/domain/repository/client_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

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

class ClientParams extends Equatable{
  final ClientData client;
  const ClientParams({
    required this.client,
  });
  
  @override
  List<Object?> get props => [client];
}
