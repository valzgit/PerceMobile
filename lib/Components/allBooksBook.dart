import 'package:flutter/material.dart';
import 'package:percemobile/Components/Basic/cinzelText.dart';
import 'package:percemobile/Components/bookclickableimage.dart';
import 'package:percemobile/Components/perceButton.dart';
import 'package:percemobile/Hive/boxes.dart';
import 'package:percemobile/Hive/transaction.dart';

class AllBooksBook extends StatelessWidget {
  final String imageUrl;
  final String writerName;
  final String bookName;

  const AllBooksBook({Key key, this.imageUrl, this.bookName, this.writerName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 250,
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black))),
      child: Row(
        children: [
          BookClickableImage(
            imageUrl: imageUrl,
            height: 200,
            width: 140,
          ),
          SizedBox(
            width: 60,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CinzelText(
                fontSize: 32,
                displayText: bookName,
                color: Colors.black,
              ),
              SizedBox(
                height: 35,
              ),
              CinzelText(
                fontSize: 32,
                displayText: writerName,
                color: Colors.black,
              )
            ],
          ),
          Spacer(),
          PerceButton(
            text: "DETALJI KNJIGE",
            function: (){
              Book book = Boxes.getBooks().get(imageUrl);
              LoggedUser loggedUser = Boxes.loggedUser().get("logged");
              StoredBook storedBook = StoredBook()
                ..promoted = book.promoted
                ..bookUrl = book.bookUrl
                ..writer = book.writer
                ..name = book.name
                ..pageNumber = book.pageNumber
                ..details = book.details
                ..genre = book.genre
                ..placeYear = book.placeYear;
              Boxes.getStoredBooks().put(loggedUser.userName, storedBook);
              Navigator.of(context).pushNamed("/storedbook");
            },
            color1: Color(0xFF133069),
            color2: Color(0xFF133069),
            color3: Color(0xFF133069),
          ),
         SizedBox(
           width: 65,
         )
        ],
      ),
    );
  }
}
