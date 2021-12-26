import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percemobile/Components/Basic/cinzelAutoSizeText.dart';
import 'package:percemobile/Components/Basic/cinzelText.dart';
import 'package:percemobile/Components/bookImage.dart';
import 'package:percemobile/Components/perceButton.dart';
import 'package:percemobile/Components/perceDialog.dart';
import 'package:percemobile/Components/perceStarsSelect.dart';
import 'package:percemobile/Components/textFieldInput.dart';
import 'package:percemobile/Hive/boxes.dart';
import 'package:percemobile/Hive/transaction.dart';

class BookDetailsPage extends StatefulWidget {
  List<Widget> recommendedFriend = [];
  BookDetailsPage({Key key}) : super(key: key);

  @override
  _BookDetailsPageState createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  @override
  Widget build(BuildContext context) {
    LoggedUser loggedUser = Boxes.loggedUser().get("logged");
    StoredBook storedBook = Boxes.getStoredBooks().get(loggedUser.userName);
    BookCommented bookComments = Boxes.getCommentsForBook().get(storedBook.bookUrl);
    final _formKey = GlobalKey<FormState>();
    String comment = "";
    Size size = MediaQuery.of(context).size;
    double unit = size.height / 12;
    List<Widget> comments = [];
    var stars = PerceStarsSelect(
      width: 150,
      height: 30,
    );
    double starsRate = 0;
    for (int i = 0; i < bookComments.userNames.length; ++i) {
      starsRate += bookComments.starsGiven[i];
      comments.add(Container(
        width: size.width * 3.0 / 5,
        height: 100,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.black, width: 1),
            bottom: BorderSide(color: Colors.black, width: 1),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 40,
            ),
            CinzelText(
              displayText: bookComments.userNames[i] + ":",
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              width: 10,
            ),
            CinzelText(
              displayText: bookComments.comments[i],
              fontSize: 20,
            ),
            Expanded(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CinzelText(
                      displayText: bookComments.starsGiven[i].toString(),
                      fontSize: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage("assets/images/star.png"))),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ));
    }
    if (bookComments.userNames.length != 0) {
      starsRate /= bookComments.userNames.length;
      starsRate -= 1;
    }
    else{
      starsRate = -1;
    }
    List<Widget> starsList = [];
    for (int i = 0; i < 5; ++i) {
      if (i <= starsRate) {
        starsList.add(
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage("assets/images/star.png"))),
          ),
        );
      } else {
        starsList.add(
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage("assets/images/emptystar.png"))),
          ),
        );
      }
      starsList.add(SizedBox(
        width: 5,
      ));
    }
    return Scaffold(
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
            width: 35,
          )
        ],
      ),
      body: Container(
        width: size.width,
        decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage("assets/images/plain_background.jpg"))),
        child: Column(
          children: [
            Container(
              height: 70,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    BookImage(
                      imageUrl: storedBook.bookUrl,
                      height: 455,
                      width: 300,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 70,
                        ),
                        Row(
                          children: starsList,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: unit * 2.5,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CinzelText(
                      displayText: storedBook.name,
                      color: Colors.black,
                      fontSize: 45,
                    ),
                    Row(
                      children: [
                        CinzelText(
                          displayText: storedBook.writer,
                          color: Colors.black,
                          fontSize: 45,
                        ),
                        SizedBox(
                          width: 120,
                        ),
                        CinzelText(
                          displayText: storedBook.placeYear,
                          color: Colors.black,
                          fontSize: 35,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: 320,
                      width: 1000,
                      child: CinzelAutoSizeText(
                        displayText: storedBook.details,
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        CinzelText(
                          displayText: "Broj strana: " + storedBook.pageNumber.toString(),
                          fontSize: 30,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 340,
                        ),
                        PerceButton(
                          color1: Color(0xFF111F38),
                          color2: Color(0xFF111F38),
                          color3: Color(0xFF111F38),
                          text: 'NAZAD',
                          function: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        PerceButton(
                          color1: Color(0xFF133069),
                          color2: Color(0xFF133069),
                          color3: Color(0xFF133069),
                          text: 'PREPORUČI',
                          function: () {
                            showDialog(
                              context: context,
                              builder: (_) => PerceDialog()
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Form(
              key: _formKey,
              child: Expanded(
                child: Container(
                  width: size.width,
                  color: Color(0xCC391D1D),
                  child: Row(
                    children: [
                      Container(
                        width: size.width * 3.0 / 5,
                        decoration: BoxDecoration(border: Border(right: BorderSide(color: Colors.black, width: 4))),
                        child: SingleChildScrollView(
                          child: Column(
                            children: comments,
                          ),
                        ),
                      ),
                      Container(
                        width: size.width * 2.0 / 5,
                        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                          SizedBox(
                            height: 20,
                          ),
                          TextFieldInput(
                            minLines: 6,
                            hintText: "Napiši komentar...",
                            charLimit: 70,
                            obscureText: false,
                            width: size.width * 1.5 / 5,
                            validator: (value) {
                              comment = value;
                              return null;
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              stars,
                              SizedBox(
                                width: 30,
                              ),
                              PerceButton(
                                color1: Color(0xFF136940),
                                color2: Color(0xFF136940),
                                color3: Color(0xFF136940),
                                text: 'OCENI',
                                function: () {
                                  if (_formKey.currentState.validate()) {
                                    bookComments.starsGiven.add(stars.clickedStarsCount());
                                    bookComments.userNames.add(loggedUser.userName);
                                    bookComments.comments.add(comment);
                                    final commentBox = Boxes.getCommentsForBook();
                                    commentBox.put(storedBook.bookUrl, bookComments);
                                    setState(() {});
                                  }
                                },
                              ),
                            ],
                          )
                        ]),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
