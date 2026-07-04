import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/local_data/preferences_mangar.dart';
import 'package:news_app/featuers/auth/login_screen.dart';
import 'package:news_app/featuers/models/onboarding_model.dart';
import 'package:news_app/featuers/onpording/controller/onboarding_controller.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  _onFinish(BuildContext context) {
    PreferencesMangar().setBoll("onboarding_complete", true);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return LoginScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => OnboardingController(),
      child: Builder(
        builder: (BuildContext context) {
          final controller = context.read<OnboardingController>();
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFFf5f5f5),
              actions: [
                Consumer<OnboardingController>(
                  builder:
                      (
                        BuildContext context,
                        OnboardingController value,
                        Widget? child,
                      ) {
                        return value.isLastPage
                            ? Container()
                            : TextButton(
                                onPressed: () {
                                  _onFinish(context);
                                },
                                child: Text(
                                  "Skip",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              );
                      },
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 30.0,
                horizontal: 16,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: controller.pageController,
                      onPageChanged: (int index) {
                        context.read<OnboardingController>().onPageChange(
                          index,
                        );
                        //Provider.of<OnboardingController>(context, listen: false).onPageChange(index);
                      },
                      itemCount: OnboardingModel.OnboardingList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final OnboardingModel model =
                            OnboardingModel.OnboardingList[index];
                        return Column(
                          children: [
                            Image.asset(model.image),
                            SizedBox(height: 24),
                            Text(
                              model.title,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: Color(0xFF4E4B66),
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              model.description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Color(0xFF6E7191),
                              ),
                            ),
                            Spacer(),
                          ],
                        );
                      },
                    ),
                  ),
                  Consumer<OnboardingController>(
                    builder: (BuildContext context, value, Widget? child) {
                      return SmoothPageIndicator(
                        controller: value.pageController,
                        count: 3,
                        effect: SwapEffect(activeDotColor: Color(0xFFC53030)),
                      );
                    },
                  ),

                  SizedBox(height: 112),
                  Consumer<OnboardingController>(
                    builder: (BuildContext context, value, Widget? child) {
                      return ElevatedButton(
                        onPressed: () {
                          if (!value.isLastPage) {
                            controller.pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            _onFinish(context);
                          }
                        },
                        child: Text(value.isLastPage ? "Get Started" : "Next"),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
