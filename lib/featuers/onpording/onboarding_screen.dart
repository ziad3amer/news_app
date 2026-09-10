import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider, BlocBuilder;
import 'package:news_app/core/constans/app_size.dart';
import 'package:news_app/core/datasource/local_data/preferences_mangar.dart';
import 'package:news_app/featuers/auth/login_screen.dart';
import 'package:news_app/featuers/models/onboarding_model.dart';
import 'package:news_app/featuers/onpording/controller/onboarding_controller.dart';
import 'package:news_app/featuers/onpording/cubit/onpording_cubit.dart';
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
    return BlocProvider(
      create: (BuildContext context) => OnpordingCubit(),
      child: Builder(
        builder: (BuildContext context) {
          final controller = context.read<OnpordingCubit>();
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFFf5f5f5),
              actions: [
                BlocBuilder<OnpordingCubit, OnbordindState>(
                  builder: ( context, state) {
                    return state.isLastPage
                        ? Container()
                        : TextButton(
                            onPressed: () {
                              _onFinish(context);
                            },
                            child: Text(
                              "Skip",
                              style: TextStyle(
                                fontSize: AppSize.sp16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          );
                  },
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                vertical: AppSize.h30,
                horizontal: AppSize.w16,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: controller.pageController,
                      onPageChanged: (int index) {
                        context.read<OnpordingCubit>().onPageChange(index);
                        //Provider.of<OnboardingController>(context, listen: false).onPageChange(index);
                      },
                      itemCount: OnboardingModel.OnboardingList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final OnboardingModel model =
                            OnboardingModel.OnboardingList[index];
                        return Column(
                          children: [
                            Image.asset(model.image),
                            SizedBox(height: AppSize.ph24),
                            Text(
                              model.title,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: AppSize.sp20,
                                color: Color(0xFF4E4B66),
                              ),
                            ),
                            SizedBox(height: AppSize.ph12),
                            Text(
                              model.description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: AppSize.sp16,
                                color: Color(0xFF6E7191),
                              ),
                            ),
                            Spacer(),
                          ],
                        );
                      },
                    ),
                  ),
                  BlocBuilder<OnpordingCubit,OnbordindState>(
                    builder: ( context,state) {
                      return SmoothPageIndicator(
                        controller: context.read<OnpordingCubit>().pageController,
                        count: 3,
                        effect: SwapEffect(activeDotColor: Color(0xFFC53030)),
                      );
                    },
                  ),

                  SizedBox(height: AppSize.ph112),
                  BlocBuilder<OnpordingCubit,OnbordindState>(
                    builder: ( context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          if (!state.isLastPage) {
                            controller.pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            _onFinish(context);
                          }
                        },
                        child: Text(state.isLastPage ? "Get Started" : "Next"),
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
