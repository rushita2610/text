import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reapp_ghana_project/Screens/Upload/Stock%20List.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Api/api.dart';
import '../../ColorConstant/ColorConstant.dart';
import '../../My Ads/My Ads Screen.dart';
import '../Drawer/DrawerScreen.dart';
import 'Brand List.dart';
import 'Category List.dart';
import 'package:http/http.dart' as http;

class Makenewad_Screen extends StatefulWidget {
  // String categories;
  // String subcategory;

  Makenewad_Screen({
    Key? key,
    // required this.categories,
    // required this.subcategory,
  }) : super(key: key);

  @override
  State<Makenewad_Screen> createState() => _Makenewad_ScreenState();
}

String selectedADCategory = "Category";
String selectedADStock = "Select Stock";
String selectedADBrand = "Select Brand";
File? imgFile = null;

// String selectedADCategory = "";
Map Newad = {};

class _Makenewad_ScreenState extends State<Makenewad_Screen> {
  bool isReload = false;

  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController Title = TextEditingController();
  TextEditingController Category = TextEditingController();
  TextEditingController Content = TextEditingController();
  TextEditingController Stock = TextEditingController();
  TextEditingController Brand = TextEditingController();
  TextEditingController Price = TextEditingController();
  TextEditingController DiscountPrice = TextEditingController();
  TextEditingController SpecialOffer = TextEditingController();
  TextEditingController Tags = TextEditingController();

  TextEditingController UploadImage = TextEditingController();
  String photo = "";
  final imgPicker = ImagePicker();

  Future _pickProfileImage(ImageSource source) async {
    final imageLogo = await ImagePicker().getImage(
        source: source, imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
    setState(() {
      imgFile = File(imageLogo!.path);
    });
  }

  addData() {
    Newad["title"] = Title.text.toString();
    Newad["description"] = Content.text.toString();
    Newad["price"] = Price.text.toString();
    Newad["discountprice"] = DiscountPrice.text.toString();
    Newad["specialoffer"] = SpecialOffer.text.toString();
    Newad["tags"] = Tags.text.toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Title.text =
        Newad["title"].toString() == "null" ? "" : Newad["title"].toString();
    Content.text = Newad["description"].toString() == "null"
        ? ""
        : Newad["description"].toString();
    Price.text =
        Newad["price"].toString() == "null" ? "" : Newad["price"].toString();
    DiscountPrice.text = Newad["discountprice"].toString() == "null"
        ? ""
        : Newad["discountprice"].toString();
    SpecialOffer.text = Newad["specialoffer"].toString() == "null"
        ? ""
        : Newad["specialoffer"].toString();
    Tags.text =
        Newad["tags"].toString() == "null" ? "" : Newad["tags"].toString();
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: <Widget>[
                // Container(
                //   color: Colors.red,
                //   width: MediaQuery.of(context).size.width,
                //   child: Row(
                //     children: [
                //       Container(
                //         alignment: Alignment.center,
                //         child: Text("Select image",textAlign: TextAlign.center,),
                //       ),
                //     ],
                //   ),
                // ),
                ListTile(
                    leading: const Icon(
                      Icons.photo_camera,
                      color: Colors.black,
                    ),
                    title: const Text('Take photo',
                        style: TextStyle(
                          color: Colors.black,
                        )),
                    onTap: () {
                      _pickProfileImage(ImageSource.camera);
                      Navigator.of(context).pop();
                    }),
                const Divider(
                  height: 1,
                  color: CupertinoColors.systemGrey,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.photo_library,
                    color: Colors.black,
                  ),
                  title: const Text('chose from Library',
                      style: TextStyle(
                        color: Colors.black,
                      )),
                  onTap: () {
                    _pickProfileImage(ImageSource.gallery);
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

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _drawerKey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _drawerKey.currentState?.openDrawer();
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
          "Make New Ad",
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
      drawer: DrawerScreen(),
      body: (isReload == false)
          ? Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Container(
                  height: height * 1.7,
                  // padding: EdgeInsets.all(15),
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 50),
                  child: Column(
                    children: [
                      Container(
                        alignment: AlignmentDirectional.topStart,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            text: "Title",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                            children: <TextSpan>[
                              TextSpan(
                                text: "*",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 55,
                        width: width,
                        child: TextFormField(
                          controller: Title,
                          keyboardType: TextInputType.text,
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
                            hintText: "Title",
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
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: AlignmentDirectional.topStart,
                        child: const Text(
                          "Upload Image",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: CupertinoColors.systemGrey2),
                            borderRadius: BorderRadius.circular(10)),
                        height: height * 0.20,
                        width: width,
                        child: InkWell(
                          onTap: () {
                            _showPicker(context);
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(top: 20),
                                child: const Icon(
                                  Icons.upload,
                                  size: 45,
                                  color: maincolor,
                                ),
                              ),
                              Container(
                                child: const Text(
                                  "Click to upload files",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: CupertinoColors.systemGrey2,
                                  ),
                                ),
                              ),
                              imgFile == null
                                  ? const SizedBox()
                                  : Column(
                                      children: [
                                        Container(
                                          height: 60,
                                          width: 40,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                top: 0,
                                                height: 70,
                                                left: 0,
                                                //(MediaQuery.of(context).size.width/2) -70,
                                                child: ClipRRect(
                                                  //borderRadius: BorderRadius.circular(85),
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.only(),
                                                    alignment:
                                                        Alignment.topLeft,
                                                    // height: 180,
                                                    child: Image.file(
                                                      imgFile!,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                //top: 0,
                                                left: 20,
                                                right: 0,
                                                bottom: 60,

                                                child: Container(
                                                  height: 10,
                                                  width: 10,
                                                  decoration:
                                                      const BoxDecoration(
                                                    //color: Color(0xFF000052),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        // imageCache.clear();
                                                        // print("remove $imgFile");
                                                        imgFile = null;
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      CupertinoIcons
                                                          .clear_circled_solid,
                                                      color: Colors.black,
                                                      size: 15,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: AlignmentDirectional.topStart,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            text: "Category",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                            children: <TextSpan>[
                              TextSpan(
                                text: "*",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: height * 0.058,
                        width: width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: CupertinoColors.systemGrey5),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: Category,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            suffixIcon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: CupertinoColors.systemGrey,
                            ),
                            hintText: selectedADCategory.toString(),
                            hintStyle: const TextStyle(
                                fontSize: 14, color: Colors.black),
                            labelStyle: const TextStyle(
                                color: CupertinoColors.systemGrey2,
                                fontSize: 18),
                          ),
                          onTap: () {
                            addData();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Categorylist_Screen()));
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: AlignmentDirectional.topStart,
                        child: const Text(
                          "Enter Product Description",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: height * 0.15,
                        width: width,
                        child: TextFormField(
                          maxLines: 8,
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: maincolor),
                          controller: Content,
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
                            hintText: "Enter Product Description",
                            hintStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: CupertinoColors.systemGrey2,
                            ),
                            labelStyle: const TextStyle(
                                color: CupertinoColors.systemGrey2,
                                fontSize: 18),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: height * 0.058,
                        width: width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: CupertinoColors.systemGrey5),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: Stock,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            suffixIcon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: CupertinoColors.systemGrey,
                            ),
                            hintText: selectedADStock,
                            hintStyle: const TextStyle(
                                fontSize: 14, color: Colors.black),
                            labelStyle: const TextStyle(
                                color: CupertinoColors.systemGrey2,
                                fontSize: 18),
                          ),
                          onTap: () {
                            // print("popularloc.toString() ${NewadList}");
                            // String S_Id = NewadList["data"]["id"].toString();
                            addData();

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Stocklist_Screen()));
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        alignment: AlignmentDirectional.topStart,
                        child: const Text(
                          "Brand (Optional)",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: height * 0.058,
                        width: width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: CupertinoColors.systemGrey5),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: Brand,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            suffixIcon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: CupertinoColors.systemGrey,
                            ),
                            hintText: selectedADBrand,
                            hintStyle: const TextStyle(
                                fontSize: 14, color: Colors.black),
                            labelStyle: const TextStyle(
                                color: CupertinoColors.systemGrey2,
                                fontSize: 18),
                          ),
                          onTap: () {
                            addData();

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Brandlist_Screen()));
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        alignment: AlignmentDirectional.topStart,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            text: "Price",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                            children: <TextSpan>[
                              TextSpan(
                                text: "*",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 55,
                        width: width,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: maincolor),

                          controller: Price,
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
                            hintText: "Price",
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
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        alignment: AlignmentDirectional.topStart,
                        child: const Text(
                          "Discount Price (Optional)",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 55,
                        width: width,
                        child: TextFormField(
                          style: TextStyle(color: maincolor),

                          keyboardType: TextInputType.number,
                          controller: DiscountPrice,
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
                            hintText: "Discount Price",
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
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        alignment: AlignmentDirectional.topStart,
                        child: const Text(
                          "Special Offers (Optional)",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 55,
                        width: width,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: SpecialOffer,
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
                            hintText: "Special Offers",
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
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        alignment: AlignmentDirectional.topStart,
                        child: const Text(
                          "Tags (Optional)",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 55,
                        width: width,
                        child: TextFormField(
                          style: TextStyle(color: maincolor),
                          controller: Tags,

                          keyboardType: TextInputType.text,
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
                            hintText: "Tags",
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
                    ],
                  ),
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(
                color: maincolor,
              ),
            ),
      bottomSheet: Container(
        height: height * 0.15,
        padding: EdgeInsets.all(10),
        // color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)),
                  height: 50,
                  width: width / 2 - 30,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        Title.clear();
                        //Category.clear();
                        selectedADCategory = "Category";
                        selectedADStock = "Select Stock";
                        selectedADBrand = "Select Brand";
                        Content.clear();
                        Stock.clear();
                        Brand.clear();
                        Price.clear();
                        DiscountPrice.clear();
                        SpecialOffer.clear();
                        Tags.clear();
                      });
                    },
                    child: const Text(
                      "Reset",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: maincolor,
                      borderRadius: BorderRadius.circular(10)),
                  height: 50,
                  width: width / 2 - 30,
                  child: TextButton(
                    onPressed: () {
                      if (Title.text.trim().isEmpty) {
                        print(Title.text);
                        _showfluttertoast(msg: 'Please Enter the Title');
                      } else if (selectedADCategory.trim().isEmpty) {
                        print(selectedADCategory);
                        _showfluttertoast(msg: 'Please Enter Category');
                      } else if (Price.text.trim().isEmpty) {
                        print(Price.text);
                        _showfluttertoast(msg: 'Please Enter Price');
                      } else {
                        (_formKey.currentState!.validate());
                        setState(() {
                          UpdateProfilAPIcall();
                        });
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             Myads_Screen()));
                      }

                      // if (Price.text.trim().isEmpty) {
                      //   print(Price.text);
                      //   _showfluttertoast(
                      //       msg: 'Please Enter Price');
                      // }else{
                      //   (_formKey.currentState!.validate());
                      //   // UpdateProfilAPIcall();
                      //   // Navigator.push(context, MaterialPageRoute(builder: (context)=>Myads_Screen()));
                      // }
                    },
                    child: const Text(
                      "Publish",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showfluttertoast({required String msg}) async {
    showToast(
      msg,
      context: context,
      textAlign: TextAlign.center,
      textStyle: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      fullWidth: false,
      animation: StyledToastAnimation.slideFromBottom,
      reverseAnimation: StyledToastAnimation.slideToBottom,
      position: StyledToastPosition.bottom,
      startOffset: const Offset(0, 3.0),
      backgroundColor: Colors.black.withOpacity(0.7),
      borderRadius: BorderRadius.circular(5),
      reverseEndOffset: const Offset(0, 3.0),
      duration: const Duration(seconds: 5),
      // Animation duration   animDuration * 2 <= duration
      animDuration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeInOut,
    );
  }

  UpdateProfilAPIcall() async {
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

      print(Header);

      var request = http.MultipartRequest('POST', Uri.parse(Createnewad_Api));
      print(Createnewad_Api);
      Map<String, String> headers = {
        "Authorization": "Bearer ${token.toString()}",
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      request.headers.addAll(headers);
      Map<String, String> sendData = {
        "title": Title.text.trim(),
        "category": selectedADCategory.trim(),
        "brand": selectedADBrand.trim(),
        "content": Content.text.trim(),
        "count": "1",
        "tags": Tags.text.trim(),
        "price": Price.text.trim(),
        "offer": SpecialOffer.text.trim(),
        "discountPrice": DiscountPrice.text.trim(),
        "stockid": selectedADStock.trim(),
        "author_id": user_id,
      };

      request.fields.addAll(sendData);
      if (imgFile != null) {
        print("image path ${imgFile!.path}");
        request.files.add(
            await http.MultipartFile.fromPath('product_image', imgFile!.path));
      }

      print("sendData ==> $sendData");
      http.StreamedResponse streamedResponse = await request.send();
      http.Response response = await http.Response.fromStream(streamedResponse);
      //final respStr = await response.stream.bytesToString();

      print("NewadResponse ${response.statusCode}");

      setState(() {
        Title.clear();
        selectedADCategory = "Category";
        selectedADStock = "Select Stock";
        selectedADBrand = "Select Brand";
        Content.clear();
        Stock.clear();
        Brand.clear();
        Price.clear();
        DiscountPrice.clear();
        SpecialOffer.clear();
        Tags.clear();
        imgFile = null;
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Myads_Screen()));

      setState(() {
        isReload = false;
      });
    } catch (e) {
      setState(() {
        isReload = false;
      });
      print("Exception in new ad=>" + e.toString());
      throw e;
    }
  }
}
