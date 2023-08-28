import 'package:cloud_firestore/cloud_firestore.dart';

class DataModel {
  final String? id;
  final String? title;
  final String? description;
  bool? flag;

  DataModel({
    this.id,
    this.title,
    this.description,
    this.flag,
  });

  factory DataModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    // Assuming you're iterating through the documents in the snapshot
    final data = snapshot.data();
    return DataModel(
      id: snapshot.id,
      title: data?['title'],
      description: data?['description'],
      flag: data?['flag'],
    );
  }

  Map<String, dynamic> toFirestore() {
    final map = Map<String, dynamic>();
    if (title != null) map['title'] = title;
    if (description != null) map['description'] = description;
    if (flag != null) map['flag'] = flag;
    return map;
  }
}
