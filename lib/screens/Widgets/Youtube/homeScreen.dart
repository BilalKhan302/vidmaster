import 'package:flutter/material.dart';
import 'package:vidmaster/screens/Widgets/Youtube/youtube_screen.dart';
import 'package:vidmaster/screens/Widgets/Youtube/paste_link_page.dart';
class YouTubePlayerScreen extends StatefulWidget {
  const YouTubePlayerScreen({Key? key}) : super(key: key);

  @override
  State<YouTubePlayerScreen> createState() => _YouTubePlayerScreenState();
}

class _YouTubePlayerScreenState extends State<YouTubePlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions:[
          Padding(
            padding: const EdgeInsets.only(right: 20 ),
            child: IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const YouTubeView()));
            },icon: Icon(Icons.youtube_searched_for_outlined,size: 30,color: Colors.grey.shade400,),),
          ),
        ],
        centerTitle: true,
        elevation: 2.5,
        backgroundColor: Colors.black45,
        title: Text("Youtube Downloader",style: TextStyle(
          color: Colors.grey.shade400
        ),),
      ),
      body: const PasteLinkPage(),

    );
  }

}
