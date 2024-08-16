import 'package:flutter/material.dart';
import 'package:todo_list_app/ui/task/create_task.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> _pages = [
    Container(),
    Container(),
    Container(),
    Container(),
    Container(),
  ];
  int _currentPage = 0;
  @override
  void initState() {
    super.initState();

    _pages = [
      Container(
        color: Colors.red,
      ),
      Container(
        color: Colors.blue,
      ),
      Container(
        color: Colors.green,
      ),
      Container(
        color: Colors.yellow,
      ),
      Container(
        color: Colors.purple,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: _pages[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF363636),
        unselectedItemColor: Colors.white,
        selectedItemColor: const Color(0xFF8687E7),
        // always show all labels
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentPage,
        onTap: (index) {
          if (index == 2) {
            return;
          }
          setState(() {
            _currentPage = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/tab_bar_home.png',
              width: 24,
              height: 24,
              fit: BoxFit.fill,
            ),
            label: 'Index',
            backgroundColor: Colors.transparent,
            activeIcon: Image.asset(
              'assets/images/tab_bar_home.png',
              width: 24,
              height: 24,
              fit: BoxFit.fill,
              color: const Color(0xFF8687E7),
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/tab_bar_calendar.png',
              width: 24,
              height: 24,
              fit: BoxFit.fill,
            ),
            activeIcon: Image.asset(
              'assets/images/tab_bar_calendar.png',
              width: 24,
              height: 24,
              fit: BoxFit.fill,
              color: const Color(0xFF8687E7),
            ),
            label: 'Calendar',
            backgroundColor: Colors.transparent,
          ),
          BottomNavigationBarItem(
              icon: Container(),
              label: "",
              backgroundColor: Colors.transparent),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/tab_bar_clock.png',
              width: 24,
              height: 24,
              fit: BoxFit.fill,
            ),
            activeIcon: Image.asset(
              'assets/images/tab_bar_clock.png',
              width: 24,
              height: 24,
              fit: BoxFit.fill,
              color: const Color(0xFF8687E7),
            ),
            label: 'Focuse',
            backgroundColor: Colors.transparent,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/tab_bar_user.png',
              width: 24,
              height: 24,
              fit: BoxFit.fill,
            ),
            activeIcon: Image.asset(
              'assets/images/tab_bar_user.png',
              width: 24,
              height: 24,
              fit: BoxFit.fill,
              color: const Color(0xFF8687E7),
            ),
            label: 'Profile',
            backgroundColor: Colors.transparent,
          ),
        ],
      ),
      floatingActionButton: Container(
        width: 64,
        height: 64,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF8687E7),
        ),
        child: IconButton(
          onPressed: () {
            _onCreateTask();
          },
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      // move floatingActionButton to center
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _onCreateTask() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: const CreateTaskPage(),
        );
      },
    );
  }
}
