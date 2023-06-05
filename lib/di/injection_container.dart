
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:samplenumber/features/number_trivia/data/datasource/number_trivia_remote_data_source.dart';
import 'package:samplenumber/features/number_trivia/data/repository_impl/number_trivia_repository_impl.dart';
import 'package:samplenumber/features/number_trivia/domain/repository/number_trivia_repository.dart';
import 'package:samplenumber/features/number_trivia/domain/usecase/get_concrete_number_trivia_usecase.dart';
import 'package:samplenumber/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

final serviceLocator = GetIt.instance;

void init() {
  serviceLocator.registerLazySingleton<NumberTriviaBloc>(() => NumberTriviaBloc(
        serviceLocator(),
      ));
  serviceLocator.registerLazySingleton<NumberTriviaRepository>(
      () => NumberTriviaRepositoryImpl(remoteDataSource: serviceLocator()));

  serviceLocator.registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImpl(client: serviceLocator()));

  serviceLocator.registerLazySingleton(() => Client());

  serviceLocator.registerLazySingleton<GetConcreteNumberTriviaUsecase>(
      () => GetConcreteNumberTriviaUsecase(repository: serviceLocator()));


}
