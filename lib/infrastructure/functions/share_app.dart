import 'package:share/share.dart';

void shareApp() {
  String musicTitle = "Mr.musik";
  String musicUrl =
      "https://play.google.com/store/apps/details?id=com.brototype.mr_musik";
  Share.share("Check out this amazing music player App: $musicTitle\n\n$musicUrl");
}