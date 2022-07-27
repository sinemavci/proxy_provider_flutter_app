import 'package:hive_flutter/hive_flutter.dart';
import 'package:trial/network/models/filter/filter_model.dart';
import 'package:trial/network/models/members/member_model.dart';

class MemberRepository {
  Future<void> initMember() async {
    final box = await Hive.openBox("mainBox");

    final member_1 = MemberModel(username: "George Bluth", email: "gearge_bluth@regres.in");

    final member_2 = MemberModel(username: "Janet Weaver", email: "janet_weaver@regres.in");

    final member_3 = MemberModel(username: "Emma Wrong", email: "emma_wrong@regres.in");

    final member_4 = MemberModel(username: "Eve Holt", email: "eve_holt@regres.in");

    final member_5 = MemberModel(username: "Charles Morris", email: "charles_morris@regres.in");

    List<MemberModel> memberlist = [member_1, member_2, member_3, member_4, member_5];

    box.put("memberlist", memberlist);

    FilterModel filter = FilterModel(type: FilterTypes.all.index);

    box.put("selectedFilter", filter);
  }
}
