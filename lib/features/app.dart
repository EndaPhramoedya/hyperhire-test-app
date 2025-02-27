import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyperhire_test_app/constants/route_paths.dart';
import 'package:hyperhire_test_app/features/home/bloc/home_bloc.dart';
import 'package:hyperhire_test_app/features/home/page/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RoutePaths.home,
      onGenerateRoute: _onGenerateRoute,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.home:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (_) => BlocProvider<HomeBloc>(
            create: (_) => HomeBloc(),
            child: const HomePage(),
          ),
        );

      default:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
