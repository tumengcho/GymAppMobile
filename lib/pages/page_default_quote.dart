import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gymapp/utils/utils_class.dart';

class QuotePage extends StatefulWidget {
  const QuotePage({super.key});

  @override
  State<QuotePage> createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  Map<String, dynamic>? quote;

  @override
  void initState() {
    super.initState();
    getQuote();
  }

  void getQuote() async {
    quote = await Utils.getRandomMotivationQuote();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              opacity: 0.6,
              fit: BoxFit.cover,
              image: AssetImage("assets/images/fond_quote_page.jpg"))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularCountDownTimer(
                  duration: 10,
                  initialDuration: 0,
                  controller: CountDownController(),
                  width: 20,
                  height: 20,
                  ringColor: Colors.grey[300]!,
                  ringGradient: null,
                  fillColor: const Color(0xFFD3FF55),
                  fillGradient: null,
                  backgroundColor: Colors.transparent,
                  backgroundGradient: null,
                  strokeWidth: 2,
                  strokeCap: StrokeCap.round,
                  textStyle: const TextStyle(
                      fontSize: 33.0,
                      color: Color(0xFFD3FF55),
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  textFormat: CountdownTextFormat.S,
                  isReverse: true,
                  isReverseAnimation: false,
                  isTimerTextShown: true,
                  autoStart: true,
                  onComplete: () {
                    Navigator.pushReplacementNamed(context, "/home");
                  },
                  timeFormatterFunction: (defaultFormatterFunction, duration) {
                    return "";
                  },
                ),
              ],
            ),
          ),
          Container(
            height: 350,
            padding: const EdgeInsets.only(top: 140),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.transparent, Color(0xFF323230)],
                    begin: Alignment(-1, -1),
                    end: Alignment(-0.83, 0.0),
                    stops: [0.55, 0.55])),
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: quote != null ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(fontSize: 20, color: Colors.white),
                          children: [
                            TextSpan(
                              text: quote!["quote"].split(quote!["important"])[0],
                              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)
                            ),
                            TextSpan(
                              text: quote!["important"],
                              style: const TextStyle(color: Color(0xFFD3FF55), fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            quote!["quote"].split(quote!["important"]).length > 1? TextSpan(
                              text: " "+quote!["quote"].split(quote!["important"])[1],
                                style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)

                            ):const TextSpan(),
                          ],
                        ),
                      ).animate().fadeIn().shimmer()
                      ,

                  Text(
                    quote!["author"] ?? "",
                    style: const TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w900,
                        fontSize: 18),
                  ).animate().fadeIn(duration: 500.ms, delay: 100.ms),
                ],
              ):const Center(child: CircularProgressIndicator(color: Color(0xFFD3FF55),),),
            ),
          )
        ],
      ),
    );
  }
}
