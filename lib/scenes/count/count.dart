import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trial/config/member_provider.dart';

class Count extends StatelessWidget {
  const Count({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<MemberProvider, List>(
        selector: (_, provider) {
          String count = provider.memberList.length.toString();

          String markedCount = provider.markedMemberList.length.toString();
          return [count, markedCount];
        },
        shouldRebuild: (previous, next) => true,
        builder: (context, instance, child) {
          return Scaffold(
            body: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "members count:  " + instance[0],
                    ),
                    Text(
                      "marked members count:  " + instance[1],
                    ),
                  ],
                )),
          );
        });
  }
}
