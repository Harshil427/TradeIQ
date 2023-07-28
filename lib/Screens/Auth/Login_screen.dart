// ignore_for_file: prefer_const_constructors, sort_child_properties_last, file_names

import 'package:flutter/material.dart';
import 'package:tradeiq/Screens/Auth/ForgotPassword.dart';
import 'package:tradeiq/Screens/Auth/SignUp_Screen.dart';
import 'package:tradeiq/Utils/Functions.dart';

import '../../Constants/Colors.dart';
import '../../Widgets/Style.dart';
import '../../Widgets/LogoAndComponents.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, continue with login process
      String email = _emailController.text.trim();
      String password = _passwordController.text;

      // Add your login logic here, e.g., authenticate user
      // and navigate to the next screen if login is successful.
    } else {
      // Form is invalid, show validation errors
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildLogoSection(),
                  SizedBox(height: 20),
                  _welComeText(),
                  Container(
                    padding: EdgeInsets.all(20),
                    width: width * .8,
                    child: Column(
                      children: [
                        _buildEmailTextField(),
                        SizedBox(height: 10),
                        _buildPasswordTextField(),
                        SizedBox(height: 20),
                        _buildLoginButton(),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            _forgotPassword(),
                            Spacer(),
                            _moveSignUp()
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: authInputField.copyWith(
        labelText: 'Email',
        prefixIcon: Icon(Icons.email),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        // You can also add more complex email validation here if needed
        return null;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: !_isPasswordVisible,
      decoration: authInputField.copyWith(
        labelText: 'Password',
        prefixIcon: Icon(Icons.lock),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
          child: Icon(
            _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        // You can also add more complex password validation here if needed
        return null;
      },
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _login, // Call the _login function on button press
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Color.fromARGB(143, 189, 134, 206),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget _welComeText() {
    return Text(
      'Welcome!',
      style: TextStyle(
        color: Color(0xFFD8D8D8),
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _forgotPassword() {
    return GestureDetector(
      onTap: () {
        moveNextPage(
          context,
          ForgotPassword(),
        );
      },
      child: Text(
        'Forgot Password?',
        style: TextStyle(
          color: Color(0xFFD8D8D8),
          fontSize: 14,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _moveSignUp() {
    return GestureDetector(
      onTap: () {
        moveNextPagePop(
          context,
          SignUpScreen(),
        );
      },
      onLongPress: () {
        Tooltip(
          message: 'Move to Sign Up',
          child: Text('Move to Sign Up'),
        );
      },
      child: Text(
        ' Sign Up',
        style: TextStyle(
          color: Color(0xFF9D9D9D),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
