import 'package:Yalla_Food/modules/on_boarding/cubit/cubit.dart';
import 'package:Yalla_Food/modules/on_boarding/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/component.dart';
import '../../shared/network/local/cache_helper.dart';

class On_Boarding_Screen extends StatelessWidget {
  const On_Boarding_Screen({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return BlocConsumer<on_boardingCubit, on_boarding_States>(
        builder: (context, state) {
          on_boardingCubit cubit = on_boardingCubit.get(context);
          PageController pageController = PageController();
          return Scaffold(
              appBar: AppBar(
                actions: [
                  dafaultTextButton(
                      text: 'Skip',
                      function: () {
                        cubit.submit(context);
                      })
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                          onPageChanged: (int index) {
                            print(index);
                            cubit.pageChanged(index: index);
                          },
                          scrollDirection: Axis.horizontal,
                          controller: pageController,
                          physics: const BouncingScrollPhysics(),
                          itemCount: cubit.boarding.length,
                          itemBuilder: (context, index) =>
                              onBoardBuilder(cubit.boarding[index])),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        SmoothPageIndicator(
                          controller: pageController,
                          count: cubit.boarding.length,
                          effect: const ExpandingDotsEffect(
                              activeDotColor: Colors.orange,
                              dotHeight: 10,
                              spacing: 5,
                              dotWidth: 10,
                              expansionFactor: 4,
                              dotColor: Colors.grey),
                        ),
                        const Spacer(),
                        FloatingActionButton(
                          onPressed: () {
                            cubit.floatFunction(context,
                                controller: pageController);
                          },
                          child: const Icon(Icons.arrow_forward_ios),
                        )
                      ],
                    )
                  ],
                ),
              ));
        },
        listener: (context, state) {});
  }
}
