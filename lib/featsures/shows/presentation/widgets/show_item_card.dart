import 'package:amazing_tv/featsures/shows/presentation/bloc/favourites/favourites_bloc.dart';
import 'package:amazing_tv/featsures/shows/presentation/bloc/show/show_bloc.dart';
import 'package:amazing_tv/featsures/shows/presentation/bloc/show/show_event.dart';
import 'package:amazing_tv/injection_container.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/routes_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../domain/entities/show.dart';
import '../bloc/season/season_bloc.dart';
import '../bloc/season/season_event.dart';

class ShowItemCard extends StatefulWidget {
  final Show show;
  final bool isFav;
  final bool shouldRebuildHome;


  const ShowItemCard({
    Key? key,
    required this.show,  this.isFav=false,this.shouldRebuildHome=false
  }) : super(key: key);

  @override
  State<ShowItemCard> createState() => _ShowItemCardState();
}

class _ShowItemCardState extends State<ShowItemCard> {
  
  late bool _isFavorite;


  @override
  void initState() {
    super.initState();
    _isFavorite =widget.isFav;

  }

  @override
  Widget build(BuildContext context) {

    return InkWell(
        onTap: () async {
          BlocProvider.of<SeasonBloc>(context, listen: false)
              .add(GetAllShowSeasonsEvent(widget.show.id.toString()));
          Navigator.pushNamed(
            context,
            Routes.seasonScreen,
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5.w), topLeft: Radius.circular(5.w))),
          child: Column(
            children: [
              Container(
                height: 20.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.w),
                      topRight: Radius.circular(5.w)),
                  color: Colors.black,
                ),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.2.w),
                        topRight: Radius.circular(5.2.w)),
                    child: CachedNetworkImage(
                        memCacheHeight: double.maxFinite.toInt(),
                        memCacheWidth: double.maxFinite.toInt(),
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.fill,
                        imageUrl: widget.show.image?.original ?? '',
                        errorWidget: (context, url, error) => Column(
                          children: [
                            SizedBox(
                                height: 20.h,
                                child: const CircularProgressIndicator())
                          ],
                        )),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.black54,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.show.name.toString(),
                          style: getRegularStyle(color: ColorManager.white),
                          maxLines: 2,
                        ),
                        const Divider(
                          color: Colors.white,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              IconButton(
                                onPressed: () {
                                  BlocProvider.of<FavouritesBloc>(context,
                                      listen: false)
                                      .add(GetToggleFavouritesEvent(show: widget.show));
                                  BlocProvider.of<FavouritesBloc>(context,
                                      listen: false)
                                      .add(const GetAllFavouritesEvent());
                                  setState(() {
                                    _isFavorite =!_isFavorite;
                                  });
                                  if(widget.shouldRebuildHome){
                                    sl<ShowBloc>().add(GetAllShowsEvent());
                                    // sl<FavouritesBloc>().add(const GetAllFavouritesEvent());

                                  }
                                },
                                icon:

                                Icon(_isFavorite?Icons.favorite:Icons.favorite_border_outlined,
                                  color: Colors.white,
                                ),
                                padding: const EdgeInsets.all(0),
                              ),


                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      widget.show.rating?.average.toString() ?? '',
                                      style: const TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
