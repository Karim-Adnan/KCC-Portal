import 'package:KCC_Portal/components/onboarding_components/provider/offset_notifier.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class OnboardingKYC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: size.width * 1,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Consumer<OffsetNotifier>(
                builder: (context, notifier, child) {
                  return Transform.scale(
                    scale: math.max(0, 1 - (1 - (4 * notifier.page - 7))),
                    child: child,
                  );
                },
                child: Container(
                  height: size.width * 0.65,
                  width: size.width * 0.65,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey.withOpacity(0.1),
                        offset: Offset(0, 0),
                        blurRadius: 20.0,
                        spreadRadius: 1.0,
                      ),
                    ],
                  ),
                ),
              ),
              Consumer<OffsetNotifier>(
                builder: (context, notifier, child) {
                  return Transform(
                    alignment: FractionalOffset.center,
                    transform: Matrix4.translationValues(
                        0, 100 * (1 - (4 * notifier.page - 7)), 0)
                      ..rotateZ((-math.pi / 2) * 2 * notifier.page),
                    child: child,
                  );
                },
                child: Image.asset("assets/illustrations/onboarding/onboardingKYC.png"),
              ),
            ],
          ),
        ),
        SizedBox(
          height: size.width * 0.075,
        ),
        Consumer<OffsetNotifier>(
          builder: (context, notifier, child) {
            return Transform.translate(
              offset: Offset(0, 50 * (1 - (4 * notifier.page - 7))),
              child: child,
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Know Your College",
                style: GoogleFonts.robotoSlab(
                  fontSize: size.width * 0.06,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(
                height: size.width * 0.036,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.065),
                child: Text(
                  "description is a line made of words to explain the usage of a certain thing or task",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    color: Colors.black.withOpacity(0.4),
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
