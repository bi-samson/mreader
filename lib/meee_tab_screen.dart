
import 'package:flutter/material.dart';
import 'meee_home_screen.dart';
import 'meee_rss_service.dart';

const List<MeeeRssService> rssList = const <MeeeRssService>[
    const MeeeRssService(
        shortName: 'ALL',
        name: 'ALL',
        url: 'https://feed.rssunify.com/5ec3cd0c66dc3/rss.xml'),
    const MeeeRssService(
        shortName: 'BI',
        name: 'BUSINESS INSIDER',
        url: 'https://www.businessinsider.jp/feed/index.xml'),
    const MeeeRssService(
        shortName: 'GIZ',
        name: 'ギズモード・ジャパン',
        url: 'https://www.gizmodo.jp/index.xml'),
    const MeeeRssService(
        shortName: 'LH',
        name: 'ライフハッカー［日本版］',
        url: 'https://www.lifehacker.jp/feed/index.xml'),
    const MeeeRssService(
        shortName: 'M',
        name: 'MYLOHAS',
        url: 'https://www.mylohas.net/index.xml'),
    const MeeeRssService(
        shortName: 'DIGIDAY',
        name: 'DIGIDAY',
        url: 'https://digiday.jp/feed/'),
    const MeeeRssService(
        shortName: 'MU',
        name: 'MashingUp',
        url: 'https://www.mashingup.jp/index.xml'),
];

class MeeeTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.white,
      ),
      home: DefaultTabController(
        length: rssList.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('mediagene'),
            bottom: TabBar(
              isScrollable: true,
              tabs: rssList.map((MeeeRssService rss) {
                return Tab(text: rss.shortName);
              }).toList(),
            ),
          ),
          body: TabBarView(
            children: rssList.map((MeeeRssService rss) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: MeeeHomeScreen(rss: rss),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
