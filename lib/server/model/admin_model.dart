class AdminModel {
  String email = '';
  String uid = '';
  String fcm = '';
  String password = '';
  bool isActive = true;
  DateTime created = DateTime.now();
  DateTime lastUpdated = DateTime.now();

  AdminModel();

  AdminModel.add({
    required this.uid,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};

    map['uid'] = uid;
    map['fcm'] = fcm;
    map['email'] = email;
    map['password'] = password;
    map['isActive'] = true;
    map['created'] = DateTime.now();
    map['lastUpdated'] = DateTime.now();

    return map;
  }

  Map<String, dynamic> toMapSaveData(AdminModel admin) {
    Map<String, dynamic> map = <String, dynamic>{};

    map['uid'] = admin.uid;
    map['fcm'] = admin.fcm;
    map['email'] = admin.email;
    map['password'] = admin.password;
    map['isActive'] = admin.isActive;
    map['created'] = admin.created.toString();
    map['lastUpdated'] = admin.lastUpdated.toString();

    return map;
  }

  AdminModel.fromMap(Map<String, dynamic> map) {
    uid = map['uid'];
    fcm = map['fcm'];
    email = map['email'];
    password = map['password'];
    isActive = map['isActive'];

    created = map['created'].toDate();
    lastUpdated = map['lastUpdated'].toDate();
  }
}
