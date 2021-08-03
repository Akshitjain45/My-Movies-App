import 'package:flutter/material.dart';
import '../constants/api_constants.dart';
import '../modal_class/credits.dart';

class Casts extends StatelessWidget {
  final ThemeData themeData;
  final Credits credits;
  Casts({this.themeData, this.credits});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: themeData.primaryColor,
          title: Text(
            'Movie Cast',
            style: themeData.textTheme.headline5,
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: themeData.accentColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: TabBarView(
          children: [castList()],
        ),
      ),
    );
  }

  Widget castList() {
    return Container(
      padding: const EdgeInsets.only(left: 8.0, top: 8.0),
      color: themeData.primaryColor,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: credits.cast.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 70,
                  height: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: credits.cast[index].profilePath == null
                        ? Image.asset(
                            'assets/images/na.png',
                            fit: BoxFit.cover,
                          )
                        : FadeInImage(
                            image: NetworkImage(TMDB_BASE_IMAGE_URL +
                                'w500/' +
                                credits.cast[index].profilePath),
                            fit: BoxFit.cover,
                            placeholder:
                                AssetImage('assets/images/loading.gif'),
                          ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Name : ' + credits.cast[index].name,
                          style: themeData.textTheme.bodyText2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Character : ' + credits.cast[index].character,
                          style: themeData.textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}