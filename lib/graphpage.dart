import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizeapp/display.dart';

class GraphPge extends StatefulWidget {
  const GraphPge(
      {super.key,
      required this.totalPoint,
      required this.totalMark,
      required this.totalPointPercentage});
  final int totalPoint;
  final int totalMark;
  final double totalPointPercentage;
  @override
  State<GraphPge> createState() => _GraphPgeState();
}

String per = '';

class _GraphPgeState extends State<GraphPge> {
  void percentage() {
    if (widget.totalPointPercentage.toInt() == 100) {
      setState(() {
        per = 'Excellent';
      });
    } else if (widget.totalPointPercentage.toInt() >= 50) {
      setState(() {
        per = "Average";
      });
    } else {
      setState(() {
        per = "Below Avarage";
      });
    }
  }

  @override
  void initState() {
    percentage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Text(
                "Result".toUpperCase(),
                style: GoogleFonts.poppins(
                    fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 19),
              Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.withOpacity(0.1),
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CircularChart(
                    individualMarks: widget.totalPoint.toDouble(),
                    totalMarks: widget.totalMark.toDouble(),
                  )),
              const SizedBox(height: 19),
              Column(
                children: [
                  Text(
                    'Correct Answer : ${widget.totalPoint}',
                    style: GoogleFonts.poppins(fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Wrong Answer: ${widget.totalPoint - widget.totalMark}",
                    style: GoogleFonts.poppins(fontSize: 20),
                  ),
                  SizedBox(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DisplayPge(),
                              ));
                        },
                        child: Text(
                          "Back",
                          style: GoogleFonts.poppins(fontSize: 25),
                        )),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Total You Are Attended",
                    style: GoogleFonts.poppins(),
                  ),
                  // widget.totalPoint < 5
                  //     ? Image.asset("assets/animations/Winners-cuate.png")
                  //     : Image.asset("assets/animations/Shrug-pana.png"),
                  const SizedBox(height: 10),
                  Text(
                    "${widget.totalPoint}/${widget.totalMark}",
                    style: GoogleFonts.poppins(
                        fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  Text(per)
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}

class CircularChart extends StatelessWidget {
  final double totalMarks;
  final double individualMarks;

  const CircularChart(
      {super.key, required this.individualMarks, required this.totalMarks});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 400,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              color: const Color(0XFF188F79),
              value: individualMarks.floorToDouble(),
              radius: 50,
              titleStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            PieChartSectionData(
              color: Colors.red.withOpacity(0.2),
              value: (totalMarks - individualMarks).floorToDouble(),
              radius: 50,
              titleStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
