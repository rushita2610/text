import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../ColorConstant/ColorConstant.dart';

class ReviewProduct_Screen extends StatefulWidget {
  const ReviewProduct_Screen({Key? key}) : super(key: key);

  @override
  State<ReviewProduct_Screen> createState() => _ReviewProduct_ScreenState();
}

class _ReviewProduct_ScreenState extends State<ReviewProduct_Screen> {
  bool isReload = false;

  TextEditingController Name = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController Reviewtitle = TextEditingController();
  TextEditingController Reviewcontent = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      backgroundColor: CupertinoColors.systemGrey5,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: maincolor,
          ),
        ),
        title: const Text(
          "RATING",
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
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: const Text(
                        "Name",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 55,
                      width: width,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: Name,
                        style: const TextStyle(color: maincolor),
                        //readOnly: true,
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
                          hintText: "Name",
                          hintStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: CupertinoColors.systemGrey2),
                          labelStyle: const TextStyle(
                              color: CupertinoColors.systemGrey2, fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: const Text(
                        "Email",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 55,
                      width: width,
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: Email,
                        style: const TextStyle(color: maincolor),
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
                              color: CupertinoColors.systemGrey2, fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: const Text(
                        "Review Title",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 55,
                      width: width,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: Reviewtitle,
                        style: const TextStyle(color: maincolor),
                        //readOnly: true,
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
                          hintText: "Review Title",
                          hintStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: CupertinoColors.systemGrey2),
                          labelStyle: const TextStyle(
                              color: CupertinoColors.systemGrey2, fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: const Text(
                        "Review Content",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 100,
                      width: width,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: Reviewcontent,
                        style: const TextStyle(color: maincolor),
                        maxLines: 3,
                        //readOnly: true,
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
                          hintText: "Review Content",
                          hintStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: CupertinoColors.systemGrey2),
                          labelStyle: const TextStyle(
                              color: CupertinoColors.systemGrey2, fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: const Text(
                        "Rating",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: RatingBar.builder(
                        itemSize: 35,
                        initialRating: 5,
                        minRating: 1,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 0.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          size: 10,
                          color: maincolor,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                        width: width / 1 - 100,
                        height: 55,
                        decoration: BoxDecoration(
                            color: maincolor,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Submit",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            )))
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
}
