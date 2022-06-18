import 'package:coda_test/features/clients/domain/entities/client.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class ClientRepository{
    Future<Either<Failure, List<ClientData>>> getClientList();    
}