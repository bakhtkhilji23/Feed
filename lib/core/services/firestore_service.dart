import 'package:cloud_firestore/cloud_firestore.dart';

/// Handler for Firestore operations
final fireStoreService = FireStoreService();

class FireStoreService {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  void incrementArticleLikes(
      {required int articleId, required bool isLike}) async {
    //create article document first if absent before incrementing
    await firebaseFirestore
        .collection('articles')
        .where('articleID', isEqualTo: articleId)
        .get()
        .then((doc) async {
      if (doc.docs.isEmpty) {
        await firebaseFirestore
            .collection('articles')
            .doc('$articleId')
            .set({'articleID': articleId, 'likes': 0, 'shares': 0});
      }
      await firebaseFirestore
          .collection('articles')
          .doc('$articleId')
          .update({'likes': FieldValue.increment(isLike ? 1 : -1)});
    });
  }

  Stream<DocumentSnapshot> streamArticle({required int articleId}) {
    //create article document first if absent before streaming
    firebaseFirestore
        .collection('articles')
        .where('articleID', isEqualTo: articleId)
        .get()
        .then((doc) async {
      if (doc.docs.isEmpty) {
        await firebaseFirestore
            .collection('articles')
            .doc('$articleId')
            .set({'articleID': articleId, 'likes': 0, 'shares': 0});
      }
    });
    return firebaseFirestore
        .collection('articles')
        .doc('$articleId')
        .snapshots();
  }

  void incrementArticleShare({required int articleId}) async {
    //create article document first if absent before incrementing
    await firebaseFirestore
        .collection('articles')
        .where('articleID', isEqualTo: articleId)
        .get()
        .then((doc) async {
      if (doc.docs.isEmpty) {
        await firebaseFirestore
            .collection('articles')
            .doc('$articleId')
            .set({'articleID': articleId, 'likes': 0, 'shares': 0});
      }
      await firebaseFirestore
          .collection('articles')
          .doc('$articleId')
          .update({'shares': FieldValue.increment(1)});
    });
  }
}
