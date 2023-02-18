import 'package:bath_random/view/constant.dart';
import 'package:bath_random/view/pages/components/custom_text.dart';
import 'package:bath_random/view/pages/group_select_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'components/custom_button.dart';
import 'package:bath_random/view/pages/qr_display_page.dart';

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
      backgroundColor: Constant.lightBlueColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 100, height: 70),
            const CustomText(text: '家族の人数', fontSize: 23),
            const SizedBox(width: 100, height: 20),
            Container(
              width: 220,
              height: 60,
              decoration: BoxDecoration(
                // border: Border.all(color: Colors.black),
                color: const Color.fromARGB(255, 255, 249, 249),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton<String>(
                iconSize: 30,
                style: TextStyle(
                  fontSize: 25,
                  //フォント変えたい！！！！！！！！！！！！！！！！！！！！！！
                  color: Constant.lightGreyColor,
                ),
                value: selectedValue,
                items: lists
                    .map((String list) => DropdownMenuItem(
                          value: list,
                          child: Container(
                            width: 120,
                            alignment: Alignment.center,
                            child: Text(list),
                          ),
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
            const SizedBox(width: 100, height: 20),
            CustomButton(
                title: '登録',
                width: 120,
                height: 40,
                nextPage: QrDisplayPage(
                  userCounts: selectedValue,
                )),
            const SizedBox(width: 100, height: 5),
            const CustomButton(
              title: 'もどる',
              width: 120,
              height: 40,
              nextPage: GroupSelectPage(),
            ),
          ],
        ),
      ),
    );
  }
}
