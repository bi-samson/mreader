import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

class MeeeRssService {
  final String shortName;
  final String name;
  final String url;

  const MeeeRssService({this.shortName, this.name, this.url});

  Future<RssFeed> getFeed() =>
      http.read(this.url).then((xmlString) => RssFeed.parse(xmlString));
}

