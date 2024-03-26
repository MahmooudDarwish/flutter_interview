import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_interview/core/util/string_constance.dart';

class FirebaseService {
  static final CollectionReference _collectionReference = FirebaseFirestore
      .instance
      .collection(StringConstance.personCollectionName);

  FirebaseService._();

  static Future<void> addData(Map<String, dynamic> data) async {
    try {
      await _collectionReference.add(data);
    } catch (e) {
      rethrow;
    }
  }

  static Future<QuerySnapshot<Object?>?> getData() async {
    try {
      return await _collectionReference.get();
    } catch (e) {
      return null;
    }
  }
}
