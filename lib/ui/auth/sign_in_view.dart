import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_app/services/locator.dart';
import 'package:test_app/services/sharedprefs_services.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final SharedPrefsService _sharedPrefsService = locator<SharedPrefsService>();

  bool isPasswordValid(String password) {
    // Check password length
    if (password.length < 8) {
      return false;
    }

    // Check for at least one uppercase letter
    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));

    // Check for at least one lowercase letter
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));

    // Check for at least one digit
    bool hasDigit = password.contains(RegExp(r'[0-9]'));

    // Check for at least one special character
    bool hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    // Ensure all criteria are met
    return hasUppercase && hasLowercase && hasDigit && hasSpecialChar;
  }

  bool isValidEmail(String email) {
    // Regular expression pattern for basic email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    return emailRegex.hasMatch(email);
  }

  String _email = "";
  String _password = "";

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  void _loadUserInfo() async {
    setState(() {
      _password =
          _sharedPrefsService.read(SharedPrefsService.LOGIN_PASSWORD) ?? "";
      _email = _sharedPrefsService.read(SharedPrefsService.LOGIN_EMAIL) ?? "";
    });
  }

  void _login() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    if (_formKey.currentState!.validate()) {
      if (isValidEmail(_emailController.text) &&
          isPasswordValid(_passwordController.text)) {
        if (_emailController.text == _email &&
            _passwordController.text == _password) {
          _sharedPrefsService.write(SharedPrefsService.IS_LOGGED, true);
          Navigator.pushNamedAndRemoveUntil(
              context, '/dashboard', (route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Account doesn't exist, try signing up")));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("enter valid Details")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Sign In ",
            style: TextStyle(
              color: Colors.white,
            )),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Enter Email",
                ),
                validator: (value) {
                  if (value!.isEmpty || !isValidEmail(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Enter Password",
                ),
                validator: (value) {
                  if (value!.isEmpty || !isPasswordValid(value)) {
                    return "must contain:\n least 8 characters\n least one uppercase letter \n least one lowercase letter \n least one digit \n at least one special character";
                  }
                  return null;
                },
              ),
              SizedBox(height: 32),
              MaterialButton(
                minWidth: double.maxFinite,
                color: Colors.blue,
                onPressed: _login,
                child: Text("Sign In",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/signup');
                },
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Create Account, ",
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                    TextSpan(
                        text: " Sign up",
                        style: TextStyle(color: Colors.blue, fontSize: 16)),
                  ]),
                ),
              ),
              SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    child: Image.asset(
                      "assets/images/facebook.png",
                      height: 64,
                    ),
                  ),
                  InkWell(
                    child: Image.asset(
                      "assets/images/instagram.png",
                      height: 64,
                    ),
                  ),
                  InkWell(
                    child: Image.asset(
                      "assets/images/twitter.png",
                      height: 64,
                    ),
                  ),
                  InkWell(
                    child: Image.asset(
                      "assets/images/website.png",
                      height: 64,
                    ),
                  ),
                  // InkWell(child: CircleAvatar(radius: 32,child: Icon(Icons.pl),),),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
