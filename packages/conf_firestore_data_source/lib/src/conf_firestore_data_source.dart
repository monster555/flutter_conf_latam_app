import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conf_firestore_data_source/src/conf_firestore_data_source_exception.dart';

class ConfFirestoreDataSource {
  ConfFirestoreDataSource({FirebaseFirestore? firestoreInstance})
    : firestore = firestoreInstance ?? FirebaseFirestore.instance;
  final FirebaseFirestore firestore;

  Future<List<Map<String, dynamic>>> getCollection(String path) async {
    try {
      final snapshot = await firestore.collection(path).get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      throw ConfFirestoreDataSourceException('Failed to fetch collection: $e');
    }
  }

  Future<Map<String, dynamic>?> getDocument(String path, String id) async {
    try {
      final doc = await firestore.collection(path).doc(id).get();
      return doc.data();
    } catch (e) {
      throw ConfFirestoreDataSourceException('Failed to fetch document: $e');
    }
  }
}
