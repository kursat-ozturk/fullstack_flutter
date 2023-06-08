import 'package:flutter/material.dart';
import 'package:fullstack_flutter/models/bottom_bar_item.dart';

import '../models/model.dart';

class FlutterBankBottomBar extends StatelessWidget {
  const FlutterBankBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    var bottomItems = Utils.getBottomBarItems(context);

    return Container(
      height: 100,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Utils.mainThemeColor.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset.zero,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          bottomItems.length,
          (index) {
            FlutterBankBottomBarItem bottomItem = bottomItems[index];

            return Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                highlightColor: Utils.mainThemeColor.withOpacity(0.2),
                splashColor: Utils.mainThemeColor.withOpacity(0.1),
                onTap: () {
                  bottomItem.action!();
                },
                child: Container(
                  constraints: BoxConstraints(minWidth: 80),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(bottomItem.icon,
                          color: Utils.mainThemeColor, size: 20),
                      Text(
                        bottomItem.label!,
                        style: TextStyle(
                            color: Utils.mainThemeColor, fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
