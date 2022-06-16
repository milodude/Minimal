import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_cases/use_case.dart';
import '../entities/client.dart';
import '../repository/client_repository.dart';

class GetClients implements UseCase<List<ClientData>, NoParams>{
  final ClientRepository clientRepository;

  GetClients({required this.clientRepository});
  
  @override
  Future<Either<Failure, List<ClientData>>> call(NoParams params) async {
    return await clientRepository.getClientList();
  }
}

