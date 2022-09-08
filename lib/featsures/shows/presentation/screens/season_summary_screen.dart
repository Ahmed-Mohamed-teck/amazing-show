import 'package:amazing_tv/core/resources/color_manager.dart';
import 'package:amazing_tv/core/resources/strings_manager.dart';
import 'package:amazing_tv/core/widgets/loading_widget.dart';
import 'package:amazing_tv/featsures/shows/domain/entities/season.dart';
import 'package:amazing_tv/featsures/shows/presentation/bloc/episode/episode_bloc.dart';
import 'package:amazing_tv/featsures/shows/presentation/bloc/episode/episode_event.dart';
import 'package:amazing_tv/featsures/shows/presentation/bloc/season/season_bloc.dart';
import 'package:amazing_tv/featsures/shows/presentation/bloc/season/season_state.dart';
import 'package:amazing_tv/injection_container.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/resources/routes_manager.dart';
import '../bloc/episode/episode_state.dart';

class SeasonSummaryScreen extends StatelessWidget {
  final Season season;

  const SeasonSummaryScreen({Key? key, required this.season}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<EpisodeBloc>()
        ..add(GetAllSeasonEpisodesEvent(seasonId: season.id.toString())),
      child: Scaffold(
        body: SeasonDetailContent(
          season: season,
        ),
      ),
    );
  }
}

class SeasonDetailContent extends StatelessWidget {
  final Season season;

  const SeasonDetailContent({Key? key, required this.season}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeasonBloc, SeasonState>(
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 250.0,
              flexibleSpace: FlexibleSpaceBar(
                background: FadeIn(
                  duration: const Duration(milliseconds: 500),
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black,
                          Colors.black,
                          Colors.transparent,
                        ],
                        stops: [0.0, 0.5, 1.0, 1.0],
                      ).createShader(
                        Rect.fromLTRB(0.0, 0.0, rect.width, rect.height),
                      );
                    },
                    blendMode: BlendMode.dstIn,
                    child: CachedNetworkImage(
                      width: MediaQuery.of(context).size.width,
                      imageUrl: season.image?.original ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: FadeInUp(
                from: 20,
                duration: const Duration(milliseconds: 500),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        season.name.toString(),

                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 2.0,
                              horizontal: 8.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              season.premiereDate?.split('-')[0] ?? '',
                              style:  TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: ColorManager.white
                              ),
                            ),
                          ),
                          const SizedBox(width: 16.0),

                        ],
                      ),
                      const SizedBox(height: 20.0),

                      Html(
                          data: season.summary.toString().isNotEmpty?"""${season.summary}""":AppStrings.loremObsum,

                          ),
                      const SizedBox(height: 8.0),

                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0),
              sliver: SliverToBoxAdapter(
                child: FadeInUp(
                  from: 20,
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    AppStrings.episodes.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ),
            // Tab(text: 'More like this'.toUpperCase()),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 24.0),
              sliver: _showRecommendations(),
            ),
          ],
        );
      },
    );
  }



  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }


  Widget _showRecommendations() {
    return BlocBuilder<EpisodeBloc, EpisodeState>(
      builder: (context, state) {
        if (state is LoadingSeasonEpisodesState) {
          return const SliverToBoxAdapter(child: LoadingWidget());
        } else if (state is LoadedSeasonEpisodesState) {
          return SliverToBoxAdapter(
            child: SizedBox(
              height: 30.h,
              child: ListView.separated(
                itemCount: state.episodes.length,
                separatorBuilder: (context,index)=>SizedBox(width: 2.w,),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, Routes.episodeSummaryScreen,arguments: state.episodes[index]);
                    },
                    child: FadeInUp(
                      from: 20,
                      duration: const Duration(milliseconds: 500),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                            child: CachedNetworkImage(
                              memCacheHeight: 30.h.toInt(),
                              memCacheWidth: 50.w.toInt(),
                              width: 50.w,
                              imageUrl:
                              state.episodes[index].image?.original??'',
                              errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                              height: 180.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                              bottom: 8.5.h,
                              left: 0,
                              right: 0,
                              child: Container(
                                width: double.maxFinite,
                                decoration: const BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(4),bottomRight: Radius.circular(8))
                                ),
                                height: 6.h,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                    SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircleAvatar(
                                        backgroundColor: ColorManager.white,
                                        child: Text(state.episodes[index].number.toString(),style: const TextStyle(color: Colors.black),),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.star,color: Colors.yellow,),
                                        Text(state.episodes[index].rating?.average.toString()??'',style: TextStyle(color: ColorManager.white),),
                                      ],
                                    )
                                  ],),
                                ),
                              )),
                        ],
                      ),
                    ),
                  );
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
          );
        }
        return const SliverToBoxAdapter(child: SizedBox());
      },
    );
  }
}
