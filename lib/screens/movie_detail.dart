import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../api/endpoints.dart';
import '../constants/api_constants.dart';
import '../modal_class/movie.dart';
import '../screens/widgets.dart';
import 'package:provider/provider.dart';
import '../theme/theme_state.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie movie;
  final ThemeData themeData;
  final String heroId;

  MovieDetailPage({this.movie, this.themeData, this.heroId});
  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ThemeState>(context);
    return Scaffold(
      backgroundColor: widget.themeData.primaryColor,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 220.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(TMDB_BASE_IMAGE_URL +
                              'original/' +
                              widget.movie.backdropPath),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    height: 220.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Color(0xFF000000)],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 130.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Hero(
                              tag: widget.heroId,
                              child: Container(
                                height: 200.0,
                                width: 150.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(TMDB_BASE_IMAGE_URL +
                                          'w500/' +
                                          widget.movie.posterPath),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 50.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.calendar_today,
                                      color: state.themeData.accentColor,
                                      size: 30.0,
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    Text(
                                        widget.movie.releaseDate
                                            .substring(0, 4),
                                        style: state
                                            .themeData.textTheme.bodyText2),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.star,
                                      color: state.themeData.accentColor,
                                      size: 30.0,
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    Text(
                                        widget.movie.voteAverage.toString() +
                                            '/10',
                                        style: state
                                            .themeData.textTheme.bodyText2),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.language,
                                      color: state.themeData.accentColor,
                                      size: 30.0,
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    Text(
                                      widget.movie.originalLanguage
                                          .toUpperCase(),
                                      style:
                                          state.themeData.textTheme.bodyText2,
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                widget.movie.title,
                                style: TextStyle(
                                  color: state.themeData.accentColor,
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(widget.movie.overview,
                            style: state.themeData.textTheme.bodyText2),
                        // Row(
                        //   children: <Widget>[
                        //     Text('Popularity : ${widget.movie.popularity}',
                        //         style: state.themeData.textTheme.bodyText2)
                        //   ],
                        // ),
                        ScrollingArtists(
                          api: Endpoints.getCreditsUrl(widget.movie.id),
                          title: 'Cast',
                          tapButtonText: 'Full cast',
                          themeData: widget.themeData,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 60.0,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                brightness: Brightness.light,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
