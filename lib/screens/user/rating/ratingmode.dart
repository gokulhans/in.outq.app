import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:outq/screens/shared/drawer_pages/app_theme.dart';
import 'package:outq/utils/color_constants.dart';
import 'package:outq/utils/widget_functions.dart';

class ModalBottomSheetDemo extends StatefulWidget {
  const ModalBottomSheetDemo({Key? key}) : super(key: key);

  @override
  State<ModalBottomSheetDemo> createState() => _ModalBottomSheetDemoState();
}

class _ModalBottomSheetDemoState extends State<ModalBottomSheetDemo> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('showModalBottomSheet'),
          onPressed: () {
            // when raised button is pressed
            // we display showModalBottomSheet
            showModalBottomSheet<void>(
              // context and builder are
              // required properties in this widget
              context: context,
              builder: (BuildContext context) {
                // we set up a container inside which
                // we create center column and display text

                // Returning SizedBox instead of a Container
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    addVerticalSpace(20),
                    Center(
                      child: Text(
                        'Rate Your Appoinment',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    addVerticalSpace(10),
                    RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    _buildComposer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Center(
                        child: Container(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.6),
                                  offset: const Offset(4, 4),
                                  blurRadius: 8.0),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              },
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Text(
                                    'Send',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    addVerticalSpace(20),
                  ],
                );
              },
            );
          },
        ),
      ),

      // RaisedButton is deprecated and should not be used
      // Use ElevatedButton instead.

      // child: RaisedButton(
      //	 child: const Text('showModalBottomSheet'),
      //	 onPressed: () {

      //	 // when raised button is pressed
      //	 // we display showModalBottomSheet
      //	 showModalBottomSheet<void>(

      //		 // context and builder are
      //		 // required properties in this widget
      //		 context: context,
      //		 builder: (BuildContext context) {

      //		 // we set up a container inside which
      //		 // we create center column and display text
      //		 return Container(
      //			 height: 200,
      //			 child: Center(
      //			 child: Column(
      //				 mainAxisAlignment: MainAxisAlignment.center,
      //				 children: <Widget>[
      //				 const Text('GeeksforGeeks'),
      //				 ],
      //			 ),
      //			 ),
      //		 );
      //		 },
      //	 );
      //	 },
      // ),
    );
  }
}

Widget _buildComposer() {
  return Padding(
    padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
    child: Container(
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              offset: const Offset(4, 4),
              blurRadius: 8),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          padding: const EdgeInsets.all(4.0),
          constraints: const BoxConstraints(minHeight: 80, maxHeight: 120),
          color: AppTheme.white,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
            child: TextField(
              maxLines: null,
              onChanged: (String txt) {},
              style: const TextStyle(
                fontFamily: AppTheme.fontName,
                fontSize: 16,
                color: AppTheme.dark_grey,
              ),
              cursorColor: ColorConstants.blue,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: 'Enter your feedback...'),
            ),
          ),
        ),
      ),
    ),
  );
}
