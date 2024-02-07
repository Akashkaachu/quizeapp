import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizeapp/Hive/hive.dart';
import 'package:quizeapp/display.dart';
import 'package:quizeapp/models/questionmodel.dart';

class HomePge extends StatefulWidget {
  HomePge({super.key});

  @override
  State<HomePge> createState() => _HomePgeState();
}

class _HomePgeState extends State<HomePge> {
  final formKey = GlobalKey<FormState>();

  TextEditingController quetionEditingController = TextEditingController();

  TextEditingController answerEditingController = TextEditingController();

  TextEditingController optionOneEditingController = TextEditingController();

  TextEditingController optionTwoEditingController = TextEditingController();

  TextEditingController optionThreeEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 1.0),
              colors: <Color>[Colors.orange, Colors.green],
              stops: <double>[0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        title: const Text(
          'Quiz App ',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              QuizWidget(
                head: "Question",
                answer: "Enter the Question ",
                maxLines: 5,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter the Question";
                  } else if (value.length < 4) {
                    return "Give more Word";
                  } else {
                    return null;
                  }
                },
                controller: quetionEditingController,
              ),
              QuizWidget(
                head: "Answer",
                answer: "Enter the Answer",
                maxLines: 4,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter the Question";
                  } else if (value.length < 4) {
                    return "Give more Word";
                  } else {
                    return null;
                  }
                },
                controller: answerEditingController,
              ),
              QuizWidget(
                head: "Other Options",
                answer: "Options 1",
                maxLines: 2,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter the Question";
                  } else if (value.length < 3) {
                    return "Give more Word";
                  } else {
                    return null;
                  }
                },
                controller: optionOneEditingController,
              ),
              QuizWidget(
                head: "Other Options",
                answer: "Options 2",
                maxLines: 2,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter the Question";
                  } else if (value.length < 3) {
                    return "Give more Word";
                  } else {
                    return null;
                  }
                },
                controller: optionTwoEditingController,
              ),
              QuizWidget(
                head: "Other Options",
                answer: "Options 3",
                maxLines: 3,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter the Question";
                  } else if (value.length < 3) {
                    return "Give more Word";
                  } else {
                    return null;
                  }
                },
                controller: optionThreeEditingController,
              ),
              SizedBox(
                  width: size.width - 30,
                  child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          final tough = QuestionDetails(
                              question: quetionEditingController.text,
                              answer: answerEditingController.text,
                              option1: optionOneEditingController.text,
                              option2: optionTwoEditingController.text,
                              option3: optionThreeEditingController.text);
                          addQuesionDetails(tough, context);
                          clear();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DisplayPge(),
                              ));
                        }
                      },
                      child: const Text("SUBMIT"))),
              const SizedBox(height: 50)
            ],
          ),
        ),
      ),
    );
  }

  clear() {
    setState(() {
      quetionEditingController.clear();
      answerEditingController.clear();
      optionOneEditingController.clear();
      optionTwoEditingController.clear();
      optionThreeEditingController.clear();
    });
  }
}

class QuizWidget extends StatelessWidget {
  const QuizWidget({
    super.key,
    required this.head,
    required this.answer,
    this.maxLines,
    required this.validator,
    required this.controller,
  });
  final String head;
  final String answer;
  final int? maxLines;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(
        height: 20,
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Text(
              head,
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: controller,
          validator: validator,
          maxLines: maxLines,
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              label: Text(answer),
              prefixIcon: Icon(Icons.add)),
        ),
      )
    ]);
  }
}
