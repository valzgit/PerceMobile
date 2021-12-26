import 'package:hive/hive.dart';
import 'package:percemobile/Hive/transaction.dart';

class Boxes {
  static Box<User> getUsers() => Hive.box<User>('users');
  static Box<LoggedUser> loggedUser() => Hive.box<LoggedUser>('loggedUser');
  static Box<Book> getBooks() => Hive.box<Book>('books');
  static Box<UserBookRelation> getUserBookRelations() => Hive.box<UserBookRelation>('userbookrelations');
  static Box<StoredBook> getStoredBooks() => Hive.box<StoredBook>('storedbooks');
  static Box<BookCommented> getCommentsForBook() => Hive.box<BookCommented>("bookcomments");
}