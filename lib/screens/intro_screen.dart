import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final PageController _controller = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
                print("$index, $onLastPage");
              });
            },
            children: [
              Container(
                height: 100,
                child: Image.asset('assets/second.jpg'),
              ),
              Container(
                height: 100,
                child: Image.asset('assets/one.jpg'),
              ),
              Container(
                height: 100,
                child: Image.asset('assets/three.jpg'),
              ),
            ]),
        Container(
          alignment: const Alignment(0, 0.85),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'tasks');
                },
                child: const Text(
                  'skip',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: const SwapEffect(
                    dotColor: Colors.blue,
                    activeDotColor: Colors.grey,
                    type: SwapType.yRotation),
              ),
              onLastPage
                  ? GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'tasks');
                      },
                      child: const Text(
                        'done',
                        style: TextStyle(color: Colors.grey),
                      ))
                  : GestureDetector(
                      onTap: () {
                        _controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                      child:
                          const Icon(Icons.arrow_forward, color: Colors.grey),
                    )
            ],
          ),
        )
      ],
    ));
  }
}
