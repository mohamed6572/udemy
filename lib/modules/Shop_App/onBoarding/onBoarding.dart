import 'package:flutter/material.dart';
import 'package:gps_tracker/modules/Shop_App/Login/shop_login_screan.dart';
import 'package:gps_tracker/shared/components/components.dart';
import 'package:gps_tracker/shared/network/local/casheHelper.dart';
import 'package:gps_tracker/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String body;
  final String title;

  BoardingModel({
    required this.title,
    required this.body,
    required this.image,
  });
}

class onBoarding extends StatefulWidget {
  @override
  State<onBoarding> createState() => _onBoardingState();
}

class _onBoardingState extends State<onBoarding> {
  List<BoardingModel> boarding = [
    BoardingModel(
        title: 'Screan Title 1',
        body: 'Screan body 1',
        image: 'assets/me.jpeg'),
    BoardingModel(
        title: 'Screan Title 2',
        body: 'Screan body 2',
        image: 'assets/me.jpeg'),
    BoardingModel(
        title: 'Screan Title 3',
        body: 'Screan body 3',
        image: 'assets/me.jpeg'),
  ];

  bool isLast = false ;
  void Submit(){
    casheHelper.SavaData(key: 'onBoarding', value: true).then((value) {
      if(value) {
        navigateToAndFinish(context, ShopLoginScrean());
      }
    });
  }

  var pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defultTextButtton(text: 'skip', function: Submit),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (index){
                  if(index == boarding.length -1){
                    print('last');
                    isLast = true;
                  }else {
                    print('not last');
                    isLast = false;

                  }
                },
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    defultScreanBoard(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: DefultColor,
                    expansionFactor: 4,
                    spacing: 5,
                    dotHeight: 10,
                    dotWidth: 10

                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                   if(isLast){
                     Submit();
                   }else{
                     pageController.nextPage(
                         duration: Duration(milliseconds: 750),
                         curve: Curves.fastLinearToSlowEaseIn);
                   }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  Widget defultScreanBoard(BoardingModel model) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image(
                image: AssetImage(model.image),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              model.title,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              model.body,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      );
}
