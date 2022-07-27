import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:trial/config/filter_provider.dart';
import 'package:trial/network/models/filter/filter_model.dart';
import 'package:trial/network/models/members/member_model.dart';
import 'package:trial/network/services/members/member_repository.dart';
import 'package:trial/scenes/home/home_page.dart';

import 'config/member_provider.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MemberModelAdapter());
  Hive.registerAdapter(FilterModelAdapter());
  MemberRepository().initMember();
  final box = await Hive.openBox("mainBox");
  Provider.debugCheckInvalidValueType = null; // BEN BUNU NIYE EKLEMEK ZORUNDAYIM YA
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FilterProvider(),
        ),
        ChangeNotifierProxyProvider<FilterProvider, MemberProvider>(
          create: (context) => MemberProvider(box, 0),
          update: (context, value, previous) => MemberProvider(box, value.selectedFilter),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Provider App',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
