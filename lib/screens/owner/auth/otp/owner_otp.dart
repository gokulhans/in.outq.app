// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:outq/screens/owner/components/appbar/owner_appbar.dart';
// import 'package:outq/utils/color_constants.dart';
// import 'package:outq/utils/sizes.dart';
// // import 'package:pinput/pinput.dart';

// class OwnerOtpPage extends StatefulWidget {
//   const OwnerOtpPage({super.key});

//   @override
//   State<OwnerOtpPage> createState() => _OwnerOtpPageState();
// }

// class _OwnerOtpPageState extends State<OwnerOtpPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const PreferredSize(
//         preferredSize: Size.fromHeight(60),
//         child: OwnerAppBarWithBack(
//           title: "",
//         ),
//       ),
//       floatingActionButton: Container(
//         width: 150,
//         height: 50,
//         clipBehavior: Clip.antiAlias,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           gradient: LinearGradient(
//             colors: [
//               ColorConstants.bluegradient1,
//               ColorConstants.bluegradient2
//             ],
//             transform: const GradientRotation(9 * pi / 180),
//           ),
//         ),
//         child: Center(
//             child: Text(
//           "Continue",
//           style: Theme.of(context).textTheme.headline6,
//         )),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       body: Container(
//         padding: const EdgeInsets.all(tDefaultSize),
//         color: Colors.white,
//         height: double.infinity,
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 height: 150,
//                 padding: const EdgeInsets.only(right: 60),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Enter 4-digit Verification code',
//                       textAlign: TextAlign.left,
//                       style: Theme.of(context).textTheme.headline3,
//                     ),
//                     Text(
//                       'Code send to +6282045**** . This code will expired in 01:30',
//                       textAlign: TextAlign.left,
//                       style: Theme.of(context).textTheme.subtitle2,
//                     ),
//                   ],
//                 ),
//               ),
//               const PinputExample(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class PinputExample extends StatefulWidget {
//   const PinputExample({Key? key}) : super(key: key);

//   @override
//   State<PinputExample> createState() => _PinputExampleState();
// }

// class _PinputExampleState extends State<PinputExample> {
//   final pinController = TextEditingController();
//   final focusNode = FocusNode();
//   final formKey = GlobalKey<FormState>();

//   @override
//   void dispose() {
//     pinController.dispose();
//     focusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
//     const fillColor = Color.fromRGBO(243, 246, 249, 0);
//     const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

//     final defaultPinTheme = PinTheme(
//       width: 56,
//       height: 56,
//       textStyle: const TextStyle(
//         fontSize: 22,
//         color: Color.fromRGBO(30, 60, 87, 1),
//       ),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(19),
//         border: Border.all(color: borderColor),
//       ),
//     );

//     // return TextField(
//     //   contextMenuBuilder: (_, EditableTextState editableTextState) {
//     //     // print('HEHE');
//     //     return AdaptiveTextSelectionToolbar(
//     //       anchors: editableTextState.contextMenuAnchors,
//     //       children: editableTextState.contextMenuButtonItems.map((ContextMenuButtonItem buttonItem) {
//     //         return CupertinoButton(
//     //           borderRadius: null,
//     //           color: const Color(0xffaaaa00),
//     //           disabledColor: const Color(0xffaaaaff),
//     //           onPressed: buttonItem.onPressed,
//     //           padding: const EdgeInsets.all(10.0),
//     //           pressedOpacity: 0.7,
//     //           child: SizedBox(
//     //             width: 200.0,
//     //             child: Text(
//     //               CupertinoTextSelectionToolbarButton.getButtonLabel(context, buttonItem),
//     //             ),
//     //           ),
//     //         );
//     //       }).toList(),
//     //     );
//     //   },
//     // );

//     /// Optionally you can use form to validate the Pinput
//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Form(
//         key: formKey,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Directionality(
//               // Specify direction if desired
//               textDirection: TextDirection.ltr,
//               child: Pinput(
//                 //controller: pinController,
//                 focusNode: focusNode,
//                 androidSmsAutofillMethod:
//                     AndroidSmsAutofillMethod.smsUserConsentApi,
//                 listenForMultipleSmsOnAndroid: true,
//                 defaultPinTheme: defaultPinTheme,
//                 validator: (value) {
//                   return value == '2222' ? null : 'Pin is incorrect';
//                 },
//                 // onClipboardFound: (value) {
//                 //   debugPrint('onClipboardFound: $value');
//                 //   pinController.setText(value);
//                 // },
//                 hapticFeedbackType: HapticFeedbackType.lightImpact,
//                 onCompleted: (pin) {
//                   debugPrint('onCompleted: $pin');
//                 },
//                 onChanged: (value) {
//                   debugPrint('onChanged: $value');
//                 },
//                 cursor: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Container(
//                       margin: const EdgeInsets.only(bottom: 9),
//                       width: 22,
//                       height: 1,
//                       color: focusedBorderColor,
//                     ),
//                   ],
//                 ),
//                 focusedPinTheme: defaultPinTheme.copyWith(
//                   decoration: defaultPinTheme.decoration!.copyWith(
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(color: focusedBorderColor),
//                   ),
//                 ),
//                 submittedPinTheme: defaultPinTheme.copyWith(
//                   decoration: defaultPinTheme.decoration!.copyWith(
//                     color: fillColor,
//                     borderRadius: BorderRadius.circular(19),
//                     border: Border.all(color: focusedBorderColor),
//                   ),
//                 ),
//                 errorPinTheme: defaultPinTheme.copyBorderWith(
//                   border: Border.all(color: Colors.redAccent),
//                 ),
//               ),
//             ),
//             // Container(
//             //   width: 150,
//             //   height: 50,
//             //   clipBehavior: Clip.antiAlias,
//             //   decoration: BoxDecoration(
//             //     borderRadius: BorderRadius.circular(15),
//             //     gradient: LinearGradient(
//             //       colors: [
//             //         ColorConstants.bluegradient1,
//             //         ColorConstants.bluegradient2
//             //       ],
//             //       transform: const GradientRotation(9 * pi / 180),
//             //     ),
//             //   ),
//             //   child: Padding(
//             //     padding: const EdgeInsets.all(8.0),
//             //     child: Center(
//             //       child: TextButton(
//             //         onPressed: () {
//             //           focusNode.unfocus();
//             //           formKey.currentState!.validate();
//             //         },
//             //         child: Text(
//             //           "Continue",
//             //           style: Theme.of(context).textTheme.headline6,
//             //         ),
//             //       ),
//             //     ),
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
