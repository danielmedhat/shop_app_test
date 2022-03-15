import 'package:flutter/material.dart';
import 'package:my_test_shop/modules/login.dart';
import 'package:my_test_shop/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<PageModel> myModel = [
    PageModel(
        image: 'images/shop2.png', title: 'ITEM 1', discription: 'discription'),
    PageModel(
        image: 'images/shop3.png',
        title: 'ITEM 2',
        discription: 'discription 2'),
    PageModel(
        image: 'images/shop4.png',
        title: 'ITEM 3',
        discription: 'discription 3')
  ];
  var controller = PageController();
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (isLast == true) {
              closeOnBoarding();
            } else {
              controller.nextPage(
                  duration: Duration(milliseconds: 900),
                  curve: Curves.fastLinearToSlowEaseIn);
            }
          },
          child: Icon(Icons.arrow_forward_ios),
        ),
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  closeOnBoarding();
                },
                child: Text(
                  'Skip',
                  style: TextStyle(fontSize: 20),
                ))
          ],
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  if (index == myModel.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: controller,
                itemBuilder: (context, index) => myItemBuilder(myModel[index]),
                itemCount: myModel.length,
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SmoothPageIndicator(
                    controller: controller,
                    count: myModel.length,
                    effect: ExpandingDotsEffect(),
                  ),
                )
              ],
            )
          ],
        )

        //  Image(image: AssetImage('images/shop1.png'),)

        );
  }

  Widget myItemBuilder(PageModel modela) {
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage('${modela.image}'))),
          SizedBox(
            height: height * 0.07,
          ),
          Text(
            '${modela.title}',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Text(
            '${modela.discription}',
            style: TextStyle(
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }

  void closeOnBoarding() {
    CacheHelper.putData(key: 'onBoarding', value: true).then((value) {
      if (value)
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false);
    });
  }
}

class PageModel {
  final String image;
  final String title;
  final String discription;
  PageModel({
    @required this.image,
    @required this.title,
    @required this.discription,
  });
}
