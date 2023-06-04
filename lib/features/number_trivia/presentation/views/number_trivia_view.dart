import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samplenumber/features/number_trivia/data/datasource/number_trivia_remote_data_source.dart';
import 'package:samplenumber/features/number_trivia/domain/repository/number_trivia_repository.dart';
import 'package:sizer/sizer.dart';

import '../../data/repository_impl/number_trivia_repository_impl.dart';
import '../bloc/number_trivia_bloc.dart';

class NumberTriviaView extends StatefulWidget {
  const NumberTriviaView({Key? key}) : super(key: key);

  @override
  State<NumberTriviaView> createState() => _NumberTriviaViewState();
}

class _NumberTriviaViewState extends State<NumberTriviaView> {
  final NumberTriviaRepository repository = NumberTriviaRepositoryImpl(
      remoteDataSource: NumberTriviaRemoteDataSourceImpl());

  String header = 'Starting search';
  TextEditingController controller = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<NumberTriviaBloc, NumberTriviaState>(
      listener: (context, state) {
        setState(() {
          if (state is NumberTriviaInitialState) {
            isLoading = false;
            header = 'Starting search';
          } else if (state is NumberTriviaLoadingState) {
            isLoading = true;
          } else if (state is NumberTriviaLoadedState) {
            isLoading = false;
            header = (state).numberTrivia.description;
          } else if (state is NumberTriviaErrorState) {
            isLoading = false;
            header = (state).message;
          }
        });
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text('Number trivia'),
        ),
        body: SingleChildScrollView(
          child:  Column(
            children: [
              Container(
                margin: EdgeInsetsDirectional.only(top: 10.h),
                child: getHeaderWidget(),
              ),
              Container(
                margin:
                EdgeInsetsDirectional.only(top: 10.h, start: 5.w, end: 5.w),
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(hintText: 'Input number'),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsetsDirectional.only(top: 5.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsetsDirectional.only(start: 5.w, end: 2.w),
                        child: TextButton(
                          onPressed: () {
                            context.read<NumberTriviaBloc>().add(GetConcreteNumberEvent(number: controller.text));
                          },
                          child: const Text('search'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsetsDirectional.only(start: 2.w, end: 5.w),
                        child: TextButton(
                          onPressed: () {},
                          child: const Text('Random Number'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )

      ),
    );
  }

  Widget getHeaderWidget() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Center(child: Text(header));
    }
  }
}
