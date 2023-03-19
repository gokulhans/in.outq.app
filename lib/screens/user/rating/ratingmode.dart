import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outq/screens/shared/drawer_pages/app_theme.dart';
import 'package:outq/screens/user/components/appbar/user_appbar.dart';
import 'package:outq/screens/user/rating/allreviews.dart';
import 'package:outq/utils/color_constants.dart';
import 'package:outq/utils/constants.dart';
import 'package:outq/utils/widget_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ShopRatingModal extends StatefulWidget {
  const ShopRatingModal({Key? key}) : super(key: key);

  @override
  State<ShopRatingModal> createState() => _ShopRatingModalState();
}

double rating = 4.0;
String comment = "";
Future postReview(BuildContext context) async {
  print({' review called', comment, rating});
  SharedPreferences pref = await SharedPreferences.getInstance();
  var userid = pref.getString("userid") ?? "null";
  print({' review called', comment, rating, userid});
  var argumentData = Get.arguments;
  final response = await http.post(
      Uri.parse(
        "${apidomain}review/",
      ),
      headers: <String, String>{
        'Context-Type': 'application/json; charset=UTF-8',
      },
      body: <String, dynamic>{
        'rating': rating.toString(),
        'comment': comment,
        'userid': userid,
        'storeid': argumentData["type"]
      });
  print(response);
  Get.to(() => const AllShopReviews(), arguments: argumentData);
  // Get.to(() => {OwnerHomePage(currentIndex:0)});
  // Navigator.of(context).pop();

  // if (response.statusCode == 201) {
  //   var jsonData = jsonDecode(response.body);
  //   // print(jsonData);
  //   // print(jsonData["success"]);
  //   if (jsonData["success"]) {
  //     service = ServiceModel('', '', '', '', '', '', '', '');
  //     isLoading = false;
  //     Navigator.of(context).pushAndRemoveUntil(
  //         MaterialPageRoute(
  //             builder: (BuildContext context) =>
  //                 OwnerHomePage(currentIndex: 2)),
  //         (Route<dynamic> route) => false);
  //   }
  // }
}

class _ShopRatingModalState extends State<ShopRatingModal> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.yellow[900],
        borderRadius: BorderRadius.circular(4),
      ),
      width: 100,
      height: 40,
      child: TextButton(
        child: Text(
          'Rate Store',
          style: GoogleFonts.montserrat(
              color: ColorConstants.textclrw,
              fontSize: 14,
              fontWeight: FontWeight.w700),
        ),
        onPressed: () {
          Get.to(() => const ShopRatingPage());
        },
      ),
    );
  }
}

// Widget _buildComposer() {
//   return
// }

class ShopRatingPage extends StatefulWidget {
  const ShopRatingPage({super.key});

  @override
  State<ShopRatingPage> createState() => _ShopRatingPageState();
}

class _ShopRatingPageState extends State<ShopRatingPage> {
  var argumentData = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: UserAppBarWithBack(
          title: "Write a Review",
        ),
      ),
      backgroundColor: ColorConstants.appbgclr,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                addVerticalSpace(10),
                Center(
                  child: Text(
                    '${argumentData["name"]}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: ColorConstants.textclrw, fontSize: 18),
                  ),
                ),
                addVerticalSpace(10),
                Center(
                  child: Text(
                    '${argumentData["description"]}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: ColorConstants.textclr, fontSize: 16),
                  ),
                ),
                addVerticalSpace(10),
              ],
            ),
            addVerticalSpace(10),
            RatingBar.builder(
              unratedColor: ColorConstants.iconclr,
              glow: true,
              glowColor: Colors.amber,
              initialRating: rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rate) {
                setState(() {
                  rating = rate;
                });
                print(rating);
              },
            ),
            addVerticalSpace(10),
            Padding(
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
                    constraints:
                        const BoxConstraints(minHeight: 120, maxHeight: 160),
                    color: AppTheme.white,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 0, bottom: 0),
                      child: TextFormField(
                        maxLines: null,
                        onChanged: (txt) {
                          setState(() {
                            comment = txt;
                          });
                        },
                        style: const TextStyle(
                          fontFamily: AppTheme.fontName,
                          fontSize: 16,
                          color: AppTheme.dark_grey,
                        ),
                        cursorColor: ColorConstants.blue,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter your Review...'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            addVerticalSpace(10),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Center(
                child: Container(
                  width: 120,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
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
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: TextButton(
                            onPressed: () {
                              postReview(context);
                            },
                            child: const Text(
                              'Post',
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
            ),
            addVerticalSpace(10),
          ],
        ),
      ),
    );
  }
}
