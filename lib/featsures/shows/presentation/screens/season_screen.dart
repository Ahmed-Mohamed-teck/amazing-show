import 'package:amazing_tv/core/resources/routes_manager.dart';
import 'package:amazing_tv/core/resources/strings_manager.dart';
import 'package:amazing_tv/featsures/shows/domain/entities/season.dart';
import 'package:amazing_tv/featsures/shows/presentation/bloc/season/season_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../bloc/season/season_state.dart';

class SeasonScreen extends StatelessWidget {
  const SeasonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.seasons,
          style: getAppbarStyle(),
        ),
      ),
      body: BlocBuilder<SeasonBloc, SeasonState>(
        builder: (context, state) {
          if (state is LoadingShowSeasonState) {
            return const LoadingWidget();
          } else if (state is LoadedShowSeasonState) {
            return Center(
              child: ListView.builder(
                itemCount: state.seasons.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: ()=>_onCardItemTap(season:state.seasons[index], context: context),
                    child: _buildItem(
                        season: state.seasons[index], context: context),
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: Text('error screen'),
            );
          }
        },
      ),
    );
  }

  _buildItem({required Season season, required BuildContext context}) {
    return SizedBox(
      height: 20.h,
      child: Card(
        child: Container(
          color: Colors.white10,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                memCacheWidth: 30.w.toInt(),
                memCacheHeight: 20.h.toInt(),
                height: 20.h,
                width: 30.w,
                imageUrl: season.image?.original ?? '',
                placeholder: (context, s) => SizedBox(
                  height: 20.h,
                  width: 30.w,
                  child: SvgPicture.asset(ImageAssets.placeHolder),
                ),
                errorWidget: (context, url, error) => SizedBox(
                  height: 20.h,
                  width: 30.w,
                  child: SvgPicture.asset(ImageAssets.placeHolder),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      color: Colors.black54,
                      child: SizedBox(
                        width: 65.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Season :${season.number}",
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              "Episodes : ${season.episodeOrder}",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      width: 65.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: Image.asset(
                                'icons/flags/png/${season.network?.country?.code?.toLowerCase()}.png',
                                package: 'country_icons'),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.date_range),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(season.premiereDate ??
                                  AppStrings.noAvailableDate)
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Text(season.summary??''),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onCardItemTap({required Season season,required BuildContext context}) {
    Navigator.pushNamed(context, Routes.seasonSummaryScreen,arguments: season);

  }
}
