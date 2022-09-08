import 'package:amazing_tv/core/resources/color_manager.dart';
import 'package:amazing_tv/core/resources/strings_manager.dart';
import 'package:amazing_tv/featsures/shows/domain/entities/episode.dart';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';



class EpisodeSummaryScreen extends StatelessWidget {
  final Episode episode;

  const EpisodeSummaryScreen({Key? key, required this.episode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: CustomScrollView(
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
                      imageUrl: episode.image?.original ?? '',
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
                        episode.name.toString(),

                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              episode.airdate?.split('-')[0] ?? '',
                              style:  TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                  color: ColorManager.white
                              ),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Row(

                            children: [
                            const Icon(Icons.star,color: Colors.yellow,),
                            Text(episode.rating?.average.toString()??''),
                          ],),
                        ],
                      ),
                      const SizedBox(height: 20.0),

                      Html(
                        data: episode.summary.toString().isNotEmpty?"""${episode.summary}""":AppStrings.loremObsum,

                      ),
                      const SizedBox(height: 8.0),

                    ],
                  ),
                ),
              ),
            ),


          ],
        )
      );

  }
}

