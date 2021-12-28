import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:percemobile/Components/Basic/cinzelAutoSizeText.dart';
import 'package:percemobile/Components/Basic/cinzelText.dart';
import 'package:percemobile/Components/bookImage.dart';
import 'package:percemobile/Components/perceButton.dart';
import 'package:percemobile/Components/perceDialog.dart';
import 'package:percemobile/Components/perceStarsSelect.dart';
import 'package:percemobile/Components/textFieldInput.dart';
import 'package:percemobile/Hive/boxes.dart';
import 'package:percemobile/Hive/transaction.dart';

// TODO: FIX TOO LONG NAME
class BookDetailsPage extends StatefulWidget {
  List<Widget> recommendedFriend = [];

  BookDetailsPage({Key key}) : super(key: key);

  @override
  _BookDetailsPageState createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  final double commentMaxHeight = 70;
  static var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var numOfComments = 0;
    LoggedUser loggedUser = Boxes.loggedUser().get("logged");
    StoredBook storedBook = Boxes.getStoredBooks().get(loggedUser.userName);
    BookCommented bookComments = Boxes.getCommentsForBook().get(storedBook.bookUrl);
    String comment = "";
    Size size = MediaQuery.of(context).size;
    double unit = size.height / 24;
    List<Widget> comments = [];
    var stars = PerceStarsSelect(
      width: 120,
      height: 24,
    );
    double starsRate = 0;
    numOfComments = 0;
    for (int i = 0; i < bookComments.userNames.length; ++i) {
      starsRate += bookComments.starsGiven[i];
      ++numOfComments;
      comments.add(
        Container(
          width: size.width,
          height: commentMaxHeight,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.black, width: 1),
              bottom: BorderSide(color: Colors.black, width: 1),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              CinzelText(
                displayText: bookComments.userNames[i] + ":",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 270,
                child: AutoSizeText(
                  bookComments.comments[i],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Cinzel',
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CinzelText(
                        displayText: bookComments.starsGiven[i].toString(),
                        fontSize: 16,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage("assets/images/star.png"))),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
    if (bookComments.userNames.length != 0) {
      starsRate /= bookComments.userNames.length;
      starsRate -= 1;
    } else {
      starsRate = -1;
    }
    List<Widget> starsList = [];
    for (int i = 0; i < 5; ++i) {
      if (i <= starsRate) {
        starsList.add(
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage("assets/images/star.png"))),
          ),
        );
      } else {
        starsList.add(
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage("assets/images/emptystar.png"))),
          ),
        );
      }
      starsList.add(SizedBox(
        width: 5,
      ));
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: size.width,
                decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage("assets/images/plain_background.jpg"))),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            BookImage(
                              imageUrl: storedBook.bookUrl,
                              height: 180,
                              width: 120,
                              marginLeft: 20,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 25,
                                ),
                                Row(
                                  children: starsList,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          width: unit,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 200,
                              child: CinzelText(
                                fontSize: 16,
                                displayText: storedBook.name,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 200,
                              child: CinzelText(
                                fontSize: 16,
                                displayText: storedBook.writer,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CinzelText(
                              displayText: storedBook.placeYear,
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            CinzelText(
                              displayText: "Broj strana: " + storedBook.pageNumber.toString(),
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                PerceButton(
                                  color1: Color(0xFF133069),
                                  color2: Color(0xFF133069),
                                  color3: Color(0xFF133069),
                                  text: 'PREPORUČI',
                                  fontSize: 12,
                                  function: () {
                                    showDialog(context: context, builder: (_) => PerceDialog());
                                  },
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                PerceButton(
                                  color1: Color(0xFF111F38),
                                  color2: Color(0xFF111F38),
                                  color3: Color(0xFF111F38),
                                  text: 'NAZAD',
                                  fontSize: 12,
                                  paddingV: 0,
                                  paddingH: 0,
                                  function: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 340,
                          width: size.width - 50,
                          child: CinzelAutoSizeText(
                            displayText: storedBook.details,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: size.width,
                color: Color(0xF0391D1D),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        height: 140,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFieldInput(
                              minLines: 2,
                              hintText: "Napiši komentar...",
                              charLimit: 70,
                              obscureText: false,
                              width: 200,
                              validator: (value) {
                                comment = value;
                                return null;
                              },
                            ),
                            SizedBox(width: 10,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                stars,
                                SizedBox(height: 10,),
                                PerceButton(
                                  color1: Color(0xFF136940),
                                  color2: Color(0xFF136940),
                                  color3: Color(0xFF136940),
                                  text: 'OCENI',
                                  fontSize: 16,
                                  function: () {
                                    if (_formKey.currentState.validate()) {
                                      bookComments.starsGiven.add(stars.clickedStarsCount());
                                      bookComments.userNames.add(loggedUser.userName);
                                      bookComments.comments.add(comment);
                                      final commentBox = Boxes.getCommentsForBook();
                                      commentBox.put(storedBook.bookUrl, bookComments);
                                      setState(() {_formKey = GlobalKey<FormState>(); });
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: numOfComments * commentMaxHeight,
                        width: size.width,
                        child: Column(
                          children: comments,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
