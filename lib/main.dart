import 'package:app2/Register_bloc/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app2/data/repositories/register_repository.dart';
import 'package:app2/data/services/register_services.dart';
import 'package:app2/screen/register_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => RegisterRepository(
        registerService: RegisterService(),
      ),
      child: BlocProvider(
        create: (context) => RegisterBloc(
          registerRepository: RepositoryProvider.of<RegisterRepository>(context),
        ),
        child:MaterialApp(
          debugShowCheckedModeBanner: false,
          home: RegisterScreen(),
        ),
      ),
    );
  }
}
