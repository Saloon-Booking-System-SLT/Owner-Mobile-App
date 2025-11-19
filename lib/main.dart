import 'package:flutter/material.dart';
import 'package:salon_slt/customer/pages/splash_screen.dart';
import 'package:salon_slt/owner/account.dart';
import 'package:salon_slt/owner/addemployee.dart';
import 'package:salon_slt/owner/addservice.dart';
import 'package:salon_slt/owner/dashboardscreen.dart';
import 'package:salon_slt/owner/feedbackdetails.dart';
import 'package:salon_slt/owner/feedbackreply.dart';
import 'package:salon_slt/owner/feedbackscreen.dart';

import 'package:salon_slt/owner/imageupload.dart';
import 'package:salon_slt/owner/login.dart';
import 'package:salon_slt/owner/manageemployee.dart';
import 'package:salon_slt/owner/manageservice.dart';
import 'package:salon_slt/owner/navigationscreen.dart';
import 'package:salon_slt/owner/register.dart';
import 'package:salon_slt/owner/salonprofile.dart';
import 'package:salon_slt/owner/successscreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
            home: const MainNavigationScreen(),

    );
  }
}
