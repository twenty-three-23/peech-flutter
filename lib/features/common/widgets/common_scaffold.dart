import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommonScaffold extends StatelessWidget {
  final String? appBarTitle;
  final Widget child;
  final Function()? backAction;
  const CommonScaffold({super.key, this.appBarTitle, required this.child, this.backAction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width > 600
            ? 600
            : MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  height: 56,
                  child: Stack(
                    children: [
                      if(appBarTitle != null)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 11.0),
                            child: Row(
                              children: [
                                IconButton(onPressed: () {
                                    if(backAction == null) {
                                      Navigator.of(context).pop();
                                    }
                                    else {
                                      backAction!();
                                    }
                                  },
                                  icon: const Icon(Icons.arrow_back_ios)
                                ),
                                Text(
                                  appBarTitle ?? '',
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF3B3E43),
                                    height: 34 / 22
                                  )
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.5),
                            child: SvgPicture.asset(
                              'assets/images/app_bar_logo.svg',
                              semanticsLabel: 'peech app bar logo',
                              height: 25,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Expanded(child: child),
            ],
          ),
        ),
      )
    );
  }
}
