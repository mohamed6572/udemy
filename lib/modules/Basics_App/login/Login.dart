import 'package:flutter/material.dart';
import 'package:gps_tracker/shared/components/components.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var email = TextEditingController();

  var password = TextEditingController();

  String email1 = '';

var formKey = GlobalKey<FormState>();

bool isPasswrdShow = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  defultFormField(
                    controller: email,
                    label: 'Email',
                    prefix: Icons.email,
                    type: TextInputType.emailAddress,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Email must not be null';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  defultFormField(

                    type: TextInputType.visiblePassword,
                    prefix: Icons.lock,
                    label: 'Password',
                    passwordShow: (){
                      setState(() {

                      });
                      isPasswrdShow = !isPasswrdShow ;

                    },
                    controller: password,
                    isPassword: isPasswrdShow,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'password must not be empty';
                      }
                      return null;
                    },
                    suffix: isPasswrdShow ? Icons.visibility : Icons.visibility_off
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  defultButton(
                    function: () {
                      if(formKey.currentState?.validate() == true){
                      print(email.text);
                      print(password.text);}
                    },
                    text: 'login',
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an email ?'),
                      TextButton(onPressed: () {}, child: Text('Register Now'))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
