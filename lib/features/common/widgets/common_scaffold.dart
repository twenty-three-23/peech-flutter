import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swm_peech_flutter/features/common/widgets/custom_bottom_navigation.dart';

class CommonScaffold extends StatefulWidget {
  final String? appBarTitle;
  final Widget child;
  final Function()? backAction;
  final Widget? bottomNavigationBar;
  final bool hideAppBar;
  final bool hideBackButton;

  CommonScaffold({
    super.key,
    this.appBarTitle,
    required this.child,
    this.backAction,
    this.bottomNavigationBar,
    this.hideAppBar = false,
    this.hideBackButton = false,
  });

  @override
  State<CommonScaffold> createState() => _CommonScaffoldState();
}

class _CommonScaffoldState extends State<CommonScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: widget.bottomNavigationBar,
      appBar: widget.hideAppBar == true
          ? null
          : AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              title: SizedBox(
                height: 56,
                child: Stack(
                  children: [
                    if (widget.appBarTitle != null)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            if (widget.hideBackButton == false)
                              IconButton(
                                  onPressed: () {
                                    if (widget.backAction == null) {
                                      Navigator.of(context).pop();
                                    } else {
                                      widget.backAction!();
                                    }
                                  },
                                  icon: const Icon(Icons.arrow_back_ios)),
                            Text(widget.appBarTitle ?? '',
                                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Color(0xFF3B3E43), height: 34 / 22)),
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
      body: SafeArea(child: widget.child),
    );
  }
}
