import 'package:flutter/foundation.dart';
import 'package:flutter_youtube_downloader/flutter_youtube_downloader.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
String getVideoId(String url){
  url=url.replaceAll("https://www.youtube.com/watch?v=", "");
  url=url.replaceAll("https://m.youtube.com/watch?v=", "");
  url=url.replaceAll("https://youtube.com/shorts/", "");
      return url;
}
class Download {
  Future<void> downloadVideo(String url, String title) async {
    final result = await FlutterYoutubeDownloader.downloadVideo(
        url, title, 18);
    if (kDebugMode) {
      print(result);
    }

  }
  Future<void> download(String url)async {
    var yt = YoutubeExplode();
    var video = await yt.videos.get(url);
    var manifest = await yt.videos.streamsClient.getManifest(url);

    final result =FlutterYoutubeDownloader.downloadVideo(video.url, "Vidmaster", 18);

  }

}

