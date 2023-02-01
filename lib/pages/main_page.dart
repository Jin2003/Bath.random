import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          title: const Text('Bath.random();'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.dehaze_rounded),
            ),
          ],
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 152, 233, 244),

      // child: Container(
      //     child: Column(
      //   children: [
      //     Card(
      //       child: ListTile(
      //         leading: Icon(Icons.people),
      //         title: Text("Single line ListTile"),
      //         trailing: Icon(Icons.more_vert),
      //         onTap: () {},
      //       ),
      //     ),
      //     Card(
      //       child: ListTile(
      //         leading: Icon(Icons.people),
      //         title: Text("Single line ListTile"),
      //         trailing: Icon(Icons.more_vert),
      //         onTap: () {},
      //       ),
      //     ),
      //   ],
      // )),
      //),

      body: Card(
        color: Colors.white, // Card自体の色
        margin: const EdgeInsets.fromLTRB(40, 90, 40, 120),
        elevation: 10,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: const [
            ListTile(
              leading: Icon(Icons.people),
              title: Text('kei'),
              subtitle: Text('18:00-19:00'),
              trailing: Text('1hour'),
            ),
          ],
        ),
      ),

      // body: Container(
      //   child: Container(
      //     alignment: Alignment.center,
      //     child: Card(
      //       //margin: EdgeInsets.all(10),
      //       child: ListView.builder(
      //         itemBuilder: (context, index) {
      //           return ListTile(
      //             leading: const Icon(Icons.people),
      //             title: const Text('りんご'),
      //           );
      //         },
      //         itemCount: 5, //ここでリストの数指定
      //       ),
      //     ),
      //   ),
      //   width: 350,
      //   height: 500,
      // ),

      // body: Container(
      //   child: ListView(
      //     children: <Widget>[
      //       SizedBox(
      //         width: 100,
      //         height: 10,
      //       ),
      //       ListTile(
      //         shape: RoundedRectangleBorder(
      //           side: BorderSide(),
      //           borderRadius: BorderRadius.circular(20),
      //         ),
      //         tileColor: Colors.white,
      //         leading: Icon(Icons.people),
      //         title: Text('shiori'), //ここに名前
      //         subtitle: Text('18:00-19:00'),
      //         trailing: Text('60min'),
      //       ),
      //       SizedBox(
      //         width: 100,
      //         height: 10,
      //       ),
      //       ListTile(
      //         shape: RoundedRectangleBorder(
      //           side: BorderSide(),
      //           borderRadius: BorderRadius.circular(20),
      //         ),
      //         tileColor: Colors.white,
      //         leading: Icon(Icons.people),
      //         title: Text('sakura'), //ここに名前
      //         subtitle: Text('19:00-19:30'),
      //         trailing: Text('30min'),
      //       ),
      //       SizedBox(
      //         width: 100,
      //         height: 10,
      //       ),
      //       ListTile(
      //         shape: RoundedRectangleBorder(
      //           //side: BorderSide(),
      //           borderRadius: BorderRadius.circular(10),
      //         ),
      //         tileColor: Colors.white,
      //         leading: Icon(Icons.people),
      //         title: Text('kei'), //ここに名前
      //         subtitle: Text('19:30-20:50'),
      //         trailing: Text('80min'),
      //       ),
      //     ],
      //   ),
      // ),

      // body: Center(
      //   child: ListTile(
      //     shape: RoundedRectangleBorder(
      //       side: BorderSide(),
      //       borderRadius: BorderRadius.circular(20),
      //     ),
      //     tileColor: Colors.white,
      //     leading: Icon(Icons.people),
      //     title: Text("りんご"),
      //   ),
      //),
    );
  }
}
