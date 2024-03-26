import 'package:Rhythmix/Database/boxes.dart';
import 'package:Rhythmix/Database/openbox.dart';
import 'package:Rhythmix/backgroundcolor/backgroundcolor.dart';
import 'package:Rhythmix/Thumbnail/thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:Rhythmix/Database/model.dart';

import 'package:Rhythmix/Screens/video/Videoplayer.dart';

class Videofunction extends StatefulWidget {
  const Videofunction({Key? key}) : super(key: key);

  @override
  State<Videofunction> createState() => _VideofunctionState();
}

class _VideofunctionState extends State<Videofunction> {
  late Box<Videohive> _boxvideo;
  


  @override
  void initState() {
    super.initState();
    _openBox();
  }

  Future<void> _openBox() async {
    _boxvideo = await Hive.openBox<Videohive>('Videobox');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: myGradient),
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height -
                  100, // Adjust height as needed
              child: GridView.builder(

                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemBuilder: (context, index) {
                  final video = _boxvideo.getAt(index);

                  // Retrieve video at index
                  return GestureDetector(
                    onTap: () {
                    
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => CustomVideoPlayer(
                              videoPath: video.videoFile,
                            ),
                          ),
                        );
                      
                    },
                    child: Card(color: const Color.fromARGB(255, 234, 254, 83),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: 120,
                                  width: double.infinity,
                                  child:ValueListenableBuilder(valueListenable: generateThumbnailNotifier(video!.videoFile.createPath()), 
                                  builder: (context,thumbnailData , child) {
                                    if(thumbnailData !=null){
                                      return Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                             
                                            ),
                                            
                                              child: Image.memory(
                                                thumbnailData,
                                                fit: BoxFit.cover,
                                              ),
                                            
                                          );
                                        }else{
                                           return      Container(
  width: 100,
  height: 100,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(15), // Change the radius value as needed
    border: Border.all(
      color: Colors.black, // Border color
      width: 2, // Border width
    ),
  ),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(15), // Ensure this value matches the container's border radius
    child: Image.asset(
      'android/assets/images/Placeholder image.jpg',
      width: 100,
      height: 100,
      fit: BoxFit.cover, // This ensures the image fills the container without distortion
    ),
  ),
);
                                        }
                                  },)
                                ),
                                Positioned(
                                  top: 10,
                                  child: PopupMenuButton(
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        onTap: () {
                                         
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (ctx) =>
                                                    CustomVideoPlayer(
                                                  videoPath: video.videoFile,
                                                ),
                                              ),
                                            );
                                          
                                        },
                                        child: const Text('Play'),
                                      ),
                                      PopupMenuItem(
                                        onTap: () {},
                                        child: const Text('Add to Playlist'),
                                      ),
                                      PopupMenuItem(
                                        onTap: () {
                                          setState(() {
                                            boxFavorite.add(videofavorite(Favoritevideo: video.videoFile));
                                          });
                                        },
                                        child: const Text('Add to Favorite'),
                                      ),
                                      PopupMenuItem(
                                        onTap: () {},
                                        child: const Text('Share'),
                                      ),
                                    ],
                                    child: const Padding(
                                      padding: EdgeInsets.only(left: 130),
                                      child: Icon(
                                        Icons.more_vert,
                                        size: 30,
                                        weight: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 12,
                              left: 8.0,
                              right: 8.0,
                            ),
                            child: Text(
                              video.videoFile.split('/').last,
                              style: const TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: _boxvideo.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
