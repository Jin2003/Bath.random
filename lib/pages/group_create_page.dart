import 'package:bath_random/pages/group_select_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'components/custom_button.dart';
import 'package:bath_random/pages/qr_display_page.dart';

class GroupCreatePage extends StatefulWidget {
  final String? deleteGroupId;
  const GroupCreatePage({super.key, this.deleteGroupId});

  @override
  State<GroupCreatePage> createState() => _GroupCreatePageState();
}

class _GroupCreatePageState extends State<GroupCreatePage> {
  String selectedValue = "4";

  final lists = <String>["2", "3", "4", "5", "6"];

  // firestoreからgroupを消去する処理
  Future<void> deleteGroup(String? groupID) async {
    final doc = FirebaseFirestore.instance.collection('group').doc(groupID);
    await doc.delete();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.deleteGroupId != null) {
      deleteGroup(widget.deleteGroupId);
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 152, 233, 244),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 100, height: 70),
            Text('家族の人数',
                style: GoogleFonts.mPlusRounded1c(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                )),
            const SizedBox(width: 100, height: 10),
            Container(
              width: 220,
              height: 60,
              decoration: BoxDecoration(
                //border: Border.all(color: Colors.black),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton<String>(
                // ignore: prefer_const_constructors
                // focusColor: Colors.white,
                // underline: Container(
                //   height: 3,
                //   color: Colors.black,
                // ),
                iconSize: 40,
                style: const TextStyle(
                  fontSize: 28,
                  //フォント変えたい！！！！！！！！！！！！！！！！！！！！！！
                  color: Colors.black,
                ),
                value: selectedValue,
                items: lists
                    .map((String list) => DropdownMenuItem(
                          // ignore: sort_child_properties_last
                          child: Container(
                            width: 100,
                            alignment: Alignment.center,
                            child: Text(list),
                          ),
                          value: list,
                        ))
                    .toList(),
                onChanged: (String? value) {
                  setState(() {
                    // 入力した数を渡す
                    selectedValue = value!;
                  });
                },
              ),
            ),
            const SizedBox(width: 100, height: 30),
            CustomButton(
                title: '登録',
                width: 120,
                height: 45,
                nextPage: QrDisplayPage(
                  userCounts: selectedValue,
                )),
            const SizedBox(width: 100, height: 10),
            const CustomButton(
              title: 'もどる',
              width: 120,
              height: 45,
              nextPage: GroupSelectPage(),
            ),
          ],
        ),
      ),
    );
  }
}
