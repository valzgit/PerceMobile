import 'package:flutter/material.dart';
import 'package:percemobile/Hive/boxes.dart';
import 'package:percemobile/Hive/transaction.dart';

class BookClickableImage extends StatelessWidget {
  final String imageUrl;
  final double marginLeft;
  final double height;
  final double width;

  const BookClickableImage({Key key, this.imageUrl, this.marginLeft, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: marginLeft == null ? 80.00 : marginLeft),
        width: width == null ? 120 : width,
        height: height == null ? 175 : height,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/images/" + imageUrl),
          ),
        ),
      ),
      onTap: () {
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
    );
  }
}
