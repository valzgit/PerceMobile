import 'package:flutter/material.dart';
import 'package:percemobile/Components/Basic/robotoText.dart';
import 'package:percemobile/Components/perceButton.dart';
import 'package:percemobile/Components/perceHiperlink.dart';
import 'package:percemobile/Components/perceToggleButton.dart';
import 'package:percemobile/Components/textFieldInput.dart';
import 'package:percemobile/Hive/boxes.dart';
import 'package:percemobile/Hive/transaction.dart';

class RegistrationScreen extends StatelessWidget {
  String name;
  String lastName;
  String email;
  String phoneNumber;
  String userName;
  String password;
  bool buyer = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = 3;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage("assets/images/login_background.jpg"))),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                PerceToggleButton(
                  text1: 'KUPAC',
                  text2: 'PRODAVAC',
                  firstChoice: buyer,
                  function: () {
                    buyer = !buyer;
                  },
                ),
                SizedBox(
                  height: height,
                ),
                Container(
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RobotoText(
                        displayText: "Ime:",
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      TextFieldInput(
                        hintText: "Unesi ime",
                        obscureText: false,
                        width: 250,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Unesi ime";
                          }
                          name = value;
                          return null;
                        },
                      ),
                      SizedBox(width: 8,),
                    ],
                  ),
                ),
                SizedBox(
                  height: height,
                ),
                Container(
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RobotoText(
                        displayText: "Prezime:",
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      TextFieldInput(
                        hintText: "Unesi prezime",
                        obscureText: false,
                        width: 250,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Unesi prezime";
                          }
                          lastName = value;
                          return null;
                        },
                      ),
                      SizedBox(width: 8,),
                    ],
                  ),
                ),
                SizedBox(
                  height: height,
                ),
                Container(
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RobotoText(
                        displayText: "Adresa:",
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      TextFieldInput(
                        hintText: "Unesi adresu",
                        obscureText: false,
                        width: 250,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Unesi email adresu";
                          }
                          if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                            return "Adresa je u lošem formatu";
                          }
                          email = value;
                          return null;
                        },
                      ),
                      SizedBox(width: 8,),
                    ],
                  ),
                ),
                SizedBox(
                  height: height,
                ),
                Container(
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          RobotoText(
                            displayText: "Kontakt",
                          ),
                          RobotoText(
                            displayText: " telefon:",
                          )
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      TextFieldInput(
                        hintText: "Unesi kontakt telefon",
                        obscureText: false,
                        width: 250,
                        validator: (value) {
                          bool isNumeric = true;
                          if (value == null) {
                            isNumeric = false;
                          } else
                            isNumeric = double.parse(value, (e) => null) != null;
                          if (value.isEmpty) {
                            return "Unesi broj telefona";
                          }
                          if (value.isEmpty || !isNumeric) {
                            return "Broj telefona nije u dobrom formatu";
                          }
                          phoneNumber = value;
                          return null;
                        },
                      ),
                      SizedBox(width: 8,),
                    ],
                  ),
                ),
                SizedBox(
                  height: height,
                ),
                Container(
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          RobotoText(
                            displayText: "Korisničko",
                          ),
                          RobotoText(
                            displayText: "ime:",
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      TextFieldInput(
                        hintText: "Unesi korisničko ime",
                        obscureText: false,
                        width: 250,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Unesi korisničko ime";
                          }
                          final box = Boxes.getUsers();
                          if (box.containsKey(value)) return "Korisničko ime se već koristi...";
                          userName = value;
                          return null;
                        },
                      ),
                      SizedBox(width: 8,),
                    ],
                  ),
                ),
                SizedBox(
                  height: height,
                ),
                Container(
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RobotoText(
                        displayText: "Lozinka:",
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      TextFieldInput(
                        hintText: "Unesi lozinku",
                        obscureText: true,
                        width: 250,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Unesi lozinku";
                          }
                          if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)) {
                            return "Lozinka je u lošem formatu";
                          }
                          password = value;
                          return null;
                        },
                      ),
                      SizedBox(width: 8,),
                    ],
                  ),
                ),
                SizedBox(
                  height: height,
                ),
                PerceButton(
                  color1: Color(0xFF133069),
                  color2: Color(0xFF133069),
                  color3: Color(0xFF133069),
                  text: 'REGISTRUJ SE',
                  function: () {
                    if (_formKey.currentState.validate()) {
                      final user = User()
                        ..name = name
                        ..password = password
                        ..lastName = lastName
                        ..userName = userName
                        ..phoneNumber = phoneNumber
                        ..email = email
                        ..buyer = buyer;
                      Boxes.getUsers().put(userName, user);
                      LoggedUser loggedUserCopy = LoggedUser()
                        ..name = user.name
                        ..phoneNumber = user.phoneNumber
                        ..email = user.email
                        ..password = user.password
                        ..userName = user.userName
                        ..lastName = user.lastName
                        ..buyer = user.buyer;
                      Boxes.loggedUser().put("logged", loggedUserCopy);
                      Boxes.getUserBookRelations().put(
                          user.userName,
                          UserBookRelation()
                            ..username = user.userName
                            ..bookUrls = []);
                      if (loggedUserCopy.buyer)
                        Navigator.of(context).popAndPushNamed("/buyermain");
                      else
                        Navigator.of(context).pop();
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                PerceHyperlink(
                  text: "Imaš nalog? Prijavi se ovde!",
                  function: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
