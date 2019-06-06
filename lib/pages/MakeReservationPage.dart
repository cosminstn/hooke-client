// import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:hooke/common_widgets/HookeLogoText.dart';
// import 'package:hooke/common_widgets/HookeLogo.dart';
// import 'package:hooke/manager_pages/AdminHomePage.dart';
// import 'package:hooke/pages/RegisterPage.dart';
// import 'package:hooke/pages/ConsumerHomePage.dart';
// import 'package:hooke/pages/RestaurantsListPage.dart';
// import 'package:hooke/utils/Constants.dart';
// import 'package:hooke/utils/Globals.dart';
// import 'package:hooke/utils/Utils.dart';
// import 'package:http/http.dart' as http;
// import 'package:logging/logging.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';

// class MakeReservationPage extends StatefulWidget {
//   static String tag = 'reservation-page';
//   @override
//   _MakeReservationPageState createState() => new _MakeReservationPageState();
// }



// class _MakeReservationPageState extends State<MakeReservationPage> {
//   bool _inProgress = false;
//   DateTime selectedArrivingDate = DateTime.now();
//   DateTime selectedLeavingDate = DateTime.now();
//   final numberOfPeopleController = TextEditingController();
//   final ariveController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   Widget build(BuildContext context) {
//     final Size screenSize = MediaQuery.of(context).size;
//     final numberOfPeopleField = Padding(
//         padding: EdgeInsets.only(top: 12),
//         child: TextFormField(
//           keyboardType: TextInputType.number,
//           autofocus: false,
//           controller: numberOfPeopleController,
//           style: TextStyle(fontSize: 18),
//           decoration: InputDecoration(
//               labelText: 'Enter the number of people',
//               hintText: 'Number of people',
//               contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
//               border:
//                   OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
//         ));
//     Future<Null> _selectArrivingDate(BuildContext context) async {
//       final DateTime pickedArrival = await showDatePicker(
//           context: context,
//           initialDate: DateTime.now(),
//           firstDate: DateTime(2019, 8),
//           lastDate: DateTime(2101));
//       if (pickedArrival != null && pickedArrival != selectedArrivingDate)
//         setState(() {
//           selectedArrivingDate = pickedArrival;
//         });
//     }
//        Future<Null> _selectLeavingDate(BuildContext context) async {
//       final pickedLeaving = await showDatePicker(
//           context: context,
//           initialDate: DateTime.now(),
//           firstDate: DateTime(2019, 8),
//           lastDate: DateTime(2101));
//       if (pickedLeaving != null && pickedLeaving != selectedLeavingDate)
//         setState(() {
//           selectedLeavingDate = pickedLeaving;
//         });
//     }
//     ariveController = selectedArrivingDate;
//     return Center(
//       child: Form(
//         key: _formKey,
//         child: ListView(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           children: <Widget>[
//             numberOfPeopleField,
//             selectedArrivingDate,
//             selectedLeavingDate
            
//           ],
//           padding: EdgeInsets.all(10),
//         )
//     )
//     );
//   }
// }
