import 'dart:io';
import 'dart:math';
import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:outq/Backend/models/owner_models.dart';
import 'package:outq/screens/owner/components/appbar/owner_appbar.dart';
import 'package:outq/screens/owner/home/owner_home.dart';
import 'package:outq/screens/owner/service/create/create_service.dart';
import 'package:outq/screens/shared/exit_pop/exit_pop_up.dart';
import 'package:outq/utils/color_constants.dart';
import 'package:outq/utils/constants.dart';
import 'package:outq/utils/sizes.dart';
import 'package:outq/utils/widget_functions.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void onload() {
  dynamic argumentData = Get.arguments;
  // print("test");
  // print(shop.name);
  shop.name = argumentData.name;
  shop.location = argumentData.location;
  shop.id = argumentData.id;
  shop.description = argumentData.description;
  shop.type = argumentData.type;
  shop.img = argumentData.img;
  shop.start = argumentData.start;
  shop.end = argumentData.end;
  shop.employees = argumentData.employees;
}

Future save(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String ownerid = prefs.getString("ownerid") ?? "null";

  if (ownerid == "null") {
    Get.to(() => const Exithome());
  }

  // print({shop.name, shop.type, shop.description, shop.location});
  http.post(
      Uri.parse(
        "${apidomain}store/edit/${shop.type}",
      ),
      headers: <String, String>{
        'Context-Type': 'application/json; charset=UTF-8',
      },
      body: <String, String>{
        'name': shop.name,
        'location': shop.location,
        'id': ownerid,
        'description': shop.description,
        'type': shop.type,
        'img': shop.img,
        'start': shop.start,
        'end': shop.end,
        'employees': shop.employees,
      });

  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
          builder: (BuildContext context) => OwnerHomePage(currentIndex: 1)),
      (Route<dynamic> route) => false);
}

class EditStorePage extends StatefulWidget {
  final ownerid;
  dynamic argumentData = Get.arguments;

  EditStorePage({super.key, required this.ownerid});

  @override
  State<EditStorePage> createState() => _EditStorePageState();
}

class _EditStorePageState extends State<EditStorePage> {
  @override
  void initState() {
    super.initState();
    onload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: OwnerAppBarWithBack(
          title: "",
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: tDefaultSize),
        color: ColorConstants.appbgclr,
        height: double.infinity,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 100,
                padding: const EdgeInsets.only(right: 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    addVerticalSpace(20),
                    Text(
                      'Edit Your Shop Details',
                      textAlign: TextAlign.left,
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: ColorConstants.textclr),
                    ),
                    // Text(
                    //   'This data will be displayed in your account profile.',
                    //   textAlign: TextAlign.left,
                    //   style: Theme.of(context).textTheme.subtitle2,
                    // ),
                  ],
                ),
              ),
              EditStoreForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class EditStoreForm extends StatefulWidget {
  dynamic argumentData = Get.arguments;
  EditStoreForm({super.key});

  @override
  State<EditStoreForm> createState() => _EditStoreFormState();
}

Store shop = Store('', '', '', '', '', '', '', '', '', '', '', '');

class _EditStoreFormState extends State<EditStoreForm> {
  File? _imageFile;
  String imglink = "";
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectOpeningTime(BuildContext context) async {
    final TimeOfDay? pickedS = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedS != null && pickedS != selectedTime) {
      setState(() {
        selectedTime = pickedS;
        final localizations = MaterialLocalizations.of(context);
        final formattedTimeOfDay = localizations.formatTimeOfDay(selectedTime);
        var start = formattedTimeOfDay;
        var end = formattedTimeOfDay;
        shop.start = start;
        // print(start);
      });
    }
  }

  Future<void> _selectClosingTime(BuildContext context) async {
    final TimeOfDay? pickedS = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedS != null && pickedS != selectedTime) {
      setState(() {
        selectedTime = pickedS;
        final localizations = MaterialLocalizations.of(context);
        final formattedTimeOfDay = localizations.formatTimeOfDay(selectedTime);
        var start = formattedTimeOfDay;
        var end = formattedTimeOfDay;
        shop.end = end;
        // print(start);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    imglink = widget.argumentData.img;
    super.initState();
  }

  void _selectImage() async {
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 30);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        print(_imageFile);
      });
      _uploadImage();
    } else {
      print('error');
    }
  }

  void _uploadImage() async {
    final now = DateTime.now();
    final timestamp = now.microsecondsSinceEpoch;
    final random = '${DateTime.now().millisecondsSinceEpoch}${now.microsecond}';
    final publicId = 'service_image_$timestamp$random';
    if (_imageFile != null) {
      final response = await cloudinary.upload(
          file: _imageFile!.path,
          fileBytes: _imageFile!.readAsBytesSync(),
          resourceType: CloudinaryResourceType.image,
          folder: "serviceimages",
          fileName: publicId,
          progressCallback: (count, total) {
            print('Uploading image from file with progress: $count/$total');
          });
      if (response.isSuccessful) {
        print('Get your image from with ${response.secureUrl}');
        setState(() {
          imglink = response.secureUrl!;
        });
      }
      shop.img = imglink;
      print(_imageFile);
    } else {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 12.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 80,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: TextFormField(
                  style: TextStyle(color: ColorConstants.textclr),
                  initialValue: widget.argumentData.name,
                  onChanged: (val) {
                    shop.name = val;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Shop Name',
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    // hintText: widget.argumentData.id,
                  ),
                ),
              ),
              Container(
                height: 80,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: TextFormField(
                  style: TextStyle(color: ColorConstants.textclr),
                  initialValue: widget.argumentData.location,
                  onChanged: (val) {
                    shop.location = val;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Location',
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    // hintText: 'myshop..',
                  ),
                ),
              ),
              Container(
                height: 80,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: TextFormField(
                  style: TextStyle(color: ColorConstants.textclr),
                  initialValue: widget.argumentData.description,
                  onChanged: (val) {
                    shop.description = val;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    // hintText: 'myshop..',
                  ),
                ),
              ),

              addVerticalSpace(30),
              SizedBox(
                width: double.infinity,
                height: 180,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  child: Image(
                    // fit: BoxFit.cover,
                    image: NetworkImage(imglink),
                  ),
                ),
              ),
              addVerticalSpace(30),
              ElevatedButton(
                onPressed: () => _selectImage(),
                child: const Text('Change Image'),
              ),
              addVerticalSpace(20),
              // Container(
              //   height: 80,
              //   padding: const EdgeInsets.symmetric(vertical: 12.0),
              //   clipBehavior: Clip.antiAlias,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(22),
              //   ),
              //   child: TextFormField(
              // style:TextStyle(color:ColorConstants.textclr),
              //     initialValue: widget.argumentData.img,
              //     onChanged: (val) {
              //       shop.img = val;
              //     },
              //     decoration: const InputDecoration(
              //       labelText: 'Image Link',
              //       labelStyle: TextStyle(
              //         fontFamily: 'Montserrat',
              //         fontWeight: FontWeight.bold,
              //         color: Colors.grey,
              //       ),
              //       // hintText: 'myshop..',
              //     ),
              //   ),
              // ),

              Container(
                height: 80,
                // padding: const EdgeInsets.symmetric(vertical: 12.0),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        _selectOpeningTime(context);
                      },
                      child: Container(
                        color: Colors.blue,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Edit Opening Time',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      shop.start,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: ColorConstants.textclr),
                    )
                  ],
                ),
              ),
              Container(
                height: 80,
                // padding: const EdgeInsets.symmetric(vertical: 6.0),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        _selectClosingTime(context);
                      },
                      child: Container(
                        color: Colors.blue,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Edit Closing Time',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      shop.end,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: ColorConstants.textclr),
                    )
                  ],
                ),
              ),
              // Container(
              //   height: 80,
              //   padding: const EdgeInsets.symmetric(vertical: 12.0),
              //   clipBehavior: Clip.antiAlias,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(22),
              //   ),
              //   child: TextFormField(
              // style:TextStyle(color:ColorConstants.textclr),
              //     initialValue: widget.argumentData.start,
              //     // controller: descriptionController,
              //     onChanged: (val) {
              //       shop.start = val;
              //     },
              //     keyboardType: TextInputType.number,
              //     decoration: const InputDecoration(
              //       labelText: 'Store Start time',
              //       labelStyle: TextStyle(
              //         fontFamily: 'Montserrat',
              //         fontSize: 14,
              //         fontWeight: FontWeight.bold,
              //         color: Colors.grey,
              //       ),
              //       // hintText: 'myshop..',
              //     ),
              //   ),
              // ),
              // Container(
              //   height: 80,
              //   padding: const EdgeInsets.symmetric(vertical: 12.0),
              //   clipBehavior: Clip.antiAlias,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(22),
              //   ),
              //   child: TextFormField(
              // style:TextStyle(color:ColorConstants.textclr),
              //     initialValue: widget.argumentData.end,
              //     // controller: descriptionController,
              //     onChanged: (val) {
              //       shop.end = val;
              //     },
              //     keyboardType: TextInputType.number,
              //     decoration: const InputDecoration(
              //       labelText: 'Closing Time',
              //       labelStyle: TextStyle(
              //         fontFamily: 'Montserrat',
              //         fontSize: 14,
              //         fontWeight: FontWeight.bold,
              //         color: Colors.grey,
              //       ),
              //       // hintText: 'myshop..',
              //     ),
              //   ),
              // ),
              Container(
                height: 80,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: TextFormField(
                  style: TextStyle(color: ColorConstants.textclr),
                  initialValue: widget.argumentData.employees,
                  // controller: descriptionController,
                  onChanged: (val) {
                    shop.employees = val;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'No. of employees ',
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    // hintText: 'myshop..',
                  ),
                ),
              ),
              addVerticalSpace(30),
              Container(
                width: 150,
                height: 50,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      ColorConstants.bluegradient1,
                      ColorConstants.bluegradient2
                    ],
                    transform: const GradientRotation(9 * pi / 180),
                  ),
                ),
                child: Center(
                  child: TextButton(
                    child: Text(
                      "Save",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    onPressed: () {
                      shop.type = widget.argumentData.type;
                      shop.id = widget.argumentData.id;
                      save(context);
                    },
                  ),
                ),
              ),
              addVerticalSpace(40)
            ],
          ),
        ));
  }
}
