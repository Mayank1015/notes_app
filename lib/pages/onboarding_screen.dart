import 'onboard_pages.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/services/spf.dart';
import 'package:notes_app/pages/home_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _pageController = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              isLastPage = index == 2;
            });
          },
          children: const [
            OnBoardPages(
              title: "Welcome to the Notes App",
              imgUrl: "assets/img1.jpg",
              subTitle: "A Universe of Notes Awaits Your Imagination",
            ),
            OnBoardPages(
              title: "Add Ideas Instantly, Never Miss a Thought",
              imgUrl: "assets/img3_manage.jpg",
              subTitle: "Add new notes with just a few taps",
            ),
            OnBoardPages(
              title: "Manage your notes easily",
              imgUrl: "assets/img2_del.jpg",
              subTitle: "Swipe to delete unwanted notes\nTap to edit",
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                foregroundColor: Colors.black,
                backgroundColor: Colors.yellow,
                minimumSize: const Size.fromHeight(80),
              ),
              onPressed: () {
                SPF.prefs.setBool("isLoggedIn", true);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyHomePage(),
                  ),
                );
              },
              child: const Text(
                "Get Started",
                style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 0.5,
                ),
              ),
            )
          : Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_circle_left_outlined,
                      size: 50,
                    ),
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: 3,
                      effect: const WormEffect(
                          spacing: 16,
                          dotColor: Colors.black26,
                          activeDotColor: Colors.black54),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_circle_right_outlined,
                      size: 50,
                      // color: Colors.yellow,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
