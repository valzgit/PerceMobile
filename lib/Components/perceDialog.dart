import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percemobile/Components/Basic/cinzelText.dart';
import 'package:percemobile/Components/perceButton.dart';
import 'package:percemobile/Components/perceCheckBox.dart';
import 'package:percemobile/Components/textFieldInput.dart';
import 'package:percemobile/Hive/boxes.dart';
import 'package:percemobile/Hive/transaction.dart';

class PerceDialog extends StatefulWidget {
  const PerceDialog({Key key}) : super(key: key);

  @override
  _PerceDialogState createState() => _PerceDialogState();
}

class _PerceDialogState extends State<PerceDialog> {
  List<Widget> recommendedFriend = [];
  List<String> checkedRecommendedFriend = [];
  LoggedUser loggedUser = Boxes.loggedUser().get("logged");
  final _formPopupKey = GlobalKey<FormState>();
  String userNameSearched = "";

  @override
  Widget build(BuildContext context) {
    StoredBook storedBook = Boxes.getStoredBooks().get(loggedUser.userName);
    return AlertDialog(
      actions: [
        Column(
          children: [
            Form(
              key: _formPopupKey,
              child: Row(
                children: [
                  TextFieldInput(
                    hintText: "Korisničko ime",
                    obscureText: false,
                    width: 300,
                    validator: (value) {
                      userNameSearched = value;
                      return null;
                    },
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      final box = Boxes.getUsers();
                      if (_formPopupKey.currentState.validate()) {
                        int limit = 4;
                        recommendedFriend = [];
                        checkedRecommendedFriend = [];
                        for (int i = 0; i < box.length && limit > 0; ++i) {
                          if (box.getAt(i).userName.toLowerCase().contains(userNameSearched.toLowerCase())) {
                            --limit;
                            recommendedFriend.add(
                              Row(
                                children: [
                                  PerceCheckBox(
                                    function: () {
                                      checkedRecommendedFriend.add(box.getAt(i).userName);
                                    },
                                  ),
                                  CinzelText(
                                    displayText: box.getAt(i).userName.toString(),
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            );
                            setState(() {});
                          }
                        }
                      }
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage("assets/images/lupa.png"))),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  height: 170,
                  width: 350,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: recommendedFriend,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                PerceButton(
                  color1: Color(0xFF133069),
                  color2: Color(0xFF133069),
                  color3: Color(0xFF133069),
                  text: 'PREPORUČI',
                  function: () {
                    for(int i=0;i<checkedRecommendedFriend.length;++i){
                      UserBookRelation userBookRelation = Boxes.getUserBookRelations().get(checkedRecommendedFriend[i]);
                      bool alreadyRecommended = false;
                      for(int j=0; j< userBookRelation.bookUrls.length;++j){
                        if(userBookRelation.bookUrls[j]==storedBook.bookUrl){
                          alreadyRecommended = true;
                          break;
                        }
                      }
                      if(!alreadyRecommended){
                        userBookRelation.bookUrls.add(storedBook.bookUrl);
                        Boxes.getUserBookRelations().put(checkedRecommendedFriend[i], userBookRelation);
                      }
                    }
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(width: 12),
                PerceButton(
                  color1: Color(0xFF0E1926),
                  color2: Color(0xFF0E1926),
                  color3: Color(0xFF0E1926),
                  text: 'NAZAD',
                  function: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(height: 7)
              ],
            ),
          ],
        ),
      ],
      backgroundColor: Color(0xFFF9F6F0),
    );
  }
}
