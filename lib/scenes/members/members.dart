import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trial/config/member_provider.dart';
import 'package:trial/network/models/members/member_model.dart';
import 'package:trial/scenes/add_edit_member/add__edit_member.dart';

class Members extends StatelessWidget {
  const Members({Key? key}) : super(key: key);

  void navigateDetail(BuildContext context, MemberModel member, int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddEditMember(
          member: member,
          index: index,
        ),
      ),
    );
  }

  void onAddMember(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddEditMember(),
      ),
    );
  }

  Widget itemContainer(BuildContext context, int index, MemberModel member) {
    return InkWell(
        onTap: () => navigateDetail(context, member, index),
        child: Column(
          children: [
            Row(
              children: [
                Checkbox(
                    value: member.marked ?? false,
                    onChanged: (val) => Provider.of<MemberProvider>(context, listen: false).markMember(
                          index,
                          val ?? false,
                        )),
                Text(
                  member.username,
                  style: const TextStyle(fontSize: 24),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const Divider(),
            const SizedBox(
              height: 16,
            ),
          ],
        ));
  }

  Widget btnAdd(BuildContext context) => FloatingActionButton(
        onPressed: () => onAddMember(context),
        child: const Icon(Icons.add),
      );

  @override
  Widget build(BuildContext context) {
    // return Container();
    return Selector<MemberProvider, List>(
        selector: (_, provider) {
          return provider.getSelectedMembers(context);
        },
        shouldRebuild: (previous, next) => true,
        builder: (context, instance, child) {
          return Scaffold(
            floatingActionButton: btnAdd(context),
            body: Container(
                margin: const EdgeInsets.all(80),
                child: ListView.builder(
                    itemCount: instance.length,
                    itemBuilder: (context, index) {
                      MemberModel member = instance[index];
                      return itemContainer(context, index, member);
                    })),
          );
        });
  }
}
