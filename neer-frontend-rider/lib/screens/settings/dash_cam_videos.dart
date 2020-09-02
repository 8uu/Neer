import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/theme/global.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(
    DashCamVideo(),
  );
}

class DashCamVideo extends StatefulWidget {
  DashCamVideo({this.title = 'Jul 08, 9:14 AM'});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _DashCamVideoState();
  }
}

class _DashCamVideoState extends State<DashCamVideo> {
  // TargetPlatform _platform;
  VideoPlayerController _videoPlayerController1;
  VideoPlayerController _videoPlayerController2;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController1 =
        VideoPlayerController.asset('assets/videos/dashcam_video.mp4');
    _videoPlayerController2 = VideoPlayerController.network(
        'https://www.sample-videos.com/video123/mp4/480/asdasdas.mp4');
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _videoPlayerController2.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.title,
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: primaryText,
          ),
          centerTitle: true,
          backgroundColor: blueColor,
          leading: new IconTheme(
            data: new IconThemeData(
              color: Colors.black,
            ),
            child: new IconButton(
              icon: new Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Chewie(
                  controller: _chewieController,
                ),
              ),
            ),
            // FlatButton(
            //   onPressed: () {
            //     _chewieController.enterFullScreen();
            //   },
            //   child: Text('Fullscreen'),
            // ),
            // Row(
            //   children: <Widget>[
            //     Expanded(
            //       child: FlatButton(
            //         onPressed: () {
            //           setState(() {
            //             _chewieController.dispose();
            //             _videoPlayerController2.pause();
            //             _videoPlayerController2.seekTo(Duration(seconds: 0));
            //             _chewieController = ChewieController(
            //               videoPlayerController: _videoPlayerController1,
            //               aspectRatio: 3 / 2,
            //               autoPlay: true,
            //               looping: true,
            //             );
            //           });
            //         },
            //         child: Padding(
            //           child: Text("Video 1"),
            //           padding: EdgeInsets.symmetric(vertical: 16.0),
            //         ),
            //       ),
            //     ),
            // Expanded(
            //   child: FlatButton(
            //     onPressed: () {
            //       setState(() {
            //         _chewieController.dispose();
            //         _videoPlayerController1.pause();
            //         _videoPlayerController1.seekTo(Duration(seconds: 0));
            //         _chewieController = ChewieController(
            //           videoPlayerController: _videoPlayerController2,
            //           aspectRatio: 3 / 2,
            //           autoPlay: true,
            //           looping: true,
            //         );
            //       });
            //     },
            //     child: Padding(
            //       padding: EdgeInsets.symmetric(vertical: 16.0),
            //       child: Text("Error Video"),
            //     ),
            //   ),
            // )
            //   ],
            // ),
            // Row(
            //   children: <Widget>[
            //     Expanded(
            //       child: FlatButton(
            //         onPressed: () {
            //           setState(() {
            //             _platform = TargetPlatform.android;
            //           });
            //         },
            //         child: Padding(
            //           child: Text("Android controls"),
            //           padding: EdgeInsets.symmetric(vertical: 16.0),
            //         ),
            //       ),
            //     ),
            //     Expanded(
            //       child: FlatButton(
            //         onPressed: () {
            //           setState(() {
            //             _platform = TargetPlatform.iOS;
            //           });
            //         },
            //         child: Padding(
            //           padding: EdgeInsets.symmetric(vertical: 16.0),
            //           child: Text("iOS controls"),
            //         ),
            //       ),
            //     )
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
