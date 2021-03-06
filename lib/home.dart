import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:scanbot_sdk_example_flutter/pages_repository.dart';
import 'package:flutter/material.dart';

import 'info/generic_app_theme.dart';
import 'info/image_view/image_view_screen.dart';
import 'info/main_screen/home_screen.dart';
import 'pages_repository.dart';
import 'pdfviewcurved/detailsPage.dart';

class AppHomeScreen extends StatefulWidget {
  final PageRepository pR;

  AppHomeScreen(this.pR);

  @override
  AppHomeScreenState createState() => AppHomeScreenState(pR);
}

class AppHomeScreenState extends State<AppHomeScreen>
    with TickerProviderStateMixin {

  AppHomeScreenState(this.pR);
  PageRepository pR;
  AnimationController animationController;
//  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: AppTheme.background,
  );
  @override
  void initState() {
 //   tabIconsList.forEach((TabIconData tab) {
 //     tab.isSelected = false;
//    });
 //   tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = MyDiaryScreen(pR:pR,animationController: animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: _page,
          height: 50.0,
          items: <Widget>[
            Icon(Icons.home, size: 30),
            Icon(Icons.list, size: 30),
            Icon(Icons.book, size: 30),
            Icon(Icons.call_split, size: 30),
            Icon(Icons.perm_identity, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.blueAccent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            if (index==0){
              setState(() {
                tabBody =  MyDiaryScreen(pR:pR,animationController: animationController);
              });
            }
            if (index==2) {
              Navigator.pop(context);

              Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return
                      PdfPreview(pR:pR,animationController: animationController
                      );
                  })
              );
            }
            if (index==1) {

             Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return
                      TrainingScreen(
                          pR: pR, animationController: animationController
                      );
                  })
              );
            }
            setState(() {
              _page = index;
            });
          },
        ),
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  tabBody,
                  //bottomBar(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

/*
  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {
            if (index == 0) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      MyDiaryScreen(animationController: animationController);
                });
              });
            }
            else if (index == 1) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      MyDiaryScreen(animationController: animationController);
                });
              });
            }
            else if (index == 2) {
                animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      MyDiaryScreen(animationController: animationController);
                });
              });
            }
            else if (index == 3) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      PdfPreview(animationController: animationController
                      );
                });
              });
            }
          },
        ),
      ],
    );
  } */
}
