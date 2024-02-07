// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:quizeapp/models/questionmodel.dart';

Future<void> addQuesionDetails(
    QuestionDetails tough, BuildContext context) async {
  final box = await Hive.openBox<QuestionDetails>("QuizTable");
  try {
    final index = await box.add(tough);

    if (index >= 0) {
      print('quizModel added at index: $index');
      showSnackBar(context, Colors.green, "Successfully Added");
    } else {
      print('Failed to add quizModel  to the box');
    }
  } catch (e) {
    print('Error while adding quizModel: $e');
  }
}

void showSnackBar(BuildContext context, Color Color, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: Color,
    duration: const Duration(seconds: 5),
  ));
}

Future<List<QuestionDetails>?> getQuestionDetails() async {
  final box = await Hive.openBox<QuestionDetails>("QuizTable");
  List<QuestionDetails> allGetQuestionDetails = box.values.toList();
  if (allGetQuestionDetails.isEmpty) {
    return null;
  }
  return allGetQuestionDetails;
}
