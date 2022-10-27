import 'package:flutter/material.dart';
import 'package:muzify/functions/functions.dart';

class editplaylist extends StatefulWidget {
  const editplaylist({Key? key, required this.playlistNameForEdit})
      : super(key: key);
  final String playlistNameForEdit;
  @override
  State<editplaylist> createState() => _editplaylistState();
}

class _editplaylistState extends State<editplaylist> {
  late TextEditingController nameController;
  String playlistNewName = '';

  @override
  void initState() {
    nameController =
        TextEditingController(text: widget.playlistNameForEdit.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(60))
      ),
      backgroundColor:  Color.fromARGB(255, 57, 0, 113),
      title: const Text("Edit Playlist",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "poppinz",
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold)),
      content: TextField(
        controller: nameController,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.white)),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
          hintStyle: const TextStyle(color: Colors.white),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color:Colors.white,
              width: 2.0,
            ),
          ),
        ),
        onChanged: (value) {
          playlistNewName = value;
        },
      ),
      actions: [
        TextButton(
            onPressed: () {
              List playListnames = box.keys.toList();

              if (!playListnames.contains(playlistNewName)) {
                List<dynamic> playListSongs =
                    box.get(widget.playlistNameForEdit)!;
                box.delete(widget.playlistNameForEdit);
                box.put(playlistNewName, playListSongs);
              } else {
                ScaffoldMessenger(
                    child: SnackBar(
                  content: Text('$playlistNewName already exist in playlist'),
                ));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    '$playlistNewName already exist in playlist',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: const Color(0xffdd0021),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ));
              }
              Navigator.of(context).pop();
            },
            child: const Text(
              "Edit",
              style: TextStyle(
                  fontFamily: "poppinz",
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}