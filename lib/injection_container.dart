import 'package:coda_test/features/login/data/data_source/user_data_source.dart';
import 'package:coda_test/features/login/data/repository/user_repository_impl.dart';
import 'package:coda_test/features/login/presentation/bloc/user/user_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'core/provider/url_provider.dart';
import 'features/login/domain/use_cases/user_login.dart';
import 'features/login/domain/repository/user_repository.dart' as domain;

final GetIt sl = GetIt.instance;
//LazySingletons se crean cuando se requiere
//Singletons se crea una sola  instancia
//factory se crea cada vez  que se necesita una instancia
Future<void> init() async{
  //! Features
  // Bloc - No tienen que ser singletons por que estan muy cerca de la parte de la UI, por ejemplo puede abrir y volver a la
  // pagina anterior. Si llegamos a a hacer un dispose puede que hayamos eliminado ese singleton y va a traernos un error.
    sl.registerFactory(() => UserBloc(userLoginUseCase: sl()));
  //Al no mantener estados en el caso de uso, no es necesario tener una factoria
    sl.registerSingleton(() => UserLogin(userRepository: sl()));
    
  //Repository
  sl.registerLazySingleton<domain.UserRepository>(()=> UserRepositoryImpl(userDataSource: sl()));
  sl.registerLazySingleton<UserDataSource>(() => UserDataSource(httpClient: sl(), urlProvider: sl()));
  sl.registerLazySingleton<UserLogin>(()=>UserLogin(userRepository: sl()));
  //
  //! Core
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => UrlProvider());
  //! External

}
