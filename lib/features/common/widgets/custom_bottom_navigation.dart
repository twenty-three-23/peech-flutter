import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatefulWidget {
  final Function(int) onTap; // Tap handler function
  final int initialIndex;

  CustomBottomNavigation({
    Key? key,
    required this.initialIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState(initialIndex: initialIndex);
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  int _currentIndex;

  _CustomBottomNavigationState({required int initialIndex}) : _currentIndex = initialIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xFF000000).withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index; // Update the state to reflect the new index
            });
            widget.onTap(index); // Call the provided onTap handler
          },
          unselectedItemColor: const Color(0xFFA0A3AE),
          selectedItemColor: const Color(0xFFFF5468),
          backgroundColor: Color(0xFFFFFFFF),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history_edu),
              label: '기록',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '프로필',
            ),
          ],
        ),
      ),
    );
  }
}
