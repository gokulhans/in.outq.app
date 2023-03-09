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
import 'package:outq/utils/color_constants.dart';
import 'package:outq/utils/constants.dart';
import 'package:outq/utils/sizes.dart';
import 'package:outq/utils/widget_functions.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


Cloudinary cloudinary = Cloudinary.signedConfig(
  cloudName: 'dybp5kdy7',
  apiKey: '732197174288973',
  apiSecret: 'lz9XKeaVatdP3OjGB-ADMlRPapc',
);

void onload() {
  dynamic argumentData = Get.arguments;
  service.name = argumentData.name;
  service.description = argumentData.description;
  service.price = argumentData.price;
  service.ogprice = argumentData.ogprice;
  service.img = argumentData.img;
  service.ownerid = argumentData.ownerid;
  service.duration = argumentData.duration;
  service.id = argumentData.id;
}

Future save(BuildContext context) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  var storeid = pref.getString("storeid") ?? " ";

  dynamic argumentData = Get.arguments;
  var response = await http.post(
      Uri.parse(
        "${apidomain}service/edit/${service.id}",
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
        'ownerid': service.ownerid,
        'duration': service.duration,
        'id': service.id,
      });
  // Get.to(() => {OwnerHomePage(currentIndex:0)});
  // Navigator.of(context).pop();
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
          builder: (BuildContext context) => OwnerHomePage(
                currentIndex: 2,
              )),
      (Route<dynamic> route) => false);
}

class EditServicePage extends StatefulWidget {
  dynamic argumentData = Get.arguments;
  EditServicePage({super.key});
  @override
  State<EditServicePage> createState() => _EditServicePageState();
}

class _EditServicePageState extends State<EditServicePage> {
  @override
  void initState() {
    super.initState();
    onload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: OwnerAppBarWithBack(
          title: widget.argumentData.name,
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
                height: 120,
                padding: const EdgeInsets.only(right: 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Edit Service Details',
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
              EditServiceForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class EditServiceForm extends StatefulWidget {
  dynamic argumentData = Get.arguments;
  EditServiceForm({super.key});

  @override
  State<EditServiceForm> createState() => _EditServiceFormState();
}

GetServiceModel service =
    GetServiceModel('', '', '', '', '', '', '', '', '', '', '', '', '');

class _EditServiceFormState extends State<EditServiceForm> {
  String imglink = "";
  File? _imageFile;
  String _priview = " ";

  void _selectImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 30);
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

  @override
  void initState() {
    imglink = widget.argumentData.img;
    // TODO: implement initState
    super.initState();
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
              Text(_priview),

              addVerticalSpace(30),

              Container(
                height: 80,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: TextFormField(
                  initialValue: widget.argumentData.name,
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
                  initialValue: widget.argumentData.description,
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
                  initialValue: widget.argumentData.price,
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
              Container(
                height: 80,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: TextFormField(
                  initialValue: widget.argumentData.ogprice,
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
              // Container(
              //   height: 80,
              //   padding: const EdgeInsets.symmetric(vertical: 12.0),
              //   clipBehavior: Clip.antiAlias,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(22),
              //   ),
              //   child: TextFormField(
              //     initialValue: widget.argumentData.img,
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
              
              addVerticalSpace(20),
              Container(
                height: 80,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: TextFormField(
                  initialValue: widget.argumentData.duration,
                  onChanged: (val) {
                    service.duration = val;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Service Duration',
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
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
                    onPressed: () {
                      save(context);
                    },
                    child: Text(
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
