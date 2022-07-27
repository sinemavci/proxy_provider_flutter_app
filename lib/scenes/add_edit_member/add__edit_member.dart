import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trial/config/member_provider.dart';
import 'package:trial/network/models/members/member_model.dart';

class AddEditMember extends StatelessWidget {
  final MemberModel? member;
  final int? index;

  AddEditMember({Key? key, this.member, this.index}) : super(key: key);

  String email = "exp";
  String username = "exp1@gmail.com";

  Future<void> addMember(BuildContext context) async {
    Provider.of<MemberProvider>(context, listen: false).addMember(username, email);
    Navigator.of(context).pop();
  }

  void deleteMember(BuildContext context) {
    Provider.of<MemberProvider>(context, listen: false).deleteMember(index ?? 0);
    Navigator.of(context).pop();
  }

  Future<void> updateMember(BuildContext context) async {
    Provider.of<MemberProvider>(context, listen: false).updateMember(
      index ?? 0,
      username,
      email,
      member?.marked,
    );

    Navigator.of(context).pop();
  }

  Widget btn(String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(color: Colors.blueGrey),
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget btnContainer(BuildContext context) {
    if (member != null) {
      return Column(children: [
        btn('UPDATE', () => updateMember(context)),
        btn('DELETE', () => deleteMember(context)),
      ]);
    }
    return btn('ADD', () => addMember(context));
  }

  Widget appBarTitle() {
    if (member != null) {
      return const Text('UPDATE MEMBER');
    }
    return const Text('ADD MEMBER');
  }

  Widget bodyContainer(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormField(
          initialValue: member?.username,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'username',
          ),
          onChanged: (val) => {username = val},
        ),
        const SizedBox(
          height: 32,
        ),
        TextFormField(
          initialValue: member?.email,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'email',
          ),
          onChanged: (val) => {email = val},
        ),
        btnContainer(context)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: appBarTitle()),
      body: bodyContainer(context),
    );
  }
}
