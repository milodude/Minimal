import 'package:equatable/equatable.dart';

import '../../entities/client.dart';

class ClientParams extends Equatable{
  final ClientData client;
  const ClientParams({
    required this.client,
  });
  
  @override
  List<Object?> get props => [client];
}
