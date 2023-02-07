import 'package:bath_random/pages/components/custom_button.dart';
import 'package:bath_random/pages/components/custom_text.dart';
import 'package:bath_random/pages/wait_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegiAccountPage extends StatefulWidget {
  final String groupID;
  const RegiAccountPage({super.key, required this.groupID});

  @override
  State<RegiAccountPage> createState() => _RegiAccountPageState();
}

String nameText = '';

class _RegiAccountPageState extends State<RegiAccountPage> {
  // get child => null;
  TextEditingController userNameController = TextEditingController();
  TextEditingController bathTimeController = TextEditingController();
  String userID = "";

  // ユーザー登録の処理
  Future<void> createUser() async {
    final userCollection = FirebaseFirestore.instance.collection('user');
    userID = userCollection.doc().id;
    await userCollection.doc(userID).set({
      'groupID': widget.groupID,
      'userName': userNameController.text,
      'bathTime': int.parse(bathTimeController.text),
      'order': null,
    });
    // ローカルにIDを保存
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userID', userID);
    prefs.setString('groupID', widget.groupID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 150, 222, 231),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 入力欄
              const CustomText(text: 'あなたのニックネーム', fontSize: 25),
              const SizedBox(
                width: 100,
                height: 10,
              ),
              // ユーザーネームの入力ボックス
              TextField(
                controller: userNameController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      width: 3,
                      color: Colors.white,
                    )),
                    labelText: 'your nickname'),
              ),
              const SizedBox(height: 28),
              const CustomText(text: '入浴時間', fontSize: 25),
              const CustomText(text: '分単位で入力してください', fontSize: 16),
              const SizedBox(height: 10),
              // お風呂時間の入力ボックス
              TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: bathTimeController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      width: 3,
                      color: Colors.white,
                    )),
                    labelText: 'bath time'),
              ),
              const SizedBox(
                width: 100,
                height: 40,
              ),
              CustomButton(
                title: '次へ',
                width: 120,
                height: 45,
                onPressed: () => createUser(),
                nextPage: WaitPage(
                  groupID: widget.groupID,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
