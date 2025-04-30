import 'package:app2/screen/home_screen.dart';
import 'package:app2/screen/loading_screen.dart';
import 'package:app2/screen/register_screen.dart';
import 'package:app2/screen/statistics_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter{
  static GoRouter router =GoRouter(
      routes: [
        GoRoute(path: '/',
          builder: (context,state)=>RegisterScreen(),
        ),
        // GoRoute(
        //     path: '/loading',
        //     builder:(context,state)=>LoadingScreen(),
        // ),
        GoRoute(
          path: '/home',
          builder: (context,state)=>HomeScreen(),
        ),
        GoRoute(
            path: '/statistics',
            builder: (context,state)=>StatisticsScreen(),
        )
      ]
  );
}