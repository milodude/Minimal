import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'core/provider/url_provider.dart';
import 'features/clients/data/data_source/client_data_source.dart';
import 'features/clients/data/repository/client_repository_impl.dart';
import 'features/clients/domain/repository/client_repository.dart'
    as client_domain;
import 'features/clients/domain/use_cases/add_client_use_case.dart';
import 'features/clients/domain/use_cases/get_clients_use_case.dart';
import 'features/clients/presentation/bloc/clients/client_bloc.dart';
import 'features/login/data/data_source/user_data_source.dart';
import 'features/login/data/repository/user_repository_impl.dart';
import 'features/login/domain/repository/user_repository.dart' as domain;
import 'features/login/domain/use_cases/user_login.dart';
import 'features/login/presentation/bloc/user/user_bloc.dart';

final GetIt sl = GetIt.instance;
//LazySingletons se crean cuando se requiere
//Singletons se crea una sola  instancia
//factory se crea cada vez  que se necesita una instancia
Future<void> init() async {
  //! Features
  // Bloc - No tienen que ser singletons por que estan muy cerca de la parte de la UI, por ejemplo puede abrir y volver a la
  // pagina anterior. Si llegamos a a hacer un dispose puede que hayamos eliminado ese singleton y va a traernos un error.
  sl.registerFactory(() => UserBloc(userLoginUseCase: sl()));
  sl.registerFactory(() => ClientBloc(getClientsUseCase: sl(), addClientUseCase: sl()));
  // sl.registerFactory(() => SingleClientBloc(addClientUseCase: sl()));


  //Al no mantener estados en el caso de uso, no es necesario tener una factoria
  //!Use Cases
  sl.registerLazySingleton<UserLogin>(() => UserLogin(userRepository: sl()));
  sl.registerLazySingleton<GetClientsUseCase>(
      () => GetClientsUseCase(clientRepository: sl()));
  sl.registerLazySingleton<AddClientUseCase>(
      () => AddClientUseCase(clientRepository: sl()));

  //!Repository
  sl.registerLazySingleton<domain.UserRepository>(
      () => UserRepositoryDataSourceImpl(userDataSource: sl()));
  sl.registerLazySingleton<client_domain.ClientRepository>(
      () => ClientRepositoryImpl(clientDataSource: sl()));

  //!Data Sources
  sl.registerLazySingleton<UserDataSource>(
      () => UserDataSource(httpClient: sl(), urlProvider: sl()));
  sl.registerLazySingleton<ClientDataSource>(
      () => ClientDataSource(httpClient: sl(), urlProvider: sl()));

  //! Core
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => UrlProvider());
  //! External
}
