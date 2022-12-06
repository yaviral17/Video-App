import 'dart:io';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:video_app/postdetails.dart';
import 'package:video_app/utils/colors.dart';
import 'package:video_player/video_player.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int currentVideoIndex = 0;
  @override
  Widget build(BuildContext context) {
    var display = MediaQuery.of(context).size;

    List<PostDetails> videos = [
      PostDetails(
        videoUrl:
            "https://firebasestorage.googleapis.com/v0/b/video-app-f8645.appspot.com/o/290451252_364787309095936_9137108768146598637_n.mp4?alt=media&token=8447b509-0b48-484f-b078-341779b35d22",
        // 'assets/videos/reel1.mp4',
        username: "sudo_yavi",
        title: "vit bhopal me banai thi mayne ye wali video",
        location: "Bhopal,MP",
        date: "12-06-2022",
        views: "53K",
        profileURL:
            "https://instagram.fagr1-4.fna.fbcdn.net/v/t51.2885-19/317147005_469027665332613_8302804634394066715_n.jpg?stp=dst-jpg_s320x320&_nc_ht=instagram.fagr1-4.fna.fbcdn.net&_nc_cat=109&_nc_ohc=b0EKNjNaFBkAX--HHLr&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AfBi831DmwdEXPQmGRTBJ1k9VoxN2eFMJWOh-ZxcFcBh4A&oe=638F37E9&_nc_sid=8fd12b",
      ),
      PostDetails(
        videoUrl:
            "https://firebasestorage.googleapis.com/v0/b/video-app-f8645.appspot.com/o/283943729_1702086820144762_9126262050738842378_n.mp4?alt=media&token=8e7fd853-23e1-4f58-b478-5326246751d6",
        username: "sudo_yavi",
        title: "vit bhopal",
        location: "Bhopal,MP",
        date: "12-06-2022",
        views: "53K",
        profileURL:
            "https://instagram.fagr1-4.fna.fbcdn.net/v/t51.2885-19/317147005_469027665332613_8302804634394066715_n.jpg?stp=dst-jpg_s320x320&_nc_ht=instagram.fagr1-4.fna.fbcdn.net&_nc_cat=109&_nc_ohc=b0EKNjNaFBkAX--HHLr&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AfBi831DmwdEXPQmGRTBJ1k9VoxN2eFMJWOh-ZxcFcBh4A&oe=638F37E9&_nc_sid=8fd12b",
      ),
    ];

    return Container(
      child: Stack(
        children: [
          Container(
            color: Colors.transparent,
            margin: EdgeInsets.only(bottom: 55, top: 55),
            child: PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: videos.length,
              onPageChanged: (value) {
                setState(() {
                  currentVideoIndex = value;
                });
              },
              itemBuilder: (context, index) {
                return FeedItem(
                  views: videos[index].views,
                  username: videos[index].username,
                  title: videos[index].title,
                  profileURL: videos[index].profileURL,
                  location: videos[index].location,
                  date: videos[index].date,
                  videoUrl: videos[index].videoUrl,
                );
              },
            ),
          ),
          Container(
            color: defaultWhite,
            width: display.width,
            padding: EdgeInsets.only(left: 18, right: 18),
            child: Container(
              height: 48.0,
              padding: const EdgeInsets.only(top: 1, left: 10),
              decoration: BoxDecoration(
                color: textFieldBackgroundLightGrey,
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: TextFormField(
                controller: TextEditingController(),
                obscureText: false,
                keyboardType: TextInputType.text,
                cursorHeight: 18,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  hintText: 'Search',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(15),
                  hintStyle: TextStyle(
                    height: 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FeedItem extends StatefulWidget {
  final String videoUrl;
  final String username;
  final String title;
  final String location;
  final String date;
  final String views;
  final String profileURL;

  const FeedItem({
    super.key,
    required this.videoUrl,
    required this.username,
    required this.title,
    required this.location,
    required this.date,
    required this.views,
    required this.profileURL,
  });

  @override
  State<FeedItem> createState() => _FeedItemState();
}

class _FeedItemState extends State<FeedItem> {
  VideoPlayerController? videoController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializePlayer(widget.videoUrl);
  }

  void initializePlayer(String url) async {
    final fileInfo = await checkCacheFor(url);
    if (fileInfo == null) {
      videoController = VideoPlayerController.network(url);
      videoController!.setLooping(true);
      videoController!.initialize().then((value) {
        cachedForUrl(url);
        setState(() {
          videoController!.play();
        });
      });
    } else {
      final file = fileInfo.file;
      videoController = VideoPlayerController.file(file);
      videoController!.setLooping(true);
      videoController!.initialize().then((value) {
        setState(() {
          videoController!.play();
        });
      });
    }
  }

  void cachedForUrl(String url) async {
    await DefaultCacheManager().getSingleFile(url).then(
      (value) {
        print('download successfully done for ${url}');
      },
    );
  }

  Future<FileInfo?> checkCacheFor(String url) async {
    final FileInfo? value = await DefaultCacheManager().getFileFromCache(url);
    return value;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (videoController == null) {
      videoController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var display = MediaQuery.of(context).size;
    return Container(
      child: Stack(
        children: [
          Container(
            child: (videoController == null)
                ? Center(child: const Text('Wait'))
                : ((videoController!.value.isInitialized)
                    ? VideoPlayer(videoController!)
                    : Center(child: const Text('Loading...'))),
          ),
          Container(
            width: display.width,
            child: Column(
              children: [
                Row(
                  children: [
                    CircularProfileAvatar(
                      widget.profileURL,
                      radius: 26,
                    ),
                    Container(
                      height: 48,
                      child: Column(
                        children: [
                          Spacer(),
                          Text(widget.title.length > 24
                              ? widget.title.substring(0, 25) + "..."
                              : widget.title),
                          Text(widget.username),
                          Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
