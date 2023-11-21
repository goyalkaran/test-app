import 'package:flutter/material.dart';
class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});
  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}
class _RegistrationViewState extends State<RegistrationView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Register", style: TextStyle(color: Colors.white,)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton( shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                minWidth: double.maxFinite,
                color: Colors.blue,
                onPressed: (){
                  Navigator.pushNamed(
                      context, '/signin',);

                },child: Text("Sign In", style: TextStyle(color: Colors.white, fontSize: 16)),),
              SizedBox(height: 16,),
              MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                minWidth: double.maxFinite,
                color: Colors.blue,
                onPressed: (){
                  Navigator.pushNamed(
                      context, '/signup');

                },child: Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 16)),),
            ],
          ),
        )
    );
  }
}

