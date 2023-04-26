import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  final String? uid;
  DatabaseServices({this.uid});

  // create Collection ref.

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");

  // saving user data
  Future savingUserData(String fullName, String email) async {
    return await userCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "groups": [],
      "profilPic": "",
      "uid": uid
    });
  }

  // getting user data

  Future gettingUserData(email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  //getting user groups
  Future gettingUserGroups() async {
    return userCollection.doc(uid).snapshots();
  }

  // creating a group
  Future creatingGroup(String userName, String id, String groupName) async {
    DocumentReference groupDocRef = await groupCollection.add({
      "admin": "${id}_$userName",
      "groupName": groupName,
      "groupId": "",
      "groupPic": "",
      "members": [],
      "recentMessage": "",
      "recentMessageSender": "",
    });

    // update members and group id for a new group
    await groupDocRef.update({
      "members": FieldValue.arrayUnion(["${uid}_$userName"]),
      "groupId": groupDocRef.id
    });

    //update groups in user data

    await userCollection.doc(uid).update({
      "groups": FieldValue.arrayUnion(["${groupDocRef.id}_$groupName"]),
    });
  }

  // deleting a group
  Future deletingGroup(String groupId, String groupName) async {
    // remove a group from user data
    await userCollection.doc(uid).update({
      "groups": FieldValue.arrayRemove(["${groupId}_$groupName"]),
    });

    // remove group from groups collection
    await groupCollection.doc(groupId).delete();
  }

  //getGroupAdmin
  Future gettingGroupAdmin(String groupId) async {
    DocumentSnapshot doc = await groupCollection.doc(groupId).get();
    return doc["admin"];
  }

  //getChats
  Future gettingChats(String groupId) async {
    return groupCollection
        .doc(groupId)
        .collection("messages")
        .orderBy("time")
        .snapshots();
  }

  //getting user groups
  Future gettingGroupMembers(String groupId) async {
    return groupCollection.doc(groupId).snapshots();
  }

  //getting user groups
  Future searchingByGroupName(String groupName) async {
    return groupCollection.where("groupName", isEqualTo: groupName).get();
  }

  //getting user groups
  Future<bool> isUserJoined(String groupName) async {
    DocumentReference docRef = userCollection.doc(uid);
    DocumentSnapshot snapshot = await docRef.get();

    List<String> groups = await snapshot["groups"];

    List<String> groupsName = [];

    for (var element in groups) {
      String name = element.substring(element.indexOf("_") + 1);
      groupsName.add(name);
    }

    if (groupsName.contains(groupName)) {
      return true;
    } else {
      return false;
    }
  }
}
