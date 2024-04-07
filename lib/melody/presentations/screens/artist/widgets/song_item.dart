import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:melody/melody/core/helper/firebase_helper.dart';
import 'package:melody/melody/core/models/song/song.dart';
import 'package:melody/melody/presentations/screens/playing/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongItem extends StatelessWidget {
  Song song;
  PlaylistProvider? playlistProvider;
  SongItem({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 2.5,
          ),
          Row(
            children: [
              Image.network(
                song.songImagePath,
                width: 49,
                height: 49,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 210,
                child: Text(
                  song.songName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Image.asset(
                "assets/images/fav.png",
                height: 21,
                width: 21,
              ),
              SizedBox(
                width: 17,
              ),
              GestureDetector(
                onTap: () {
                  _showOptions(context);
                },
                child: Image.asset(
                  "assets/images/option.png",
                  height: 24,
                  width: 24,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 2.5,
          ),
          Divider(
            color: Colors.grey.shade700,
          )
        ],
      ),
    );
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit'),
                onTap: () {
                  Navigator.pop(context); // Close the bottom sheet
                  Get.toNamed('/editSong', arguments: song.songId);
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Delete'),
                onTap: () {
                  Navigator.pop(context); // Close the bottom sheet
                  _showDeleteConfirmationDialog(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Song"),
          content: Text("Are you sure you want to delete this song?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                await deleteSong(song.songId);
                Navigator.of(context).pop();
              },
              child: Text(
                "Delete",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteSong(String songId) async {
    try {
      await FirebaseHelper.songCollection.doc(songId).delete();

      Get.snackbar(
        "Success",
        "Song deleted successfully!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      playlistProvider!.pause();
    } catch (e) {
      print("Error deleting song: $e");
      Get.snackbar(
        "Error",
        "Failed to delete song",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
