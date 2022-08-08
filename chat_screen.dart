import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
  
final _firestore = FirebaseFirestore.instance;
  late User signedInUser;

class ChatScreen extends StatefulWidget {
  static const String screenRoute = "chat_screen";
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> { 
  final massegTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;  
  String? massegeText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final User = _auth.currentUser;
      if (User != null) {
        signedInUser = User;
        print(signedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  //void getMessages() async {
  //final masseges = await _firestore.collection('masseges').get();
  //for (var masseges in masseges.docs) {
  //print(masseges.data());
  //}
  //}

  //void massegesStreams() async {
    //await for (var snapshot in _firestore.collection('masseges').snapshots()) {
      //for (var masseges in snapshot.docs) {
        //print(masseges.data());
      //}
    //}
  //}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[900],
        title: Row(
          children: [SizedBox(width: 10), Text('MessageMe')],
        ),
        actions: [
          IconButton(
            onPressed: () {
              //massegesStreams();
              _auth.signOut();
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [  
            MassegeStreamBuilder(),          
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.orange,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: massegTextController,
                      onChanged: (value) {
                        massegeText = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        hintText: 'Write your message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      massegTextController.clear();
                      _firestore.collection('masseges').add({
                        'text': massegeText,
                        'sender': signedInUser.email,
                        'time': FieldValue.serverTimestamp()
                      });
                    },
                    child: Text(
                      'send',
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MassegeStreamBuilder extends StatelessWidget {
  const MassegeStreamBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('masseges').orderBy('time').snapshots(),
              builder: (context, snapshot) {
                List<Massegalline> massegewidgets = [];

                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.blue,
                    ),
                  );
                }

                final Masseges = snapshot.data!.docs.reversed;
                for (var massege in Masseges) {
                  final massegesText = massege.get('text');
                  final massegeSender = massege.get('sender');
                  final currentUser = signedInUser.email;


                  
                  
                
                  final massegewidget = Massegalline(
                   sinder: massegeSender,
                   text: massegesText,
                   isMe: currentUser==massegeSender,
                   );


                  massegewidgets.add(massegewidget);
                }
                return Expanded(
                  child: ListView(
                    reverse: true,
                     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    children: massegewidgets,
                  ),
                );
              },
    ); 
    
  }
}

class Massegalline extends StatelessWidget {
  const Massegalline({this.text,this.sinder,required this.isMe, key}) : super(key:
   key);

  final String? sinder;
  final String? text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return    Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.end:CrossAxisAlignment.start,       
        children: [
          Text(
            "$sinder",
            style: TextStyle(fontSize:12,color: Colors.yellow[900] ),
            ),
          Material(
            elevation: 5,
           borderRadius:isMe 
           ?   BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
           ):BorderRadius.only(
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
           ),
           color:isMe? Colors.blue[800]: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              child: Text(
                '$text',  
               style:TextStyle(
                fontSize: 15,color:isMe ? Colors.white:Colors.black45),

            ),
            
             ),
            ),

          
        ],
      ),
    );  
  ;  }
}


