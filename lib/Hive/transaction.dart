import 'package:hive/hive.dart';

part 'transaction.g.dart';

@HiveType(typeId:0)
class User extends HiveObject{
  @HiveField(0)
  String name;

  @HiveField(1)
  String lastName;

  @HiveField(2)
  String email;

  @HiveField(3)
  String phoneNumber;

  @HiveField(4)
  String userName;

  @HiveField(5)
  String password;

  @HiveField(6)
  bool buyer;
}

@HiveType(typeId:1)
class LoggedUser extends HiveObject{
  @HiveField(0)
  String name;

  @HiveField(1)
  String lastName;

  @HiveField(2)
  String email;

  @HiveField(3)
  String phoneNumber;

  @HiveField(4)
  String userName;

  @HiveField(5)
  String password;

  @HiveField(6)
  bool buyer;
}

@HiveType(typeId:2)
class Book extends HiveObject{
  @HiveField(0)
  String name;

  @HiveField(1)
  String writer;

  @HiveField(2)
  String bookUrl;

  @HiveField(3)
  bool promoted;

  @HiveField(4)
  String details;

  @HiveField(5)
  int pageNumber;

  @HiveField(6)
  String placeYear;

  @HiveField(7)
  String genre;
}

@HiveType(typeId:3)
class UserBookRelation extends HiveObject{
  @HiveField(0)
  String username;
  @HiveField(1)
  List<String> bookUrls;
}

@HiveType(typeId:4)
class StoredBook extends HiveObject{
  @HiveField(0)
  String name;

  @HiveField(1)
  String writer;

  @HiveField(2)
  String bookUrl;

  @HiveField(3)
  bool promoted;

  @HiveField(4)
  String details;

  @HiveField(5)
  int pageNumber;

  @HiveField(6)
  String placeYear;

  @HiveField(7)
  String genre;
}

@HiveType(typeId:5)
class BookCommented extends HiveObject{
  @HiveField(0)
  String bookUrl;

  @HiveField(1)
  List<String> userNames;

  @HiveField(2)
  List<String> comments;

  @HiveField(3)
  List<int> starsGiven;
}