import 'package:fitness_app/app_theme.dart';
import 'package:fitness_app/models/tab_icon_data.dart';
import 'package:fitness_app/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';

import 'my_diary_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController animationController;

  List<TabIconData> tabIconList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: AppTheme.background,
  );

  @override
  void initState() {
    tabIconList.forEach((TabIconData data) {
      data.isSelected = false;
    });

    tabIconList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(microseconds: 600), vsync: this);

    tabBody = MyDiaryScreen(animationController:  animationController,);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              } else {
                return Stack(
                  children: <Widget>[tabBody, bottomBar()],
                );
              }
            }),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(microseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          list: tabIconList,
          addClick: () {},
          changeIndex: (int index) {
            if (index == 0 || index == 2) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }

                setState(() {
                  tabBody =
                      MyDiaryScreen(
                        animationController: animationController,
                      );
                });
              });
            } else if (index == 1 || index == 3) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      MyDiaryScreen(
                        animationController: animationController,
                      );
                });
              });
            }
          },
        )
      ],
    );
  }
}
