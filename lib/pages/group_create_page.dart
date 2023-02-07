import 'package:bath_random/pages/components/custom_text.dart';
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
    // 戻ってきたらグループを削除
    if (widget.deleteGroupId != null) {
      deleteGroup(widget.deleteGroupId);
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 150, 222, 231),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 100, height: 70),
            const CustomText(text: '家族の人数', fontSize: 25),
            const SizedBox(width: 100, height: 20),
            Container(
              width: 180,
              height: 60,
              decoration: BoxDecoration(
                // border: Border.all(color: Colors.black),
                color: const Color.fromARGB(255, 255, 249, 249),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton<String>(
                // focusColor: Colors.white,
                // underline: Container(
                //   height: 3,
                //   color: Colors.black,
                // ),
                iconSize: 40,
                style: TextStyle(
                  fontSize: 28,
                  //フォント変えたい！！！！！！！！！！！！！！！！！！！！！！
                  color: Colors.grey.shade800,
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
                borderRadius: BorderRadius.circular(10),
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
