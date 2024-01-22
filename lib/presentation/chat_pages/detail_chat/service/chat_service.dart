import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final CollectionReference chatCollection =
      FirebaseFirestore.instance.collection('chat');

  Future<void> sendMessage(String documentTitle, Map<String, dynamic> message) {
    return chatCollection.doc(documentTitle).collection("2#1#1").add(message);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(
      String documentTitle) {
    return chatCollection.doc(documentTitle).collection("2#1#1").snapshots();
  }
}
