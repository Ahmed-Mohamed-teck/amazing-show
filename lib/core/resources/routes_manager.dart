import 'package:amazing_tv/core/resources/strings_manager.dart';
import 'package:amazing_tv/featsures/shows/domain/entities/episode.dart';
import 'package:amazing_tv/featsures/shows/presentation/screens/episode_summary_screen.dart';
import 'package:amazing_tv/featsures/shows/presentation/screens/home_screen.dart';
import 'package:amazing_tv/featsures/shows/presentation/screens/season_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../featsures/onBoarding/presentation/screens/splash_screen.dart';
import '../../featsures/shows/domain/entities/season.dart';
import '../../featsures/shows/presentation/bloc/favourites/favourites_bloc.dart';
import '../../featsures/shows/presentation/screens/favourites_screen.dart';
import '../../featsures/shows/presentation/screens/search_screen.dart';
import '../../featsures/shows/presentation/screens/season_summary_screen.dart';
import '../../injection_container.dart';

class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String seasonScreen = "/seasonScreen";
  static const String seasonSummaryScreen = "/seasonSummaryScreen";
  static const String episodeSummaryScreen = "/episodeSummaryScreen";
  static const String onBoardingRoute = "/onBoarding";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
  static const String favouritesScreen = "/favouritesScreen";
  static const String searchScreen = "/searchScreen";
  static const String testRout = "/testRout";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.mainRoute:

        return MaterialPageRoute(builder: (_) =>  const HomeScreen());
      case Routes.seasonScreen:
        return MaterialPageRoute(builder: (_) =>  const SeasonScreen());
      case Routes.seasonSummaryScreen:
        return MaterialPageRoute(builder: (_) =>   SeasonSummaryScreen(season: args as Season,));
      case Routes.episodeSummaryScreen:
        return MaterialPageRoute(builder: (_) =>   EpisodeSummaryScreen(episode: args as Episode,));
      case Routes.favouritesScreen:
        return MaterialPageRoute(builder: (_) =>   FavouritesScreen());
      case Routes.searchScreen:
        return MaterialPageRoute(builder: (_) =>  const SearchScreen());
      // case Routes.testRout:
      //   return MaterialPageRoute(builder: (_) =>   SingleEpisodeScreen(season: args as Season,));

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}
