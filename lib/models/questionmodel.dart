import 'package:hive/hive.dart';
part 'questionmodel.g.dart';

@HiveType(typeId: 1)
class QuestionDetails {
  @HiveField(0)
  String question;
  @HiveField(1)
  String answer;
  @HiveField(2)
  String option1;
  @HiveField(3)
  String option2;
  @HiveField(4)
  String option3;

  QuestionDetails({
    required this.question,
    required this.answer,
    required this.option1,
    required this.option2,
    required this.option3,
  });
}
