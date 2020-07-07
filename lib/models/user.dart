import 'dart:convert';

class User {
  String username;
  String uid;
  User({
    this.username,
    this.uid,
  });

  User copyWith({
    String username,
    String uid,
  }) {
    return User(
      username: username ?? this.username,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'uid': uid,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return User(
      username: map['username'],
      uid: map['uid'],
    );
  }

  String toJson() => json.encode(toMap());

  static User fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'User(username: $username, uid: $uid)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is User &&
      o.username == username &&
      o.uid == uid;
  }

  @override
  int get hashCode => username.hashCode ^ uid.hashCode;
}
