import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app2/router_config.dart';
import 'package:app2/data/repositories/register_repository.dart';
import 'package:app2/data/services/register_services.dart';
import 'package:app2/data/repositories/statistics_repository.dart';
import 'package:app2/data/services/statistics_services.dart';
import 'package:app2/Register_bloc/register_bloc.dart';
import 'package:app2/home/home_bloc.dart';
import 'package:app2/statistics_bloc/statistics_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => RegisterRepository(
            registerService: RegisterService(),
          ),
        ),
        RepositoryProvider(
          create: (context) => StatisticRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => RegisterBloc(
              registerRepository: context.read<RegisterRepository>(),
            ),
          ),
          BlocProvider(
            create: (_) => HomeBloc(),
          ),
          BlocProvider(
            create: (context) => StatisticsBloc(
              statisticsRepo: context.read<StatisticRepository>(),
            ),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
          title: 'Register App',
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
          ),
        ),
      ),
    );
  }
}
