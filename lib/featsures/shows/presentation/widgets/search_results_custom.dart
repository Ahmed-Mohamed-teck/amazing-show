import 'package:amazing_tv/core/resources/strings_manager.dart';
import 'package:amazing_tv/featsures/shows/presentation/widgets/show_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../../../../injection_container.dart';
import '../bloc/favourites/favourites_bloc.dart';
import '../bloc/search/search_bloc.dart';




class SearchResultsCustom extends StatefulWidget {
  final String keyWord;

  const SearchResultsCustom({
    required this.keyWord,
  });

  @override
  _SearchResultsCustomState createState() => _SearchResultsCustomState();
}

class _SearchResultsCustomState extends State<SearchResultsCustom> {
  final _refreshController = RefreshController();

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SearchBloc>(),
      child: BlocBuilder<SearchBloc, SearchState>(
          builder: ((context, state) {
            print(state.hashCode);
            if (state is LoadingSearchState) {
              return const LoadingWidget();
            } else if (state is LoadedSearchState) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: .7),
                itemBuilder: (context, index) {
                  BlocProvider.of<FavouritesBloc>(context, listen: false)
                      .add(GetIsFavouritesEvent(show: state.shows[index]));
                  return ShowItemCard(
                    show: state.shows[index],
                    isFav: BlocProvider.of<FavouritesBloc>(context, listen: false)
                        .favList
                        .any((element) =>
                    element?.id == state.shows[index].id) ??
                        false,
                  );
                },

                itemCount: state.shows.length,
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 100),
                    child: Icon(Icons.not_interested),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: Text(
                      AppStrings.noProductsFound,
                      style: TextStyle(
                          fontSize: 16, color: Theme
                          .of(context)
                          .hintColor),
                    ),
                  )
                ],
              ),
            );
          })),
    );
  }
}
