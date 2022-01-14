import 'package:flutter/material.dart';
import 'package:percemobile/Components/Basic/robotoText.dart';
import 'package:percemobile/Components/perceButton.dart';
import 'package:percemobile/Components/perceHiperlink.dart';
import 'package:percemobile/Components/textFieldInput.dart';
import 'package:percemobile/Hive/boxes.dart';
import 'package:percemobile/Hive/transaction.dart';

class LogInScreen extends StatelessWidget {
  User loggedUser;
  bool checkPassword = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: size.width,
        decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage("assets/images/login_background.jpg"))),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 48,
                        ),
                        RobotoText(
                          displayText: "Korisničko ime:",
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFieldInput(
                          hintText: "Unesi korisničko ime",
                          obscureText: false,
                          width: size.width - size.width/4,
                          validator: (value) {
                            if (value.isEmpty) {
                              checkPassword = false;
                              return "Unesi korisničko ime";
                            }
                            final box = Boxes.getUsers();
                            if (!box.containsKey(value)) {
                              checkPassword = false;
                              return "Korisnik sa datim imenom ne postoji!";
                            }
                            loggedUser = box.get(value);
                            return null;
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 48,
                        ),
                        RobotoText(
                          displayText: "Lozinka:",
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFieldInput(
                          hintText: "Unesi lozinku",
                          obscureText: true,
                          width: size.width - size.width/4,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Unesi lozinku";
                            }
                            if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)) {
                              return "Lozinka je u lošem formatu";
                            }
                            if (checkPassword == false) return null;
                            if (loggedUser == null) {
                              return "Password se nije dohvatio ( los redosled zvanja funkcije validate() )!";
                            }
                            if (loggedUser.password != value) return "Pogrešna lozinka";
                            return null;
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              PerceButton(
                color1: Color(0xFF133069),
                color2: Color(0xFF133069),
                color3: Color(0xFF133069),
                text: 'PRIJAVI SE',
                function: () {
                  if (_formKey.currentState.validate()) {
                    final loggedUserBox = Boxes.loggedUser();
                    LoggedUser loggedUserCopy = LoggedUser()
                      ..name = loggedUser.name
                      ..phoneNumber = loggedUser.phoneNumber
                      ..email = loggedUser.email
                      ..password = loggedUser.password
                      ..userName = loggedUser.userName
                      ..lastName = loggedUser.lastName
                      ..buyer = loggedUser.buyer;
                    loggedUserBox.put("logged", loggedUserCopy);
                    // TODO : Fix username and password being saved when coming back to login screen
                    if(loggedUserCopy.buyer==true)
                      Navigator.of(context).pushNamed("/buyermain");
                    else{

                    }
                  }
                },
              ),
              SizedBox(
                height: 120,
              ),
              PerceHyperlink(
                text: "Nemaš nalog? Registruj se ovde!",
                function: () {
                  Navigator.of(context).pushNamed("/registration");
                },
              ),
              SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
