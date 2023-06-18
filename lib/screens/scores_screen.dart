import 'package:flutter/material.dart';
import 'package:flutter_tetris/db/db.dart';
import 'package:flutter_tetris/widgets/appbar.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ScoresScreen extends StatefulWidget {
  const ScoresScreen({super.key});

  @override
  State<ScoresScreen> createState() => _ScoresScreenState();
}

class _ScoresScreenState extends State<ScoresScreen> {
  List<Map> scores = [];
  DatabaseHelper db = DatabaseHelper();
  @override
  void initState() {
    super.initState();
    getNotes();
  }

  Future getNotes() async {
    scores = await db.getScores();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const CustomAppBar(title: "SCORES BORAD"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: ListView.builder(
          itemCount: scores.length,
          itemBuilder: (_, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1),
                borderRadius: BorderRadius.circular(1.h),
              ),
              tileColor: Colors.orangeAccent.withOpacity(0.2),
              title: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Match ${index + 1}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: "VT323",
                    fontSize: 35,
                  ),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      scores[index]['score'],
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontFamily: "VT323",
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "${DateFormat.yMMMd().format(DateTime.parse(scores[index]['date']))} ${DateFormat.Hm().format(DateTime.parse(scores[index]['date']))}",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontFamily: "VT323",
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
