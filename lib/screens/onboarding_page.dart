import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:cvs_information/screens/main_page.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
        child: IntroductionScreen(
            pages: [
              PageViewModel(
                title: '모든 편의점 할인 행사',
                body: '모든 편의점의 1+1, 2+1, 3+1, 덤증정을 어플 하나로 만나보세요.',
                image: buildImage('images/convenience_5.png'),
                decoration: getPageDecoration(),
              ),
              PageViewModel(
                title: '주변 편의점 찾기',
                body: '사용자의 현재 위치를 기반으로 마킹된 주변의 편의점들을 찾아보세요.',
                image: buildImage(''),
                decoration: getPageDecoration(),
              ),
              PageViewModel(
                title: '각 편의점에 맞는 멤버십',
                body: '통신사 멤버십부터 네이버, 카카오 멤버십까지',
                image: buildImage(''),
                decoration: getPageDecoration(),
              ),
              PageViewModel(
                title: '모든 편의점 이벤트',
                body: '이벤트 페이지도 확인해보세요!',
                image: buildImage(''),
                decoration: getPageDecoration(),
              ),
            ],
            done:
                const Text('확인', style: TextStyle(fontWeight: FontWeight.w600)),
            onDone: () => goToHome(context),
            showSkipButton: true,
            skip: const Text('건너뛰기'),
            onSkip: () => goToHome(context),
            next: const Text('다음'),
            dotsDecorator: getDotDecoration(),
            onChange: (index) => {}
            // isProgressTap: false,
            // isProgress: false,
            // showNextButton: false,
            // freeze: true,
            // animationDuration: 600,
            ),
      );

  void goToHome(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainPage()),
      );

  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 350));

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: const Color(0xFFBDBDBD),
        //activeColor: Colors.orange,
        size: const Size(10, 10),
        activeSize: const Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  PageDecoration getPageDecoration() => const PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 20),
        imagePadding: EdgeInsets.all(24),
      );
}
