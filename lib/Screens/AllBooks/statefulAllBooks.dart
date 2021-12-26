import 'package:flutter/material.dart';
import 'package:percemobile/Components/Basic/cinzelText.dart';
import 'package:percemobile/Components/allBooksBook.dart';
import 'package:percemobile/Components/perceButton.dart';
import 'package:percemobile/Components/perceCheckBox.dart';
import 'package:percemobile/Components/perceDropdownButton.dart';
import 'package:percemobile/Components/textFieldInput.dart';
import 'package:percemobile/Hive/boxes.dart';
import 'package:percemobile/Hive/transaction.dart';

class StatefulAllBooksScreen extends StatefulWidget {
  const StatefulAllBooksScreen({Key key}) : super(key: key);

  @override
  _StatefulAllBooksScreenState createState() => _StatefulAllBooksScreenState();
}

class _StatefulAllBooksScreenState extends State<StatefulAllBooksScreen> {
  bool promotion = false;
  String searchParam = "";
  final _formKey = GlobalKey<FormState>();
  String pickedGenre = "Svaki";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> allBooks = [];
    for (int i = 0; i < Boxes.getBooks().length; ++i) {
      Book book = Boxes.getBooks().getAt(i);
      if ((pickedGenre == "Svaki" || pickedGenre == book.genre) &&
          (promotion == false || book.promoted) &&
          (book.name.toLowerCase().contains(searchParam.toLowerCase()) || book.writer.toLowerCase().contains(searchParam.toLowerCase())))
        allBooks.add(
          AllBooksBook(
            key: UniqueKey(),
            imageUrl: book.bookUrl,
            bookName: book.name,
            writerName: book.writer,
            paddingH: 15,
            paddingV: 0,
            buttonFontSize: 16,
          ),
        );
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed("/buyermain");
          },
          child: Container(
            width: 230,
            child: Row(
              children: [
                CinzelText(
                  displayText: "Perce",
                  fontSize: 40,
                ),
                SizedBox(
                  width: 5,
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
                        PerceButton(
                          color1: Color(0xFF0E1926),
                          color2: Color(0xFF0E1926),
                          color3: Color(0xFF0E1926),
                          text: 'NAPUSTI NALOG',
                          function: () {
                            Navigator.of(context).popAndPushNamed("/");
                          },
                        ),
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
            width: 10,
          )
        ],
      ),
      body: Container(
        width: size.width,
        decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage("assets/images/plain_background.jpg"))),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      CinzelText(
                        displayText: "SVE KNJIGE",
                        fontSize: 30,
                        color: Color(0xFF000000),
                      ),
                    ],
                  ),
                  Container(
                    width: size.width,
                    height: 4,
                    color: Color(0xFF000000),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      CinzelText(
                        displayText: "PRETRAŽI:",
                        fontSize: 16,
                        color: Color(0xFF000000),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      TextFieldInput(
                        hintText: "Unesi knjigu ili pisca",
                        obscureText: false,
                        width: 220,
                        validator: (value) {
                          setState(() {
                            if (value == null)
                              searchParam = "";
                            else
                              searchParam = value;
                          });
                          return null;
                        },
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          _formKey.currentState.validate();
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage("assets/images/lupa.png"))),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      CinzelText(
                        displayText: "PROMOCIJA:",
                        fontSize: 16,
                        color: Color(0xFF000000),
                      ),
                      PerceCheckBox(
                        function: () {
                          setState(() {
                            promotion = !promotion;
                          });
                        },
                      ),
                      CinzelText(
                        displayText: "ŽANR:",
                        fontSize: 16,
                        color: Color(0xFF000000),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      PerceDropdownButton(
                        function: (newValue) {
                          pickedGenre = newValue;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: size.width,
              height: 2,
              color: Color(0xFF000000),
            ),
            Container(
              height: size.height - 257,
              child: SingleChildScrollView(
                child: Column(
                  children: allBooks,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
