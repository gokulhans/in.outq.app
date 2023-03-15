import 'dart:convert';
import 'dart:developer';
import 'dart:math';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:outq/Backend/models/owner_models.dart';
import 'package:outq/screens/owner/components/appbar/owner_appbar.dart';
import 'package:outq/screens/owner/home/owner_home.dart';
import 'package:outq/utils/color_constants.dart';
import 'package:outq/utils/constants.dart';
import 'package:outq/utils/sizes.dart';
import 'package:outq/utils/widget_functions.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloudinary/cloudinary.dart';

bool isLoading = false;

// final cloudinary = CloudinaryPublic('dybp5kdy7', 'outqservices', cache: false);
Cloudinary cloudinary = Cloudinary.signedConfig(
  cloudName: 'dybp5kdy7',
  apiKey: '732197174288973',
  apiSecret: 'lz9XKeaVatdP3OjGB-ADMlRPapc',
);

Future save(BuildContext context) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  var storeid = pref.getString("storeid") ?? "null";
  var ownerid = pref.getString("ownerid") ?? "null";

  final response = await http.post(
      Uri.parse(
        "${apidomain}service/create/",
      ),
      headers: <String, String>{
        'Context-Type': 'application/json; charset=UTF-8',
      },
      body: <String, String>{
        'name': service.name,
        'description': service.description,
        'price': service.price,
        'ogprice': service.ogprice,
        'img': service.img,
        'storeid': storeid,
        'ownerid': ownerid,
        'duration': service.duration,
      });
  // Get.to(() => {OwnerHomePage(currentIndex:0)});
  // Navigator.of(context).pop();

  if (response.statusCode == 201) {
    var jsonData = jsonDecode(response.body);
    // print(jsonData);
    // print(jsonData["success"]);
    if (jsonData["success"]) {
      service = ServiceModel('', '', '', '', '', '', '', '');
      isLoading = false;
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  OwnerHomePage(currentIndex: 2)),
          (Route<dynamic> route) => false);
    }
  }
}

class CreateServicePage extends StatefulWidget {
  const CreateServicePage({super.key});

  @override
  State<CreateServicePage> createState() => _CreateServicePageState();
}

class _CreateServicePageState extends State<CreateServicePage> {
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
        color: Colors.white,
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
                      'Fill Your Service Details',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    // Text(
                    //   'This data will be displayed in your account profile.',
                    //   textAlign: TextAlign.left,
                    //   style: Theme.of(context).textTheme.subtitle2,
                    // ),
                  ],
                ),
              ),
              const CreateServiceForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateServiceForm extends StatefulWidget {
  const CreateServiceForm({super.key});

  @override
  State<CreateServiceForm> createState() => _CreateServiceFormState();
}

ServiceModel service = ServiceModel('', '', '', '', '', '', '', '');

class _CreateServiceFormState extends State<CreateServiceForm> {
  // Future<void> pickImage(ImageSource source) async {
  //   final pickedFile = await ImagePicker().pickImage(source: source);
  //   if (pickedFile != null) {
  //     selectFile(pickedFile);
  //   }
  // }
  String imglink =
      "https://via.placeholder.com/1920x1080/eee?text=Service-Image";
  File? _imageFile;
  String _priview = "Image is mandatory ";

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
            setState(() {
              _priview =
                  'Uploading image from file with progress: $count/$total';
            });
          });
      if (response.isSuccessful) {
        print('Get your image from with ${response.secureUrl}');
        setState(() {
          imglink = response.secureUrl!;
          _priview = 'Image uploaded Successfully';
        });
      }
      service.img = imglink;
      print(_imageFile);
    } else {
      print('error');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    service.img = imglink;
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
              ElevatedButton(
                onPressed: () => _selectImage(),
                child: Text('Upload Image'),
              ),
              addVerticalSpace(20),
              Text(_priview),
              addVerticalSpace(20),
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
              addVerticalSpace(50),
              Container(
                height: 80,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: TextFormField(
                  initialValue: service.name,
                  onChanged: (val) {
                    service.name = val;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    // hintText: 'myservice..',
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
                  initialValue: service.description,
                  onChanged: (val) {
                    service.description = val;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    // hintText: 'myservice..',
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
                  initialValue: service.ogprice,
                  onChanged: (val) {
                    service.ogprice = val;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Original Price',
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    // hintText: 'myservice..',
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
                  initialValue: service.price,
                  onChanged: (val) {
                    service.price = val;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Discounted Price',
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    // hintText: 'myservice..',
                  ),
                ),
              ),
              // Container(
              //   height: 80,
              //   padding: const EdgeInsets.symmetric(vertical: 12.0),
              //   clipBehavior: Clip.antiAlias,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(22),
              //   ),
              //   child: TextField(
              //     onChanged: (val) {
              //       service.img = val;
              //     },
              //     decoration: const InputDecoration(
              //       labelText: 'Image Link',
              //       labelStyle: TextStyle(
              //         fontFamily: 'Montserrat',
              //         fontWeight: FontWeight.bold,
              //         color: Colors.grey,
              //       ),
              //       // hintText: 'myservice..',
              //     ),
              //   ),
              // ),

              addVerticalSpace(10),

              Container(
                height: 80,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: TextFormField(
                  initialValue: service.duration,
                  onChanged: (val) {
                    service.duration = val;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Service Duration in Minutes',
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                    // hintText: 'myservice..',
                  ),
                ),
              ),
              addVerticalSpace(20),
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
                    onPressed: !isLoading
                        ? () {
                            setState(() {
                              isLoading = true;
                            });
                            print('called');
                            if (service.name.isEmpty ||
                                // service.description.isEmpty ||
                                service.price.isEmpty ||
                                service.ogprice.isEmpty ||
                                service.duration.isEmpty) {
                              Get.snackbar(
                                "Fill Every Field",
                                "Fill every fields to continue",
                                icon: const Icon(Icons.person,
                                    color: Colors.white),
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                borderRadius: 12,
                                margin: const EdgeInsets.all(15),
                                colorText: Colors.white,
                                duration: const Duration(seconds: 3),
                                isDismissible: true,
                                dismissDirection: DismissDirection.horizontal,
                                forwardAnimationCurve: Curves.bounceIn,
                              );
                              setState(() {
                                isLoading = false;
                              });
                            } else {
                              setState(() {
                                isLoading = true;
                              });

                              save(context);
                            }
                          }
                        : null,
                    child: isLoading
                        ? const Center(
                            child: SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Text(
                            "Save",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                  ),
                ),
              ),
              addVerticalSpace(40)
            ],
          ),
        ));
  }
}
