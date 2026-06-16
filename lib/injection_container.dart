import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:swim_test/features/pace_selector/data/datasources/pace_remote_data_source.dart';
import 'package:swim_test/features/pace_selector/data/repositories/pace_repository_impl.dart';
import 'package:swim_test/features/pace_selector/domain/repositories/pace_repository.dart';
import 'package:swim_test/features/pace_selector/domain/usecases/submit_pace_usecase.dart';
import 'package:swim_test/features/pace_selector/presentation/cubit/pace_cubit.dart';
import 'package:swim_test/features/users/data/datasources/users_remote_data_source.dart';
import 'package:swim_test/features/users/data/repositories/users_repository_impl.dart';
import 'package:swim_test/features/users/domain/repositories/users_repository.dart';
import 'package:swim_test/features/users/domain/usecases/get_users_usecase.dart';
import 'package:swim_test/features/users/presentation/cubit/users_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => PaceCubit(sl()));
  sl.registerLazySingleton(() => SubmitPaceUseCase(sl()));
  sl.registerLazySingleton<PaceRepository>(
    () => PaceRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<PaceRemoteDataSource>(
    () => PaceRemoteDataSourceImpl(client: sl()),
  );

  sl.registerFactory(() => UsersCubit(sl()));
  sl.registerLazySingleton(() => GetUsersUseCase(sl()));
  sl.registerLazySingleton<UsersRepository>(
    () => UsersRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<UsersRemoteDataSource>(
    () => UsersRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton(() => http.Client());
}
