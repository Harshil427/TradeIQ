// ignore_for_file: sort_child_properties_last, prefer_const_constructors, use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tradeiq/Screens/Auth/Login_screen.dart';
import 'package:tradeiq/Services/Auth_Services.dart';
import 'package:tradeiq/Utils/Functions.dart';

import '../../Constants/Colors.dart';
import '../../Widgets/LogoAndComponents.dart';
import '../../Widgets/SnackBar.dart';
import '../../Widgets/Style.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'TRADEIQ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                    height: 100, child: buildLogoWidget()), // Display the logo
                SvgPicture.asset(
                  'Assets/SVG/forgotPassword.svg',
                  height: height * .4,
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: width * .6,
                  // height: 72,
                  child: Text(
                    'We have sent you an email to change your password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFD8D8D8),
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  width: width * .8,
                  child: Column(
                    children: [
                      _buildEmailTextField(),
                      SizedBox(
                        height: 20,
                      ),
                      _buildSentEmailButton(context),
                    ],
                  ),
                ),
              ],
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
    );
  }

  Widget _buildSentEmailButton(BuildContext context) {
    return SizedBox(
      width: _isLoading ? 50 : double.infinity,
      height: 50,
      child: _isLoading
          ? CircularProgressIndicator(
              color: proccessIndicator,
            )
          : ElevatedButton(
              onPressed: () {
                if (_emailController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter your email'),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else {
                  setState(() {
                    _isLoading = true;
                  });
                  sentResetEmail(context);
                }
              },
              child: Text(
                'SENT EMAIL',
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

  void sentResetEmail(BuildContext context) {
    String email = _emailController.text.trim();

    Future<String> res = AuthServices().resetPassword(email);

    res.then((result) async {
      if (result == 'Success') {
        setState(() {
          _isLoading = false;
        });
        showSnackBarSuccess(
          'Success',
          'Password reset email sent successfully.',
          context,
        );
        await Future.delayed(Duration(seconds: 3)).then((value) {
          showSnackBarHelp(
            'Info',
            'You Can Login After Change Password',
            context,
          );
          moveNextPage(
            context,
            LoginScreen(),
          );
        });
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
  }
}
