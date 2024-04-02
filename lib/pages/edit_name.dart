import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
// ignore: unused_import
import 'package:flutter_user_profile/user/user_data.dart';
import '../user/user_data.dart';
import '../widgets/appbar_widget.dart';

class EditNameFormPage extends StatefulWidget {
  const EditNameFormPage({Key? key}) : super(key: key);

  @override
  EditNameFormPageState createState() => EditNameFormPageState();
}

class EditNameFormPageState extends State<EditNameFormPage> {
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  var user = UserData.myUser;

  @override
  void dispose() {
    firstNameController.dispose();
    secondNameController.dispose();
    super.dispose();
  }

  void updateUserValue(String name) {
    user.name = name.trim(); // Trim whitespace before updating
  }

  @override
  Widget build(BuildContext context) {
    var elevatedButton = ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          updateUserValue(firstNameController.text.trim() +
              " " +
              secondNameController.text.trim());
          Navigator.pop(context);
        }
      },
      child: const Text(
        'Update',
        style: TextStyle(fontSize: 15),
      ),
      // Disable button if form is invalid
      enabled: _formKey.currentState?.isValid ?? false,
    );
    return Scaffold(
        appBar: buildAppBar(context),
        body: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 330,
                  child: const Text(
                    "What's Your Name?",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 40, 16, 0),
                      child: SizedBox(
                        height: 100,
                        width: 150,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your first name';
                            } else if (!isAlpha(value.trim())) {
                              return 'Only letters allowed';
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: 'First Name'),
                          controller: firstNameController,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 40, 16, 0),
                      child: SizedBox(
                        height: 100,
                        width: 150,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your last name';
                            } else if (!isAlpha(value.trim())) {
                              return 'Only letters allowed';
                            }
                            return null;
                          },
                          decoration:
                              const InputDecoration(labelText: 'Last Name'),
                          controller: secondNameController,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 150),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 330,
                      height: 50,
                      child: elevatedButton,
                    ),
                  ),
                ),
                AbsorbPointer(
                    absorbing: !_formKey.currentState?.isValid ?? false,
                    child: SizedBox(
                        width: 330,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                updateUserValue(
                                    firstNameController.text.trim() +
                                        " " +
                                        secondNameController.text.trim());
                                Navigator.pop(context);
                              }
                            },
                            child: null)))
              ],
            )));
  }
}
