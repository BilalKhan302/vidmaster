import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vidmaster/screens/Widgets/Youtube/download.dart';
import 'package:webview_flutter/webview_flutter.dart';
class YouTubeView extends StatefulWidget {
  const YouTubeView({Key? key}) : super(key: key);

  @override
  State<YouTubeView> createState() => _YouTubeViewState();
}

class _YouTubeViewState extends State<YouTubeView> {
  final link="https://www.youtube.com";
  WebViewController? _controller;
  bool showDownloadButton=false;
  String shorts="https://m.youtube.com/shorts/";
  void checkUrl()async{
    if(await _controller!.currentUrl()=="https://m.youtube.com/"){
      setState(() {
        showDownloadButton=false;
      });
    }else if(
    await _controller!.currentUrl()==shorts
    ){
      setState(() {
        showDownloadButton=false;
      });
    }
    else{
      setState(() {
        showDownloadButton=true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    checkUrl();
    return WillPopScope(
      onWillPop: ()async{
        if(await _controller!.canGoBack()){
          _controller!.goBack();
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black45,
          title: Text("Youtube Downloader",style: TextStyle(
              color: Colors.grey.shade400
          ),),
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          },icon:Icon(Icons.arrow_back_ios,color: Colors.grey.shade400,)),
        ),
        body: WebView(
          onWebViewCreated: (controller){
            setState(() {
              _controller=controller;
            });
          },
          initialUrl: link,
          javascriptMode: JavascriptMode.unrestricted,
        ),
        floatingActionButton:showDownloadButton== false ? Container() : FloatingActionButton(
          backgroundColor: Colors.grey.shade400,
          child: Icon(Icons.download),
          onPressed: ()async{
            final url= await _controller!.currentUrl();
            final title= await _controller!.getTitle();
                Download().downloadVideo(getVideoId(url!), "Vidmaster");

          },
        ),

      ),
    );
  }
}
