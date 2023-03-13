import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outq/screens/user/service/view_service/user_view_service.dart';
import 'package:outq/utils/sizes.dart';

class UserServiceSearchPage extends StatefulWidget {
  const UserServiceSearchPage({super.key});

  @override
  State<UserServiceSearchPage> createState() => _UserServiceSearchPageState();
}

class _UserServiceSearchPageState extends State<UserServiceSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: double.infinity,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: tDefaultSize),
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                padding: const EdgeInsets.only(right: 60, left: 8.0),
                child: Text('Book Your Favorite Shop',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline3)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[100],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 14),
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              child: const SearchListView(),
              onTap: () {
                Get.to(() => const UserSingleServicePage());
              },
            ),
            InkWell(
              child: const SearchListView(),
              onTap: () {
                Get.to(() => const UserSingleServicePage());
              },
            ),
            InkWell(
              child: const SearchListView(),
              onTap: () {
                Get.to(() => const UserSingleServicePage());
              },
            ),
            InkWell(
              child: const SearchListView(),
              onTap: () {
                Get.to(() => const UserSingleServicePage());
              },
            ),
            InkWell(
              child: const SearchListView(),
              onTap: () {
                Get.to(() => const UserSingleServicePage());
              },
            ),
            InkWell(
              child: const SearchListView(),
              onTap: () {
                Get.to(() => const UserSingleServicePage());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SearchListView extends StatelessWidget {
  const SearchListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 100,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(90, 108, 234, 0.07000000029802322),
                offset: Offset(0, 0),
                blurRadius: 40)
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: const Image(
                        image: AssetImage('assets/images/userImage.png'))),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Herbal Pancake',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        'Herbal Pancake',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      Text('₹7',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.headline5),
                    ]),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  width: 100,
                  height: 25,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(17.5),
                      topRight: Radius.circular(17.5),
                      bottomLeft: Radius.circular(17.5),
                      bottomRight: Radius.circular(17.5),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment(0.8459399938583374, 0.1310659646987915),
                      end: Alignment(-0.1310659646987915, 0.11150387674570084),
                      colors: [
                        Color.fromRGBO(83, 130, 231, 1),
                        Color.fromRGBO(20, 130, 231, 1)
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Book',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 12,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w500,
                        height: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
