import 'package:flutter/material.dart';
import 'signup.dart';
import 'lessons_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'addChild_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
 _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage>{
  final _auth = FirebaseAuth.instance;
  bool showProgress = false;
  late String errorMessage;
  late String email, password;
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color(0xffEBFCFA),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: Form(
              child: Column(children: [
                Container(
                  height: 150.0,
                  width: 190.0,
                  padding: EdgeInsets.only(top: 40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                  ),
                ),
                Text ("تسجيل الدخول", style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff003C47),
                ),),
                SizedBox(height: 30,),
                Column(children: [
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      width: 550,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(29),
                      ),
                      padding: EdgeInsets.all(0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          email = value; // get value from TextField
                        },
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            icon: Icon(
                              Icons.mail,
                              color: Colors.grey,
                            ),
                            border: InputBorder.none,
                            labelText: 'البريد الإلكتروني',
                            hintText: 'ادخل بريدك الإلكتروني'
                        ),
                      ),
                    ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    width: 550,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(29),
                    ),
                    padding: EdgeInsets.all(0),
                    child: TextFormField(
                      obscureText: true,
                      textAlign: TextAlign.center,
                      // validator: (value) {
                      //   if (value.isEmpty || value.length < 7) {
                      //     return 'Password must be at least 7 characters long.';
                      //   }
                      //   return null;
                      // },
                      onChanged: (value) {
                        password = value; //get value from textField
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          icon: Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                          labelText: 'كلمة المرور',
                          hintText: 'ادخل كلمة مرورك'
                      ),
                    ),
                  ),
                ],
                ),
                SizedBox(height: 40,),
                Container(
                  width: 250,
                  height: 60,
                  padding: EdgeInsets.only(top: 3, left: 3),
                  decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Color(0xff299593),
                    ),
                  ),
                  child: FlatButton(
                    color: Colors.white,
                    minWidth: double.infinity,
                    onPressed: () async {
                      setState(() {
                        showProgress = true;
                      });
                      try {
                        final newUser = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        print(newUser.toString());
                        if (newUser != null) {
                          print("Login Successfull");
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AddChildPage()));
                          Fluttertoast.showToast(
                              msg: "تم تسجيل الدخول بنجاح",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.blueAccent,
                              textColor: Colors.black,
                              fontSize: 16.0);
                          setState(() {
                            showProgress = false;
                          });
                        }
                      } catch (e) {}
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      'تسجيل الدخول',
                      style: TextStyle(color: Color(0xff003C47), fontSize: 25),
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Row(
                  children: <Widget>[
                    TextButton(
                      child: const Text(
                        'سجل هنا',
                        style: TextStyle(fontSize: 20,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
                      },
                    ),
                    const Text('مستخدم جديد؟',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff003C47),
                        )),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],),
            ),
          ),
        )
    );
  }
}

