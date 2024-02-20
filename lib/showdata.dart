import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class ShowData extends StatefulWidget {
  const ShowData({super.key});

  @override
  State<ShowData> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  Future<void> _deleteDocument(String documentId) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(documentId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Users").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        trailing: IconButton(
                          onPressed: () async {
                            // Get the document ID
                            String documentId =
                                snapshot.data?.docs[index]["Title"];

                            // Delete the document from Firestore
                            await _deleteDocument(documentId);
                            print("Data Deleted");

                            // Refresh the screen by triggering a rebuild
                            setState(() {});
                          },
                          icon: const Icon(Icons.delete),
                        ),
                        leading: CircleAvatar(
                          child: Text("${index + 1}"),
                        ),
                        title: Text("${snapshot.data?.docs[index]["Title"]}"),
                        subtitle: Text(
                            "${snapshot.data?.docs[index]["Description"]}"),
                      );
                    });
              } else if (snapshot.hasError) {
                return Text("${snapshot.hasError.toString()}");
              } else {
                return const Center(child: Text("no data found"));
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
