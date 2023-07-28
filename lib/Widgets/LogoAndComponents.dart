// ignore_for_file: unused_element, prefer_const_literals_to_create_immutables, prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget buildLogoSection() {
  return SizedBox(
    height: 400,
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(
          top: 10,
          child: SvgPicture.asset('Assets/SVG/AuthTop.svg'),
        ),
        Positioned(
          bottom: 10,
          child: Stack(
            children: [
              SvgPicture.asset('Assets/SVG/LogobackAuth.svg'),
              Positioned(
                top: 170,
                left: 100,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'TRADEIQ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text: '\nThe future of trading',
                        style: TextStyle(
                          color: Color(0xFF171717),
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildLogoWidget() {
  return Positioned(
    bottom: 10,
    child: Stack(
      children: [
        SvgPicture.asset('Assets/SVG/LogobackAuth.svg'),
        Positioned(
          top: 170,
          left: 100,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'TRADEIQ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextSpan(
                  text: '\nThe future of trading',
                  style: TextStyle(
                    color: Color(0xFF171717),
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
