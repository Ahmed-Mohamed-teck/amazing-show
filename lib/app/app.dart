
import 'package:amazing_tv/core/resources/routes_manager.dart';
import 'package:amazing_tv/core/resources/theme_manager.dart';
import 'package:amazing_tv/featsures/shows/presentation/bloc/season/season_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../featsures/shows/presentation/bloc/favourites/favourites_bloc.dart';
import '../featsures/shows/presentation/bloc/search/search_bloc.dart';
import '../featsures/shows/presentation/bloc/show/show_bloc.dart';
import '../featsures/shows/presentation/bloc/show/show_event.dart';
import '../injection_container.dart' as di;
import 'package:sizer/sizer.dart';




class MyApp extends StatefulWidget {
  // named constructor
  const MyApp._internal();


  static const MyApp _instance =
  MyApp._internal(); // singleton or single instance

  factory MyApp() => _instance; // factory

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

      providers: [
        BlocProvider(
            create: (_) => di.sl<ShowBloc>()..add(GetAllShowsEvent())),
        BlocProvider(
            create: (_) => di.sl<SeasonBloc>()),
        BlocProvider(
            create: (_) => di.sl<FavouritesBloc>()),
        // BlocProvider(
        //     create: (_) => di.sl<SearchBloc>()),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType)=> MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: Routes.splashRoute,
          theme: getApplicationTheme(),
        ),
      ),
    );
  }
}
