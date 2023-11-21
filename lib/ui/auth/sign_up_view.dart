import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_app/services/locator.dart';
import 'package:test_app/services/sharedprefs_services.dart';
import 'package:test_app/utils/global_function.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SharedPrefsService _sharedPrefsService = locator<SharedPrefsService>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  String _email = "";

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  void _loadUserInfo() async {
    setState(() {
      _email = _sharedPrefsService.read(SharedPrefsService.LOGIN_EMAIL) ?? "";
    });
  }

  void _signUp() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    if (_formKey.currentState!.validate()) {
      if (_emailController.text == _email) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Account already exists, try logging in")),
        );
      } else {
        if (GlobalFunction().isValidEmail(_emailController.text) &&
            GlobalFunction().isPasswordValid(_passwordController.text) &&
            _passwordController.text == _confirmPasswordController.text &&
            _nameController.text.length >= 3) {
          _sharedPrefsService.write(
              SharedPrefsService.USERNAME, _nameController.text);
          _sharedPrefsService.write(
              SharedPrefsService.LOGIN_EMAIL, _emailController.text);
          _sharedPrefsService.write(
              SharedPrefsService.LOGIN_PASSWORD, _passwordController.text);
          _sharedPrefsService.write(SharedPrefsService.IS_LOGGED, true);
          _sharedPrefsService.write(SharedPrefsService.IS_SIGNED, true);
          Navigator.pushNamedAndRemoveUntil(
              context, '/dashboard', (route) => false);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("enter valid Details")));
        }
      }
    }
  }

  bool _isTermsChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        title: Text("Sign up",
            style: TextStyle(
              color: Colors.white,
            )),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Enter Name",
                ),
                validator: (value) {
                  if (value == null || value.length < 3) {
                    return "name cannot be smaller than 3 letters";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 32,
              ),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Enter Email",
                ),
                validator: (value) {
                  if (value!.isEmpty || !GlobalFunction().isValidEmail(value)) {
                    return 'Enter a valid email';
                  } else if (_emailController.text == _email) {
                    return "Account Already exist, try login in";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 32,
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Enter Password",
                ),
                obscuringCharacter: '*',
                validator: (value) {
                  if (value!.isEmpty ||
                      !GlobalFunction().isPasswordValid(value)) {
                    return "must contain:\n least one uppercase letter \n least one lowercase letter \n least one digit \n at least one special character";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                keyboardType: TextInputType.text,
                obscuringCharacter: '*',
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                ),
                validator: (value) {
                  if (value!.isEmpty ||
                      _passwordController.text !=
                          _confirmPasswordController.text) {
                    return 'Enter a same password as above';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 32,
              ),
              CheckboxListTile(
                title: Text("I agree to the terms and conditions"),
                value: _isTermsChecked,
                onChanged: (newValue) {
                  setState(() {
                    _isTermsChecked = newValue!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              SizedBox(
                height: 16,
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                color: Colors.blue,
                onPressed: () {
                  if (_isTermsChecked) {
                    _signUp();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text("Please agree to the terms and conditions")),
                    );
                  }
                },
                child: Text("Sign up",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
              SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/signin');
                },
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Already have Account, ",
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                    TextSpan(
                        text: " Sign In",
                        style: TextStyle(color: Colors.blue, fontSize: 16)),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
