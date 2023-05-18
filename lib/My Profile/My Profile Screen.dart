import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Api/api.dart';
import '../ColorConstant/ColorConstant.dart';
import '../Screens/Drawer/DrawerScreen.dart';
import 'Change Password Screen.dart';
import 'package:http/http.dart' as http;

class MyProfile_Screen extends StatefulWidget {
  const MyProfile_Screen({Key? key}) : super(key: key);

  @override
  State<MyProfile_Screen> createState() => _MyProfile_ScreenState();
}

class _MyProfile_ScreenState extends State<MyProfile_Screen> {

  TextEditingController UserName = TextEditingController();
  TextEditingController FirstName = TextEditingController();
  TextEditingController LastName = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController Storename = TextEditingController();
  TextEditingController Business = TextEditingController();
  TextEditingController Position = TextEditingController();
  TextEditingController Phone = TextEditingController();
  TextEditingController Secondnumber = TextEditingController();
  TextEditingController Whatsapp = TextEditingController();
  TextEditingController Registration_number = TextEditingController();
  TextEditingController Location = TextEditingController();
  TextEditingController Description = TextEditingController();



  bool isReload = false;
  String photo = "";

  File? imgFile;
  final imgPicker = ImagePicker();


  Future _pickProfileImage(ImageSource source) async {
    final imageLogo = await ImagePicker().getImage(
        source: source, imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
    setState(() {
      imgFile = File(imageLogo!.path);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetProfilAPIcall();
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: const Icon(
                      Icons.photo_library,
                      color: Colors.black,
                    ),
                    title: const Text('Photo Library',
                        style: TextStyle(
                          color: Colors.black,
                        )),
                    onTap: () {
                      _pickProfileImage(ImageSource.gallery);
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: const Icon(
                    Icons.photo_camera,
                    color: Colors.black,
                  ),
                  title: const Text('Camera',
                      style: TextStyle(
                        color: Colors.black,
                      )),
                  onTap: () {
                    _pickProfileImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const DrawerScreen(),
              ),
            );
          },
          icon: Container(
            height: 50,
            width: 50,
            decoration:
                const BoxDecoration(shape: BoxShape.circle, color: maincolor),
            child: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
        ),
        title: const Text(
          "My Profile",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: CupertinoColors.systemGrey5,
        elevation: 0,
        centerTitle: true,
      ),
      body: (isReload == false)
          ? Form(
              child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            height: 120,
                            width: 120,
                            left: 0,
                            //(MediaQuery.of(context).size.width/2) -70,
                            child: GestureDetector(
                              onTap: () {
                                _showPicker(context);
                              },
                              child: imgFile == null
                                  ? (photo == "" || photo == null)
                                  ? const CircleAvatar(
                                backgroundImage:
                                AssetImage("assets/images/user.png"),
                                radius: 70,
                              )
                                  : CircleAvatar(
                                backgroundImage:
                                NetworkImage(photo.trim()),
                                radius: 70,
                              )
                                  : CircleAvatar(
                                backgroundImage: FileImage(imgFile!),
                                radius: 70,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 85,
                            left: 85,
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  // _openGallery(context);
                                  _showPicker(context);
                                },
                                icon: const Icon(
                                  Icons.edit,size: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                       "User Name",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),

                        ),
                      ),
                    SizedBox(height: 10,),
                    Container(
                      height: 55,
                      width: width,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: UserName,
                        style: TextStyle(color: maincolor),
                         readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: CupertinoColors.systemGrey2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: CupertinoColors.systemGrey2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: CupertinoColors.systemGrey2,
                            ),
                          ),

                          labelStyle: const TextStyle(
                              color: CupertinoColors.systemGrey2,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        "First Name",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),

                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 55,
                      width: width,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: FirstName,
                        style: TextStyle(color: maincolor),
                        // readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: CupertinoColors.systemGrey2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: CupertinoColors.systemGrey2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: CupertinoColors.systemGrey2,
                            ),
                          ),
                          hintText: "First Name",
                          hintStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: CupertinoColors.systemGrey2),
                          labelStyle: const TextStyle(
                              color: CupertinoColors.systemGrey2,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        "Last Name",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),

                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 55,
                      width: width,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: LastName,
                        style: TextStyle(color: maincolor),
                        // readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: CupertinoColors.systemGrey2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: CupertinoColors.systemGrey2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: CupertinoColors.systemGrey2,
                            ),
                          ),
                          hintText: "Last Name",
                          hintStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: CupertinoColors.systemGrey2),
                          labelStyle: const TextStyle(
                              color: CupertinoColors.systemGrey2,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        "Email",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),

                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 55,
                      width: width,
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: Email,
                        style: TextStyle(color: maincolor),
                        // readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: CupertinoColors.systemGrey2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: CupertinoColors.systemGrey2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: CupertinoColors.systemGrey2,
                            ),
                          ),
                          hintText: "Email",
                          hintStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: CupertinoColors.systemGrey2),
                          labelStyle: const TextStyle(
                              color: CupertinoColors.systemGrey2,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        "Store Information",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),

                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 55,
                      width: width,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: Storename,
                        style: TextStyle(color: maincolor),
                        // readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: CupertinoColors.systemGrey2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: CupertinoColors.systemGrey2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: CupertinoColors.systemGrey2,
                            ),
                          ),
                          hintText: "Store Name",
                          hintStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: CupertinoColors.systemGrey2),
                          labelStyle: const TextStyle(
                              color: CupertinoColors.systemGrey2,
                              fontSize: 18),
                        ),
                      ),
                    ),

                    SizedBox(height: 10,),
                    Container(
                      height: 55,
                      width: width,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: Business,
                        style: TextStyle(color: maincolor),
                        // readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: CupertinoColors.systemGrey2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: CupertinoColors.systemGrey2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: CupertinoColors.systemGrey2,
                            ),
                          ),
                          hintText: "Type Of Business",
                          hintStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: CupertinoColors.systemGrey2),
                          labelStyle: const TextStyle(
                              color: CupertinoColors.systemGrey2,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 55,
                      width: width,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: Position,
                        style: TextStyle(color: maincolor),
                        // readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: CupertinoColors.systemGrey2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: CupertinoColors.systemGrey2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: CupertinoColors.systemGrey2,
                            ),
                          ),
                          hintText: "Position",
                          hintStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: CupertinoColors.systemGrey2),
                          labelStyle: const TextStyle(
                              color: CupertinoColors.systemGrey2,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 55,
                      width: width,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: Phone,
                        style: TextStyle(color: maincolor),
                        // readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: CupertinoColors.systemGrey2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: CupertinoColors.systemGrey2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: CupertinoColors.systemGrey2,
                            ),
                          ),
                          hintText: "Phone",
                          hintStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: CupertinoColors.systemGrey2),
                          labelStyle: const TextStyle(
                              color: CupertinoColors.systemGrey2,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 55,
                      width: width,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: Secondnumber,
                        style: TextStyle(color: maincolor),
                        // readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: CupertinoColors.systemGrey2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: CupertinoColors.systemGrey2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: CupertinoColors.systemGrey2,
                            ),
                          ),
                          hintText: "Second telephone number",
                          hintStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: CupertinoColors.systemGrey2),
                          labelStyle: const TextStyle(
                              color: CupertinoColors.systemGrey2,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 55,
                      width: width,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: maincolor),
                        controller: Whatsapp,
                        // readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: CupertinoColors.systemGrey2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: CupertinoColors.systemGrey2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: CupertinoColors.systemGrey2,
                            ),
                          ),
                          hintText: "Whatsapp Number",
                          hintStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: CupertinoColors.systemGrey2),
                          labelStyle: const TextStyle(
                              color: CupertinoColors.systemGrey2,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 55,
                      width: width,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: Registration_number,
                        style: TextStyle(color: maincolor),
                        // readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: CupertinoColors.systemGrey2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: CupertinoColors.systemGrey2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: CupertinoColors.systemGrey2,
                            ),
                          ),
                          hintText: "Registartion Number",
                          hintStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: CupertinoColors.systemGrey2),
                          labelStyle: const TextStyle(
                              color: CupertinoColors.systemGrey2,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 55,
                      width: width,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: Location,
                        style: TextStyle(color: maincolor),
                        // readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: CupertinoColors.systemGrey2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: CupertinoColors.systemGrey2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: CupertinoColors.systemGrey2,
                            ),
                          ),
                          hintText: "Location",
                          hintStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: CupertinoColors.systemGrey2),
                          labelStyle: const TextStyle(
                              color: CupertinoColors.systemGrey2,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 55,
                      width: width,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: Description,
                        style: TextStyle(color: maincolor),
                        // readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: CupertinoColors.systemGrey2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: CupertinoColors.systemGrey2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: CupertinoColors.systemGrey2,
                            ),
                          ),
                          hintText: "Description",
                          hintStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: CupertinoColors.systemGrey2),
                          labelStyle: const TextStyle(
                              color: CupertinoColors.systemGrey2,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(height: 25,),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: maincolor
                      ),
                        height: 50,
                        width: width/1-200,
                        child: TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Changepassword_Screen()));
                        }, child: Text("Change Password",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white),))),
                    SizedBox(height: 30,),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: maincolor
                        ),
                        height: 50,
                        width: width/1-100,
                        child: TextButton(onPressed: (){}, child: Text("Submit",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white),))),






                  ],
                ),
              ),
            ))
          : const Center(
              child: CircularProgressIndicator(
                color: maincolor,
              ),
            ),
    ));
  }



  GetProfilAPIcall() async {
    setState(() {
      isReload = true;
    });
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token") ?? "";
      var user_id = prefs.getString("uid") ?? "";

      final Header = {
        "Authorization": "Bearer ${token.toString()}",
      };

      //   var response = await http.post(Uri.parse(login), body: body);
      var response = await http.get(
        Uri.parse(getUsertProfile_Api + user_id),
        headers: Header,
      );

      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        print(decode);



        setState(() {
          prefs.setString(
              "Name", decode["data"][0]["Name"].toString());
          UserName.text = decode["data"][0]["Name"].toString();
          FirstName.text = decode["data"][0]["first_name"].toString();

          LastName.text = decode["data"][0]["last_name"].toString();
          Email.text = decode["data"][0]["user_email"].toString();
          Storename.text = decode["data"][0]["storename"].toString();
          Business.text = decode["data"][0]["businesstype"].toString();
          Position.text = decode["data"][0]["position"].toString();
          Phone.text = decode["data"][0]["phone"].toString();
          Secondnumber.text = decode["data"][0]["mobile"].toString();
          Whatsapp.text = decode["data"][0]["whatsapp"].toString();
          Registration_number.text = decode["data"][0]["regisration"].toString();
          Description.text = decode["data"][0]["description"].toString();


        //  var userPhoto = decode["data"][0]["profile_image"].toString();


          // if (userPhoto != "" || userPhoto != null) {
          //   imgFile = userPhoto;
          //   print("photo $imgFile");
          // } else {
          //   print("");
          // }


        });

        setState(() {
          isReload = false;
        });
      } else {
        print("Error" + response.statusCode.toString());
        print("Error" + response.body.toString());

        setState(() {
          isReload = false;
        });
      }
    } catch (e) {
      setState(() {
        isReload = false;
      });
      print("Exception in Today Attendance=>" + e.toString());
      throw e;
    }
  }

}
