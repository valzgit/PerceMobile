import 'package:flutter/material.dart';
import 'package:percemobile/Components/Basic/robotoText.dart';
import 'package:percemobile/Components/perceButton.dart';
import 'package:percemobile/Components/textFieldInput.dart';
import 'package:percemobile/Hive/boxes.dart';
import 'package:percemobile/Hive/transaction.dart';

class EditUserDataScreen extends StatelessWidget {
  static var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    LoggedUser loggedUser = Boxes.loggedUser().get("logged");
    Size size = MediaQuery.of(context).size;
    double height = 10;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit:BoxFit.cover,
                image: AssetImage("assets/images/novi_main_screen.jpg")
            ),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 110,
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
                        initalValue: loggedUser==null?"":loggedUser.name,
                        width: 250,
                        validator: (value){
                          if(value.isEmpty){
                            return "Unesi ime";
                          }
                          loggedUser.name = value;
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
                        initalValue: loggedUser==null?"":loggedUser.lastName,
                        validator: (value){
                          if(value.isEmpty){
                            return "Unesi prezime";
                          }
                          loggedUser.lastName = value;
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
                        initalValue: loggedUser==null?"":loggedUser.email,
                        validator: (value){
                          if(value.isEmpty){
                            return "Unesi email adresu";
                          }
                          if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
                            return "Adresa je u lošem formatu";
                          }
                          loggedUser.email = value;
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
                            displayText: "telefon:",
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      TextFieldInput(
                        hintText: "Unesi kontakt telefon",
                        obscureText: false,
                        width: 250,
                        initalValue: loggedUser==null?"":loggedUser.phoneNumber,
                        validator: (value){
                          bool isNumeric = true;
                          if(value == null) {
                            isNumeric = false;
                          }
                          else isNumeric = double.parse(value, (e) => null) != null;
                          if(value.isEmpty){
                            return "Unesi broj telefona";
                          }
                          if(value.isEmpty || !isNumeric){
                            return "Broj telefona nije u dobrom formatu";
                          }
                          loggedUser.phoneNumber = value;
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
                          initalValue: loggedUser==null?"":loggedUser.password,
                          validator: (value){
                            if(value.isEmpty){
                              return "Unesi lozinku";
                            }
                            if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)){
                              return "Lozinka je u lošem formatu";
                            }
                            loggedUser.password = value;
                            return null;
                          },
                        ),
                        SizedBox(width: 8,),
                      ]
                  ),
                ),
                SizedBox(
                  height: height*4,
                ),
                PerceButton(
                  color1: Color(0xFF133069),
                  color2: Color(0xFF133069),
                  color3: Color(0xFF133069),
                  text: 'SAČUVAJ IZMENE',
                  function: (){
                    if(_formKey.currentState.validate()){
                      String userName = loggedUser.userName;
                      final loggedUserBox = Boxes.loggedUser();
                      final userBox = Boxes.getUsers();
                      User user = User()
                        ..name = loggedUser.name
                        ..phoneNumber = loggedUser.phoneNumber
                        ..email = loggedUser.email
                        ..password = loggedUser.password
                        ..userName = loggedUser.userName
                        ..lastName = loggedUser.lastName
                        ..buyer = loggedUser.buyer;
                      userBox.put(userName, user);
                      loggedUserBox.put("logged", loggedUser);
                      Navigator.of(context).pop();
                    }
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

