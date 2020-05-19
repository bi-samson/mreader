import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'meee_rss_service.dart';
import 'webview_container.dart';

class MeeeHomeScreen extends StatelessWidget {
  final MeeeRssService rss;
  const MeeeHomeScreen({this.rss});

  @override
  Widget build(BuildContext context) {
    String parseFormat = "E, dd MMM yyyy HH:mm:ss zzz";
    return Scaffold(
      body: FutureBuilder(
        future: rss.getFeed(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  final feed = snapshot.data;
                  return ListView.builder(
                      itemCount: feed.items.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        final item = feed.items[index];
                        final leading = item.enclosure != null ?
                            ConstrainedBox(
                                constraints: BoxConstraints(
                                    minWidth: 100,
                                    minHeight: 200,
                                    maxWidth: 100,
                                    maxHeight: 200,
                                ),
                                child: CachedNetworkImage(
                                    imageUrl: item.enclosure.url,
                                    fit: BoxFit.fitHeight
                                    ),
                            ) : null;
                        return ListTile(
                          leading: leading,
                          title: Text(item.title),
                          subtitle: Text(DateFormat.yMMMMd().format(DateFormat(parseFormat).parse(item.pubDate)),
                              textAlign: TextAlign.right
                              ),
                          contentPadding: EdgeInsets.all(4.0),
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WebViewContainer(item.link)));
                          },
                        );
                      });
                }
              }
              break;
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
            default:
              return Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
          }
          return null;
        },
      ),
    );
  }
}
