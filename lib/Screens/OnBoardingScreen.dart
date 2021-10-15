import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_app/Screens/LogInScreen.dart';
import 'package:shop_app/Shared/CasheHelper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/1.png',
        title: 'Buying',
        body: 'You can buy your favorite items online '),
    BoardingModel(
        image: 'assets/2.png',
        title: 'delivering ',
        body: 'you can track your product from your home'),
    BoardingModel(
        image: 'assets/3.png',
        title: 'Reciveing ',
        body: 'Congratulations!! Now you can  Recive your product '),
  ];

  var boardController = PageController();
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 60, 25, 30),
        child: Column(
          children: [
            Row(
              children: [
                const Spacer(),
                TextButton(
                  onPressed: () {
                    submit();
                  },
                  child: const Text('SKIP'),
                ),
              ],
            ),
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) =>
                    buildBoardItem(boarding[index]),
                onPageChanged: (int index) {
                  if (index == (boarding.length - 1)) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemCount: boarding.length,
                controller: boardController,
                physics: const BouncingScrollPhysics(),
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    activeDotColor: Colors.blue,
                    spacing: 5,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: const Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void submit() {
    CashHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return LogInScreen();
        }));
      }
    });
  }
}

Widget buildBoardItem(BoardingModel model) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Image(
        image: AssetImage(
          model.image,
        ),
        height: 300,
        width: 320,
      ),
      const SizedBox(
        height: 30,
      ),
      Text(
        model.title,
        style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Text(
        model.body,
        style: const TextStyle(
          fontSize: 18,
          // fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}
