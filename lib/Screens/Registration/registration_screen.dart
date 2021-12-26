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

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    Size size = MediaQuery.of(context).size;
    double unit = size.width / 12;
    double height = 10;
    return Scaffold(
      body: Container(
        width: size.width,
        decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage("assets/images/login_background.jpg"))),
        child: Form(
          key: _formKey,
          child: Row(
            children: [
              SizedBox(
                width: 3 * unit,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                    width: 5 * unit,
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
                          width: 5 * unit / 2,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Unesi ime";
                            }
                            name = value;
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height,
                  ),
                  Container(
                    width: 5 * unit,
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
                          width: 5 * unit / 2,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Unesi prezime";
                            }
                            lastName = value;
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height,
                  ),
                  Container(
                    width: 5 * unit,
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
                          width: 5 * unit / 2,
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
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height,
                  ),
                  Container(
                    width: 5 * unit,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RobotoText(
                          displayText: "Kontakt telefon:",
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        TextFieldInput(
                          hintText: "Unesi kontakt telefon",
                          obscureText: false,
                          width: 5 * unit / 2,
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
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height,
                  ),
                  Container(
                    width: 5 * unit,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RobotoText(
                          displayText: "Korisničko ime:",
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        TextFieldInput(
                          hintText: "Unesi korisničko ime",
                          obscureText: false,
                          width: 5 * unit / 2,
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
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height,
                  ),
                  Container(
                    width: 5 * unit,
                    child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      RobotoText(
                        displayText: "Lozinka:",
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      TextFieldInput(
                        hintText: "Unesi lozinku",
                        obscureText: true,
                        width: 5 * unit / 2,
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
                      )
                    ]),
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
                          Navigator.of(context).popAndPushNamed("/allbooksprodavac");
                      }
                    },
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  PerceHyperlink(
                    text: "Imaš nalog? Prijavi se ovde!",
                    function: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(
                    height: 60,
                  ),
                ],
              ),
              SizedBox(
                width: 4 * unit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
