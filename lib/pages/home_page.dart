import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animations/animations.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:lottie/lottie.dart';
import 'package:thr_app/colors.dart';
import 'package:thr_app/model/money_model.dart';

import '../mixin/draw_star_mixin.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with DrawStarMixin {
  late ConfettiController _controllerCenter;

  @override
  void initState() {
    super.initState();
    _controllerCenter = ConfettiController(
      duration: const Duration(seconds: 10),
    );
    if (_isFinished) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  bool _isClicked = false;
  String _text = 'Rp. 0';

  final Random _random = Random();

  bool _isFinished = false;

  final TextStyle _defaultTextStyle = const TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
          child: OpenContainer(
        transitionType: ContainerTransitionType.fadeThrough,
        closedBuilder: (context, action) {
          return _closeContainer(action, context);
        },
        openBuilder: (context, action) => _openContainer(),
      )),
    );
  }

  _closeContainer(VoidCallback action, BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 500),
            alignment: _isFinished ? Alignment.topLeft : Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 70, left: 24),
              child: AnimatedTextKit(
                isRepeatingAnimation: false,
                onFinished: () {
                  setState(() {
                    _isFinished = true;
                  });
                },
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Ayo dapatkan THR mu!',
                    textStyle: _defaultTextStyle,
                    textAlign: _isFinished ? TextAlign.left : TextAlign.center,
                    curve: Curves.easeInOutCubic,
                    speed: const Duration(milliseconds: 250),
                  ),
                ],
                totalRepeatCount: 4,
                pause: const Duration(milliseconds: 500),
                displayFullTextOnTap: true,
              ),
            ),
          ),
          if (_isFinished)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Animate(
                    effects: const [
                      FadeEffect(
                        duration: Duration(milliseconds: 500),
                      ),
                      ScaleEffect(
                        duration: Duration(milliseconds: 500),
                      )
                    ],
                    child: Image.asset(
                      'assets/eid.png',
                      width: double.infinity,
                      height: 200,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Animate(
                    effects: const [
                      FadeEffect(
                        duration: Duration(milliseconds: 800),
                      ),
                      ScaleEffect(
                        duration: Duration(milliseconds: 800),
                      )
                    ],
                    child: Container(
                      width: double.infinity,
                      height: 55,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: NeumorphicButton(
                        onPressed: () {
                          action();
                        },
                        style: const NeumorphicStyle(
                          depth: 10,
                          border: NeumorphicBorder(
                            isEnabled: true,
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Mulai',
                            style: TextStyle(
                              color: NeumorphicTheme.defaultTextColor(context),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }

  _openContainer() {
    return StatefulBuilder(
      builder: (context, setState) => SafeArea(
        child: Container(
          color: kBackgroundColor,
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 100, left: 24),
                width: 250.0,
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 24.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  child: !_isClicked
                      ? AnimatedTextKit(
                          repeatForever: true,
                          animatedTexts: [
                            FadeAnimatedText('Ada 8 pilihan hadiah!',
                                duration: const Duration(milliseconds: 3000)),
                            FadeAnimatedText('Pilih salah satu...',
                                duration: const Duration(milliseconds: 3000)),
                            FadeAnimatedText('Semoga kamu beruntung!',
                                duration: const Duration(milliseconds: 3000)),
                          ],
                        )
                      : Text('Selamat kamu dapat uang sebesar $_text'),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Lottie.network(
                  'https://assets5.lottiefiles.com/packages/lf20_9zddpfah.json',
                  height: 200,
                  fit: BoxFit.fill,
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _controllerCenter,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: true,
                  colors: const [
                    Colors.green,
                    Colors.blue,
                    Colors.pink,
                    Colors.orange,
                    Colors.purple,
                    Colors.black,
                  ],
                  createParticlePath: drawStar,
                ),
              ),
              Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20,
                  runSpacing: 30,
                  children: List.generate(moneyList.length, (index) {
                    int randomValue = _random.nextInt(8);
                    List<Color> colors = [
                      kPrimaryColor,
                      kSecondaryColor,
                      kThirdColor,
                      kPrimaryColor,
                      kSecondaryColor,
                      kThirdColor,
                      Colors.black,
                      kBackgroundColor,
                    ];
                    return NeumorphicButton(
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        boxShape: const NeumorphicBoxShape.circle(),
                        depth: 10,
                        color: colors[randomValue],
                      ),
                      onPressed: () {
                        _controllerCenter.stop();
                        setState(() {
                          _isClicked = false;
                          _text = '';
                        });
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.noHeader,
                          animType: AnimType.bottomSlide,
                          bodyHeaderDistance: 10,
                          body: Column(
                            children: List.generate(
                              moneyList[index].count,
                              (index) => Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: Image.asset(
                                  'assets/uang.jpg',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          btnOkOnPress: () {
                            setState(() {
                              _isClicked = true;
                              _text = moneyList[index].money;
                            });
                            _controllerCenter.play();
                          },
                          btnOkIcon: Icons.check_circle,
                        ).show();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'Rp.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
