import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:trial/network/models/members/member_model.dart';

class MemberProvider with ChangeNotifier {
  final Box<dynamic> _db;
  final int selectedFilter;

  MemberProvider(this._db, this.selectedFilter) {
    memberList = _db.get("memberlist");
  }

  List<MemberModel> memberList = [];
  List<MemberModel> markedMemberList = [];
  List<MemberModel> unmarkedMemberList = [];

  int markedMemberCount = 0;

  MemberModel getMember(index) {
    return memberList[index];
  }

  List<MemberModel> getSelectedMembers(BuildContext context) {
    markedMemberList = [];
    unmarkedMemberList = [];

    for (var element in memberList) {
      if (element.marked == true) {
        markedMemberList.add(element);
      }
      if (element.marked != true) {
        unmarkedMemberList.add(element);
      }
    }

    if (selectedFilter == 0) {
      return memberList;
    } else if (selectedFilter == 1) {
      return markedMemberList;
    } else {
      return unmarkedMemberList;
    }
  }

  Future<void> deleteMember(int index) async {
    memberList.removeAt(index);

    notifyListeners();
  }

  Future<void> addMember(String username, String email) async {
    final newMember = MemberModel(username: username, email: email);

    memberList.add(newMember);

    notifyListeners();
  }

  Future<void> updateMember(int index, String username, String email, bool? marked) async {
    final updatedMember = MemberModel(
      username: username,
      email: email,
      marked: marked ?? false,
    );

    memberList[index] = updatedMember;

    notifyListeners();
  }

  Future<void> markMember(int index, bool val) async {
    memberList[index].marked = val;

    notifyListeners();
  }

  Future<void> markAllMember() async {
    for (var element in memberList) {
      element.marked = true;
    }

    notifyListeners();
  }

  Future<void> deleteAllMember() async {
    memberList.clear();

    notifyListeners();
  }
}
