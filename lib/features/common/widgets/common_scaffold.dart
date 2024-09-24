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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: SizedBox(
          height: 56,
          child: Stack(
            children: [
              if (appBarTitle != null)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            if (backAction == null) {
                              Navigator.of(context).pop();
                            } else {
                              backAction!();
                            }
                          },
                          icon: const Icon(Icons.arrow_back_ios)),
                      Text(appBarTitle ?? '', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Color(0xFF3B3E43), height: 34 / 22)),
                    ],
                  ),
                )
              else
                Align(
                  alignment: Alignment.centerLeft,
                  child: SvgPicture.asset(
                    'assets/images/app_bar_logo.svg',
                    semanticsLabel: 'peech app bar logo',
                    height: 25,
                    fit: BoxFit.contain,
                  ),
                ),
            ],
          ),
        ),
      ),
      body: SafeArea(child: child),
    );
  }
}
