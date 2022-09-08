import 'package:amazing_tv/core/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/strings_manager.dart';
import '../../../../injection_container.dart';
import '../bloc/favourites/favourites_bloc.dart';
import '../widgets/show_item_card.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
                backgroundColor: Theme.of(context).primaryColor,
                centerTitle: true,
                iconTheme: const IconThemeData(color: Colors.white),
                title: const Text(
                  AppStrings.myFav,
                  style: TextStyle(color: Colors.white),
                )),
            body: BlocConsumer<FavouritesBloc, FavouritesState>(
              listener: (s,n){},
                builder: ((context, state) {
                  print(state.hashCode);
              if (state is LoadingGetAllFavouritesState) {
                    return const LoadingWidget();
                  } else if (state is LoadedGetAllFavouritesState && state.show.isNotEmpty ) {
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: .7),
                      itemBuilder: (context, index) => ShowItemCard(
                        key: Key(state.show[index]!.id.toString()),
                        shouldRebuildHome: true,
                        show: state.show[index]!,isFav: true,
                      ),
                      itemCount: state.show.length,
                    );
                  }else if (state is LoadedGetToggleFavouritesState && state.show.isNotEmpty) {
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: .7),
                      itemBuilder: (context, index)
                      {

                  return  ShowItemCard(
                    shouldRebuildHome: true,
                      show: state.show[index]!,
                      isFav:true,
                    );
                  },
                      itemCount: state.show.length,
                    );
                  }
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite_rounded,
                            color: Theme.of(context).primaryColor,
                            size: 65,
                          ),
                          const SizedBox(height: 16),
                          const Text(AppStrings.noFavMsg,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),
                          const SizedBox(height: 16),
                          const Text(
                            AppStrings.addFavMsg,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                })));
  }
}
