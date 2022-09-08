import 'package:amazing_tv/core/resources/strings_manager.dart';
import 'package:amazing_tv/core/resources/styles_manager.dart';
import 'package:amazing_tv/core/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/routes_manager.dart';
import '../bloc/favourites/favourites_bloc.dart';
import '../bloc/show/show_bloc.dart';
import '../widgets/show_item_card.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _listScrollController;

  @override
  void initState() {
    _listScrollController = ScrollController();
    BlocProvider.of<FavouritesBloc>(context,listen: false).add(const GetAllFavouritesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocBuilder<ShowBloc, ShowState>(
        buildWhen: (s,n)=>s!=n,
        builder: (context, state) {
          if (state is LoadingShowsState) {
            return  const LoadingWidget();
          } else if (state is LoadedShowsState) {
            return GridView.builder(
                controller: _listScrollController,
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
          return const SizedBox();
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: false,
      title:  Text(AppStrings.amazingShow,style: getAppbarStyle(),),
      actions: [

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    BlocProvider.of<FavouritesBloc>(context,
                        listen: false)
                        .add(const GetAllFavouritesEvent());
                    Navigator.pushNamed(context, Routes.favouritesScreen,);
                  }, icon: const Icon(Icons.favorite_border)),
              const SizedBox(width: 20,),
              IconButton(onPressed: () {
                Navigator.pushNamed(context, Routes.searchScreen,);

              }, icon: const Icon(Icons.search)),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    super.dispose();
  }
}





