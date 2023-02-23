import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vidmaster/screens/Widgets/Youtube/download.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class PasteLinkPage extends StatefulWidget {
  const PasteLinkPage({Key? key}) : super(key: key);

  @override
  State<PasteLinkPage> createState() => _PasteLinkPageState();
}
class _PasteLinkPageState extends State<PasteLinkPage> {
  String videId='';
  String videoTitle='';
  VideoQuality? videoQuality;
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _PasteLinkPageState();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.yellow.shade300,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              
              TextFormField(
                onChanged: (val){
                  download(val);
                },
                controller: textController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 5,
                      color: Colors.black45,
                      style: BorderStyle.solid
                    )
                  ),

                    labelText: "Paste Your Youtube Link Here",

                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                  labelStyle: TextStyle(
                    color: Colors.grey.shade400,
                  ),

                ),
              ),
              const SizedBox(height: 20,),
             videId!=""? Center(child: Image.network("https://img.youtube.com/vi/$videId/0.jpg",height: MediaQuery.of(context).size.width*0.6,)):Container(),
             videoTitle!=""? Center(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(videoTitle,
                  style: TextStyle(
                    fontSize: 16,
                    height: 2,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade400
                  ),),
                ),
              ):const Text(""),
              const SizedBox(height: 10,),
              GestureDetector(
                onTap: () async{
                  if (textController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.grey.shade400,
                        content: const Text("No Link Pasted")));
                  } else  {
                    Download().downloadVideo(getVideoId(textController.text), "Vidmaster");
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.all(15),
                 
                  child: Text("Download",
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 20),),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  Future<void> download(String id)async {
    var permission=await Permission.storage.request();
    if(permission.isGranted){
      if(textController.text!=''){
        var yt = YoutubeExplode();
        var video = await yt.videos.get(id);
        var manifest = await yt.videos.streamsClient.getManifest(id);
     setState(() {
      videoTitle=video.title;
      videId=video.id.toString();
    });
      }
    }
  }
}
//
