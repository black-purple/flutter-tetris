import 'package:flutter/material.dart';
import 'package:flutter_tetris/controllers/difficulty_controller.dart';
import 'package:flutter_tetris/values.dart';
import 'package:flutter_tetris/widgets/appbar.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var selectedValue = Get.find<DifficultyController>().d.name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const CustomAppBar(title: "SETTINGS"),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Difficulty",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  DropdownButton(
                    dropdownColor: Colors.grey.shade900,
                    value: selectedValue,
                    style: const TextStyle(fontSize: 20),
                    items: Difficulty.values
                        .map((val) => val.name)
                        .toList()
                        .map<DropdownMenuItem>(
                          (diff) => DropdownMenuItem(
                            value: diff,
                            child: Text(diff.toString()),
                          ),
                        )
                        .toList(),
                    onChanged: (newValue) {
                      var diffs = Difficulty.values.asNameMap();
                      setState(() {
                        selectedValue = newValue;
                      });
                      Get.find<DifficultyController>()
                          .updateDifficulty(diffs[newValue]!);
                    },
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
