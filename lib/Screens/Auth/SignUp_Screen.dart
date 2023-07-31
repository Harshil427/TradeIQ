// ignore_for_file: prefer_const_constructors, sort_child_properties_last, file_names, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeiq/Screens/Auth/Login_screen.dart';
import 'package:tradeiq/Services/Auth_Services.dart';
import 'package:tradeiq/Utils/Functions.dart';
import 'package:tradeiq/Widgets/SnackBar.dart';

import '../../Constants/Colors.dart';
import '../../Widgets/Style.dart';
import '../../Widgets/LogoAndComponents.dart';
import '../dashboard/BottomNavigtor.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;
      String confirmPassword = _confirmPasswordController.text;

      if (password == confirmPassword) {
        Future<String> res = AuthServices().signUp(
          email,
          _nameController.text,
          password,
        );

        res.then((result) {
          if (result == 'Success') {
            setState(() {
              _isLoading = false;
            });

            Get.offAll(
              BottomNavigator(),
            );
          } else {
            setState(() {
              _isLoading = false;
            });
            showSnackBarfail(
              'Error',
              result,
              context,
            );
          }
        }).catchError((error) {
          setState(() {
            _isLoading = false;
          });
          showSnackBarfail(
            'Error',
            error.toString(),
            context,
          );
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBarfail(
          'Error',
          'Password and confirm password do not match',
          context,
        );
      }
    } else {
      setState(() {
        _isLoading = false;
      });
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
                  buildLogoWidget(),
                  SizedBox(height: 20),
                  _welComeText(),
                  Container(
                    padding: EdgeInsets.all(20),
                    width: width * .8,
                    child: Column(
                      children: [
                        _buildNameTextField(),
                        SizedBox(height: 20),
                        _buildEmailTextField(),
                        SizedBox(height: 10),
                        _buildPasswordTextField(),
                        SizedBox(height: 10),
                        _buildConfirmPasswordTextField(),
                        SizedBox(height: 20),
                        _buildSignUpButton(),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [_moveToLogin()],
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

  Widget _buildNameTextField() {
    return TextFormField(
      controller: _nameController,
      keyboardType: TextInputType.text,
      decoration: authInputField.copyWith(
        labelText: 'Name',
        prefixIcon: Icon(Icons.person),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your name';
        }
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

  Widget _buildConfirmPasswordTextField() {
    return TextFormField(
      controller: _confirmPasswordController,
      obscureText: !_isConfirmPasswordVisible,
      decoration: authInputField.copyWith(
        labelText: 'Confirm Password',
        prefixIcon: Icon(Icons.lock),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
            });
          },
          child: Icon(
            _isConfirmPasswordVisible ? Icons.visibility_off : Icons.visibility,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please confirm your password';
        }
        if (value != _passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
    );
  }

  Widget _buildSignUpButton() {
    return SizedBox(
      width: _isLoading ? 50 : double.infinity,
      height: 50,
      child: _isLoading
          ? CircularProgressIndicator(
              color: proccessIndicator,
            )
          : ElevatedButton(
              onPressed: () {
                setState(() {
                  _isLoading = true;
                });
                _signUp();
              },
              child: Text(
                'SIGN UP',
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
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
              ),
            ),
    );
  }

  Widget _welComeText() {
    return Text(
      'Create a free account',
      style: TextStyle(
        color: Color(0xFFD8D8D8),
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _moveToLogin() {
    return GestureDetector(
      onTap: () {
        moveNextPagePop(
          context,
          LoginScreen(),
        );
      },
      child: Text(
        'Already have an account? Login',
        style: TextStyle(
          color: Color(0xFF9D9D9D),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
