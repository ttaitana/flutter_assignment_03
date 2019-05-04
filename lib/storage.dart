import 'package:cloud_firestore/cloud_firestore.dart';

class Firestorage{
  static void addTask(String title){
    Firestore.instance.collection('todo').document().setData({'title':title, 'done':false});
  }

  static void update(String id, bool value){
    final DocumentReference postRef = Firestore.instance.document('todo/' + id);
    Firestore.instance.runTransaction((Transaction tx) async {
      DocumentSnapshot postSnapshot = await tx.get(postRef);
      if (postSnapshot.exists) {
        await tx.update(postRef, <String, dynamic>{'done': value});
      }
    });
  }

  static void delAll() async{
    QuerySnapshot query = 
      await Firestore.instance.collection('todo').where('done', isEqualTo: true).getDocuments();
    
    query.documents.forEach((e) => Firestorage.delEach(e.documentID));
  }

  static void delEach(String documentID) {
    final DocumentReference target = Firestore.instance.document('todo/' + documentID);
    
    Firestore.instance.runTransaction((Transaction ts) async {
      DocumentSnapshot post = await ts.get(target);
      if(post.exists){
        await ts.delete(target);
      }
    });
  }


}