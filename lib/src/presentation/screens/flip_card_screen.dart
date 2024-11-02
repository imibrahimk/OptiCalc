import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/flip_card_provider.dart';
import '../../utils/constant/colour.dart';
import '../../utils/constant/custom_text_style.dart';
import '../widgets/id_card/back_side_card.dart';
import '../widgets/id_card/front_side_card.dart';

class FlipCardScreen extends StatelessWidget {
  final Map<String, String> data;

  FlipCardScreen({super.key, required this.data});

  final GlobalKey frontKey = GlobalKey();
  final GlobalKey backKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colour.backGround,
        title: Text(
          'Employee Identity',
          style: CustomTextStyle.titleStyle(Colour.orangeS400),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                final provider =
                    Provider.of<FlipCardProvider>(context, listen: false);
                provider.printCard(context, frontKey, backKey);
              },
              icon: Icon(Icons.print_outlined))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Consumer<FlipCardProvider>(
            builder: (context, state, child) {
              return GestureDetector(
                onTap: () => state.toggleFlip(),
                child: TweenAnimationBuilder(
                  tween:
                      Tween<double>(begin: 0.0, end: state.isFlipped ? 1 : 0),
                  duration: const Duration(milliseconds: 500),
                  builder: (context, value, child) {
                    // Rotate on Y-axis
                    double angle = value * pi;
                    bool isFrontVisible = value < 0.5;
                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(angle),
                      child: isFrontVisible
                          ? FrontSideCard(
                              repaintBoundaryKey: frontKey,
                              data: data,
                            ) // Show the front side of the card
                          : Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationY(
                                  pi), // Fix the mirrored issue on the back
                              child: BackSideCard(
                                repaintBoundaryKey: backKey,
                              ), // Show the back side of the card
                            ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
