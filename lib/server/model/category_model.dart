class CategoryModel {
  String uid = '';
  String name = 'مثال (بيتزا)';
  String image = '';
  String color = '';
  bool visible = true;
  dynamic created = DateTime.now();
  dynamic lastUpdated = DateTime.now();

  CategoryModel();

  CategoryModel.add(
      {required this.uid,
      required this.name,
      required this.image,
      required this.color});
  CategoryModel.update(
      {required this.uid,
      required this.name,
      required this.visible,
      required this.image,
      required this.created,
      required this.color});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};

    map['uid'] = uid;
    map['name'] = name;
    map['image'] = image;
    map['visible'] = visible;
    map['color'] = color;
    map['created'] = DateTime.now();
    map['lastUpdated'] = DateTime.now();

    return map;
  }

  Map<String, dynamic> toMapUpdate() {
    Map<String, dynamic> map = <String, dynamic>{};

    map['uid'] = uid;
    map['name'] = name;
    map['image'] = image;
    map['visible'] = visible;
    map['color'] = color;
    map['created'] = created;
    map['lastUpdated'] = DateTime.now();

    return map;
  }

  Map<String, dynamic> toMapSaveLocal() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['uid'] = uid.toString();
    map['name'] = name.toString();
    map['image'] = image.toString();
    map['visible'] = visible;
    map['color'] = color.toString();
    map['created'] = created.toString();
    map['lastUpdated'] = lastUpdated.toString();
    return map;
  }

  CategoryModel.fromMap(Map<String, dynamic> map) {
    uid = map['uid'];
    visible = map['visible'];
    name = map['name'];
    image = map['image'];
    color = map['color'];
    created = map['created'].toDate();
    lastUpdated = map['lastUpdated'].toDate();
  }

  CategoryModel.fromMapToSaveInLocal(Map<String, dynamic> map) {
    uid = map['uid'];
    visible = map['visible'];
    name = map['name'];
    image = map['image'];
    color = map['color'];
    created = map['created'].toDate();
    lastUpdated = map['lastUpdated'].toDate();
  }

  String categoryAsString() {
    return name;
  }

  static CategoryModel categoryModelSnapshot(var documentSnapshot) {
    CategoryModel appModel = CategoryModel.update(
        uid: documentSnapshot['uid'],
        visible: documentSnapshot['visible'],
        name: documentSnapshot['name'],
        image: documentSnapshot['image'],
        color: documentSnapshot['color'],
        created: documentSnapshot['created']);
    return appModel;
  }
}
