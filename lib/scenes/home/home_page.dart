import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trial/config/filter_provider.dart';
import 'package:trial/config/member_provider.dart';
import 'package:trial/scenes/count/count.dart';
import 'package:trial/scenes/members/members.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  var selectedIndex = 0;

  void onTabChanged(int value, BuildContext context) {
    setState(() {
      selectedIndex = value;
    });
  }

  void markAllMember() {
    Provider.of<MemberProvider>(context, listen: false).markAllMember();
    Navigator.of(context).pop();
  }

  void deleteAllMember() {
    Provider.of<MemberProvider>(context, listen: false).deleteAllMember();
    Navigator.of(context).pop();
  }

  PopupMenuEntry popFilterMenuItem(BuildContext context, String text, int value) {
    return PopupMenuItem(
      child: Text(text,
          style: TextStyle(
            color: Provider.of<MemberProvider>(context, listen: false).selectedFilter == value
                ? Colors.blue
                : Colors.black,
          )),
      value: value,
    );
  }

  PopupMenuButton popActionMenuItems(BuildContext context) {
    return PopupMenuButton(
        itemBuilder: (context) => [
              PopupMenuItem(
                child: InkWell(
                  child: const Text("Mark All Member"),
                  onTap: markAllMember,
                ),
              ),
              PopupMenuItem(
                child: InkWell(
                  child: const Text("Clear All Member"),
                  onTap: deleteAllMember,
                ),
              ),
            ]);
  }

  List<Widget> actions() {
    if (selectedIndex == 0) {
      return [
        PopupMenuButton(
            onSelected: (value) async {
              Provider.of<FilterProvider>(context, listen: false).selectFilter(value);
            },
            icon: const Icon(Icons.filter_list_outlined),
            itemBuilder: (context) => [
                  popFilterMenuItem(context, "Show All", 0),
                  popFilterMenuItem(context, "Show Marked", 1),
                  popFilterMenuItem(context, "Show Unmarked", 2),
                ]),
        popActionMenuItems(context),
      ];
    } else {
      return [
        popActionMenuItems(context),
      ];
    }
  }

  Widget bodyContainer() {
    if (selectedIndex == 0) {
      return const Members();
    } else {
      return const Count();
    }
  }

  Widget bottomBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: selectedIndex == 0 ? Colors.blue : Colors.grey,
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.hdr_strong,
            color: selectedIndex == 1 ? Colors.blue : Colors.grey,
          ),
          label: "",
        ),
      ],
      onTap: (value) => onTabChanged(value, context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Inherited Widget App"),
        automaticallyImplyLeading: false,
        actions: actions(),
      ),
      bottomNavigationBar: bottomBar(),
      body: bodyContainer(),
    );
  }
}
