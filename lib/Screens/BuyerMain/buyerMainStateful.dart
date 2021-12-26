import 'package:flutter/material.dart';
import 'package:percemobile/Components/Basic/cinzelText.dart';
import 'package:percemobile/Components/bookclickableimage.dart';
import 'package:percemobile/Components/perceButton.dart';
import 'package:percemobile/Hive/boxes.dart';
import 'package:percemobile/Hive/transaction.dart';

class BuyerMainStateful extends StatefulWidget {
  const BuyerMainStateful({Key key}) : super(key: key);

  @override
  _BuyerMainStatefulState createState() => _BuyerMainStatefulState();
}

class _BuyerMainStatefulState extends State<BuyerMainStateful> {
  @override
  Widget build(BuildContext context) {
    LoggedUser loggedUser = Boxes.loggedUser().get("logged");
    UserBookRelation userBookRelation = Boxes.getUserBookRelations().get(loggedUser.userName);
    List<Widget> recommendedBooks = [];
    for (int i = 0; i < userBookRelation.bookUrls.length && i < 8; ++i) {
      if (i == 0) {
        recommendedBooks.add(BookClickableImage(
          imageUrl: userBookRelation.bookUrls[i],
          marginLeft: 80,
        ));
      } else {
        recommendedBooks.add(BookClickableImage(
          imageUrl: userBookRelation.bookUrls[i],
        ));
      }
    }
    List<Widget> allBooks = [];
    List<Widget> allPromotedBooks = [];
    int promotedCounter = 0;
    for (int i = 0; i < Boxes.getBooks().length && i < 8; ++i) {
      Book book = Boxes.getBooks().getAt(i);
      if (i == 0)
        allBooks.add(BookClickableImage(
          imageUrl: book.bookUrl,
          marginLeft: 80,
        ));
      else
        allBooks.add(BookClickableImage(imageUrl: book.bookUrl));
    }
    for (int i = 0; i < Boxes.getBooks().length && promotedCounter < 8; ++i) {
      Book book = Boxes.getBooks().getAt(i);
      if (book.promoted) {
        if (promotedCounter == 0) {
          allPromotedBooks.add(BookClickableImage(
            imageUrl: book.bookUrl,
            marginLeft: 80,
          ));
        } else {
          allPromotedBooks.add(BookClickableImage(
            imageUrl: book.bookUrl,
          ));
        }
        ++promotedCounter;
      }
    }
    allBooks.add(InkWell(
      child: Container(
        width: 80,
        height: 70,
        decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage("assets/images/arrow.png"))),
      ),
      onTap: () {
        Navigator.of(context).pushNamed("/allbooks");
      },
    ));

    Size size = MediaQuery.of(context).size;
    double unit = size.height / 12;
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            //placebo function
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
        decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage("assets/images/novi_main_screen.jpg"))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: unit / 2,
            ),
            Row(
              children: [
                SizedBox(
                  width: 70,
                ),
                CinzelText(
                  displayText: "PREPORUČENE KNJIGE",
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            SizedBox(
              height: 35,
            ),
            Row(
              children: recommendedBooks,
            ),
            SizedBox(
              height: unit / 2,
            ),
            Row(
              children: [
                SizedBox(
                  width: 70,
                ),
                CinzelText(
                  displayText: "KNJIGE NA PROMOCIJI",
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            SizedBox(
              height: 35,
            ),
            Row(
              children: allPromotedBooks,
            ),
            SizedBox(
              height: unit / 2,
            ),
            Row(
              children: [
                SizedBox(
                  width: 70,
                ),
                CinzelText(
                  displayText: "SVE KNJIGE",
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            SizedBox(
              height: 35,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: allBooks,
              ),
            )
          ],
        ),
      ),
    );
  }
}
