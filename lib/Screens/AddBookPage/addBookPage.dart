import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percemobile/Components/Basic/cinzelText.dart';
import 'package:percemobile/Components/Basic/robotoText.dart';
import 'package:percemobile/Components/bookImage.dart';
import 'package:percemobile/Components/perceButton.dart';
import 'package:percemobile/Components/perceCheckBox.dart';
import 'package:percemobile/Components/perceDropdownButton.dart';
import 'package:percemobile/Components/textFieldInput.dart';
import 'package:percemobile/Hive/boxes.dart';
import 'package:percemobile/Hive/transaction.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({Key key}) : super(key: key);

  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final _formKey = GlobalKey<FormState>();
  String bookName = "";
  String bookWriter = "";
  String cityYear = "";
  bool promotion = false;
  String genre = "";
  int numberOfPages = 250;
  String details = "";
  String bookUrl = "blank_book_cover.png";
  String pickedGenre = "Svaki";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double unit = size.height / 12;
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            width: 230,
            child: Row(
              children: [
                CinzelText(
                  displayText: "Perce",
                  fontSize: 62,
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: 26,
                  height: 45,
                  decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage("assets/images/perce.png"))),
                ),
              ],
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF391D1D),
        actions: [
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  actions: [
                    Column(
                      children: [
                        SizedBox(height: 7),
                        PerceButton(
                          color1: Color(0xFF136945),
                          color2: Color(0xFF136945),
                          color3: Color(0xFF136945),
                          text: 'IZMENI NALOG',
                          function: () {
                            Navigator.of(context).popAndPushNamed("/changeuserdata");
                          },
                        ),
                        SizedBox(height: 12),
                        SizedBox(height: 7)
                      ],
                    ),
                  ],
                  backgroundColor: Color(0xFFF9F6F0),
                ),
              );
            },
            child: Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage("assets/images/profile.png"))),
            ),
          ),
          SizedBox(
            width: 35,
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: Container(
          width: size.width,
          decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage("assets/images/plain_background.jpg"))),
          child: Column(children: [
            Container(
              height: size.height - 200,
              child: Row(
                children: [
                  Container(
                    width: size.width * 3.0 / 4.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 200,
                            ),
                            RobotoText(
                              displayText: "Naziv:",
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 42,
                            ),
                            TextFieldInput(
                              hintText: "Unesi naziv knjige",
                              obscureText: false,
                              width: 5 * unit,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Unesi naziv knjige";
                                }
                                bookName = value;
                                return null;
                              },
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            RobotoText(
                              displayText: "Promocija:",
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            PerceCheckBox(
                              function: () {
                                promotion = !promotion;
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 200,
                            ),
                            RobotoText(
                              displayText: "Pisac:",
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 42,
                            ),
                            TextFieldInput(
                              hintText: "Unesi naziv pisca",
                              obscureText: false,
                              width: 5 * unit,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Unesi naziv pisca";
                                }
                                bookWriter = value;
                                return null;
                              },
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            RobotoText(
                              displayText: "Žanr:",
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 106,
                            ),
                            PerceDropdownButton(
                              function: (newValue) {
                                pickedGenre = newValue;
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 200,
                            ),
                            RobotoText(
                              displayText: "Izdanje:",
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            TextFieldInput(
                              hintText: "Unesi grad i godinu",
                              obscureText: false,
                              width: 5 * unit,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Unesi grad i godinu";
                                }
                                cityYear = value;
                                return null;
                              },
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            RobotoText(
                              displayText: "Broj strana:",
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            TextFieldInput(
                              hintText: "Broj",
                              obscureText: false,
                              width: 3 * unit / 2,
                              validator: (value) {
                                bool isNumeric = true;
                                if (value == null) {
                                  isNumeric = false;
                                } else
                                  isNumeric = double.parse(value, (e) => null) != null;
                                if (value.isEmpty) {
                                  return "Unesi broj strana";
                                }
                                if (value.isEmpty || !isNumeric) {
                                  return "Broj strana nije u dobrom formatu";
                                }
                                numberOfPages = int.parse(value);
                                return null;
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 60,
                            ),
                            RobotoText(
                              displayText: "Opis:",
                              color: Colors.black,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 60,
                            ),
                            TextFieldInput(
                              minLines: 14,
                              hintText: "Dodaj opis...",
                              obscureText: false,
                              width: size.width * 3 / 4 - 150,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Unesi opis knjige";
                                }
                                details = value;
                                return null;
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BookImage(
                        imageUrl: bookUrl,
                        height: 455,
                        width: 300,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(children: [
                        SizedBox(
                          width: 80,
                        ),
                        PerceButton(
                          function: () {
                            var rng = new Random();
                            bookUrl = "proces" + (rng.nextInt(3) + 1).toString() + ".jpg";
                            setState(() {});
                          },
                          text: "DODAJ SLIKU",
                          color1: Color(0xFFB4670D),
                          color2: Color(0xFFB4670D),
                          color3: Color(0xFFB4670D),
                        ),
                      ]),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PerceButton(
                      color1: Color(0xFF0DB41D),
                      color2: Color(0xFF0DB41D),
                      color3: Color(0xFF0DB41D),
                      text: 'DODAJ KNJIGU',
                      function: () {
                        if (_formKey.currentState.validate()) {
                          final shelf = Boxes.getBooks();
                          Book newBook = Book()
                            ..name = bookName
                            ..writer = bookWriter
                            ..bookUrl = bookUrl
                            ..promoted = promotion
                            ..placeYear = cityYear
                            ..pageNumber = numberOfPages
                            ..genre = pickedGenre
                            ..details = details;
                          shelf.put(newBook.bookUrl, newBook);
                          final commentBox = Boxes.getCommentsForBook();
                          var bookCommentsEmpty = BookCommented()
                            ..bookUrl = newBook.bookUrl
                            ..comments = []
                            ..starsGiven = []
                            ..userNames = [];
                          commentBox.put(bookCommentsEmpty.bookUrl, bookCommentsEmpty);
                          Navigator.of(context).popAndPushNamed("/allbooksprodavac");
                        }
                      },
                    ),
                    SizedBox(
                      width: 200,
                    ),
                    PerceButton(
                      color1: Color(0xFF0E1926),
                      color2: Color(0xFF0E1926),
                      color3: Color(0xFF0E1926),
                      text: 'NAZAD',
                      function: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
