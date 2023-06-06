import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samplenumber/core/error/failure.dart';
import 'package:samplenumber/features/number_trivia/domain/entity/number_trivia.dart';
import 'package:samplenumber/features/number_trivia/domain/usecase/get_concrete_number_trivia_usecase.dart';
import 'package:samplenumber/features/number_trivia/domain/usecase/get_random_number_trivia_usecase.dart';

import '../../../../core/util/input_converter.dart';
import '../../domain/repository/number_trivia_repository.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final NumberTriviaRepository repository;

  NumberTriviaBloc(this.repository) : super(NumberTriviaInitialState()) {
    on<GetConcreteNumberEvent>(
      (event, emit) async {
        try {
          final result = convertToInt(event.number);
          emit(NumberTriviaLoadingState());
         await result.fold(
            (number) async {
              final response =
                  await GetConcreteNumberTriviaUsecase(repository: repository)
                      .call(ConcreteNumberTriviaParam(number));
              if (response.isLeft) {
                emit(NumberTriviaLoadedState(numberTrivia: response.left));
              } else {
                if (response.right is ServerFailure) {
                  emit(NumberTriviaErrorState(
                      message: (response.right as ServerFailure).message));
                } else if (response.right is CacheFailure) {
                  emit(NumberTriviaErrorState(
                      message: (response.right as CacheFailure).message));
                }
              }
            },
            (failure) async => emit(
              NumberTriviaErrorState(message: failure.message),
            ),
          );
        } on Exception {
          emit(NumberTriviaErrorState(message: 'input invalid format'));
        }
      },
    );
    on<GetRandomNumberEvent>(
      (event, emit) async {
        try {
          emit(NumberTriviaLoadingState());
          final response =
              await GetRandomNumberTriviaUsecase(repository: repository).call(
            NoParams(),
          );
          if (response.isLeft) {
            emit(NumberTriviaLoadedState(numberTrivia: response.left));
          } else {
            if (response.right is ServerFailure) {
              emit(NumberTriviaErrorState(
                  message: (response.right as ServerFailure).message));
            } else if (response.right is CacheFailure) {
              emit(NumberTriviaErrorState(
                  message: (response.right as CacheFailure).message));
            }
          }
        } on Exception {
          emit(NumberTriviaErrorState(message: 'input invalid format'));
        }
      },
    );
  }
}
