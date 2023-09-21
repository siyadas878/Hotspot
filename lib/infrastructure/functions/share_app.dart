import 'package:share/share.dart';

void shareApp() {
  String musicTitle = "Hotspot";
  String musicUrl =
      "https://play.google.com/store/apps/details?id=in.hotspot";
  Share.share("Check out this amazing social media App: $musicTitle\n\n$musicUrl");
}