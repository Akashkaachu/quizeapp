// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:quizeapp/Hive/hive.dart';
import 'package:quizeapp/graphpage.dart';
import 'package:quizeapp/home.dart';
import 'package:quizeapp/models/questionmodel.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class DisplayPge extends StatefulWidget {
  const DisplayPge({super.key});

  @override
  State<DisplayPge> createState() => _DisplayPgeState();
}

int timerDurationInSeconds = 60;
late Timer timer;
bool isQuizOver = false;

class _DisplayPgeState extends State<DisplayPge> {
  @override
  void initState() {
    getListFromHive();
    isValue = '';
    startTimer();
    super.initState();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        if (timerDurationInSeconds > 0) {
          timerDurationInSeconds--;
        } else {
          isQuizOver = true;
          setState(() {
            index = index + 1;
            getOptions();
            isTrue = false;
            timer.cancel();
            timerDurationInSeconds = 60;
            color.fillRange(0, 4, Colors.white);
          });
          startTimer();
        }
      });
    });
  }

  List<Color> color = List.filled(4, Colors.white);
  bool isTrue = false;
  bool isSubmit = false;
  int count = 0;

  List<QuestionDetails>? get;
  void getListFromHive() async {
    List<QuestionDetails> store = [];
    List<String> isValueList = [];
    final list = await getQuestionDetails();
    setState(() {
      get = list;
    });
    getOptions();
  }

  getOptions() {
    options = [];
    if (get != null) {
      options.addAll([
        get![index].answer,
        get![index].option1,
        get![index].option2,
        get![index].option3
      ]);
    }
    options.shuffle();
    setState(() {});
  }

  List<String> options = [];
  int index = 0;
  setIsValue(String? value) {
    setState(() {
      isValue = value;
    });
  }

  String? isValue;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Quiz"),
          centerTitle: true,
          elevation: 0,
        ),
        drawer: Drawer(
            child: ListView(
          children: [
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HomePge(),
                ));
              },
              title: Text(
                "Add Questions ",
                style: GoogleFonts.poppins(fontSize: 19),
              ),
            )
          ],
        )),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: get == null
              ? SizedBox(
                  height: size.height,
                  child: LottieBuilder.asset(
                      "assets/animations/Animation - 1706356117185.json"),
                )
              : Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey
                              .withOpacity(0.5), // Set the shadow color
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(3, 3),
                          // Set the shadow offset
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(children: [
                      const SizedBox(height: 50),
                      Container(
                        height: 200,
                        width: size.width - 79,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.black,
                              Colors.red,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 29, top: 10),
                                  child: Text(
                                    "Question ${index + 1}",
                                    style: GoogleFonts.poppins(
                                        color: Colors.amber),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  get![index].question,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      fontSize: 20, color: Colors.white),
                                ),
                                const SizedBox(height: 10),
                                CircleAvatar(
                                  radius: 35,
                                  child:
                                      Text(timerDurationInSeconds.toString()),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: size.width - 80,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          print(get![index].answer);
                                          if (isTrue == false) {
                                            if (options[0] ==
                                                get![index].answer) {
                                              setState(() {
                                                color[0] = Colors.green;
                                                count = count + 1;
                                              });
                                            } else {
                                              setState(() {
                                                color[0] = Colors.red;
                                              });
                                            }
                                            isTrue = true;
                                            for (int i = 0;
                                                i < options.length;
                                                i++) {
                                              if (options[i] ==
                                                  get![index].answer) {
                                                setState(() {
                                                  color[i] = Colors.green;
                                                });
                                              }
                                            }
                                          }
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(color[
                                                  0]), // Use the default color for incorrect answer
                                        ),
                                        child: Text(
                                          options[0],
                                          style: TextStyle(color: Colors.black),
                                        )),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: size.width - 80,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          if (isTrue == false) {
                                            if (options[1] ==
                                                get![index].answer) {
                                              setState(() {
                                                color[1] = Colors.green;
                                                count = count + 1;
                                              });
                                            } else {
                                              setState(() {
                                                color[1] = Colors.red;
                                              });
                                            }
                                          }
                                          isTrue = true;
                                          for (int i = 0;
                                              i < options.length;
                                              i++) {
                                            if (options[i] ==
                                                get![index].answer) {
                                              setState(() {
                                                color[i] = Colors.green;
                                              });
                                            }
                                          }
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(color[
                                                  1]), // Use the default color for incorrect answer
                                        ),
                                        child: Text(
                                          options[1],
                                          style: TextStyle(color: Colors.black),
                                        )),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: size.width - 80,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          if (isTrue == false) {
                                            if (options[2] ==
                                                get![index].answer) {
                                              setState(() {
                                                color[2] = Colors.green;
                                                count = count + 1;
                                              });
                                            } else {
                                              setState(() {
                                                color[2] = Colors.red;
                                              });
                                            }
                                          }
                                          isTrue = true;
                                          for (int i = 0;
                                              i < options.length;
                                              i++) {
                                            if (options[i] ==
                                                get![index].answer) {
                                              setState(() {
                                                color[i] = Colors.green;
                                              });
                                            }
                                          }
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(color[
                                                  2]), // Use the default color for incorrect answer
                                        ),
                                        child: Text(
                                          options[2],
                                          style: TextStyle(color: Colors.black),
                                        )),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: size.width - 80,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          if (isTrue == false) {
                                            if (options[3] ==
                                                get![index].answer) {
                                              setState(() {
                                                color[3] = Colors.green;
                                                count = count + 1;
                                              });
                                            } else {
                                              setState(() {
                                                color[3] = Colors.red;
                                              });
                                            }
                                          }
                                          isTrue = true;
                                          for (int i = 0;
                                              i < options.length;
                                              i++) {
                                            if (options[i] ==
                                                get![index].answer) {
                                              setState(() {
                                                color[i] = Colors.green;
                                              });
                                            }
                                          }
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(color[
                                                  3]), // Use the default color for incorrect answer
                                        ),
                                        child: Text(
                                          options[3],
                                          style: const TextStyle(
                                              color: Colors.black),
                                        )),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // index == 0
                          //     ? const SizedBox()
                          //     : ElevatedButton(
                          //         onPressed: () {
                          //           if (index < get!.length - 1 &&
                          //               index != 0) {
                          //             setState(() {
                          //               index = index - 1;
                          //               getOptions();
                          //               isTrue = false;
                          //               color.fillRange(0, 4, Colors.white);
                          //             });
                          //           }
                          //         },
                          //         child: const Text("Previous")),
                          const SizedBox(width: 30),
                          ElevatedButton(
                            onPressed: () {
                              if (isTrue == false) {
                                newshowSnackbar(
                                    context,
                                    "Warning",
                                    "Please Select the options",
                                    ContentType.warning);
                              } else if (index < get!.length - 1) {
                                setState(() {
                                  index = index + 1;
                                  getOptions();
                                  isTrue = false;
                                  timer.cancel();
                                  timerDurationInSeconds = 60;
                                  startTimer();
                                  color.fillRange(0, 4, Colors.white);
                                });
                              } else {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => GraphPge(
                                      totalPoint: count,
                                      totalMark: get!.length,
                                      totalPointPercentage:
                                          (get!.length / count) * 100),
                                ));
                              }
                            },
                            child: index == get!.length - 1
                                ? const Text("sumbit")
                                : const Text("Next"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10)
                    ]),
                  ),
                ),
        ));
  }

  @override
  void dispose() {
    index = 0;
    timer.cancel();
    super.dispose();
  }
}

void newshowSnackbar(
    BuildContext context, String title, String message, contentType) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      content: AwesomeSnackbarContent(
          inMaterialBanner: true,
          title: title,
          message: message,
          contentType: contentType)));
}
