import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(
    home: MyForm(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyFormState();
  }
}

class MyFormState extends State<MyForm> {
  final GlobalKey<FormState> _myFormKey = GlobalKey<FormState>();
  final ucontroller = TextEditingController();
  final pcontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final _dateController = TextEditingController();
  String? gender;
  Future<void> _selectDate(BuildContext context) async {
    // this is for date picker
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text("My Form")),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
        child: Form(
            key: _myFormKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: ucontroller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return " please enter name";
                      }
                      if (value.length < 4) {
                        return "Name is less 4 character";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: ("Name"),
                        hintText: "Enter your Name",
                        hintStyle: TextStyle(color: Colors.purple),
                        floatingLabelStyle: TextStyle(color: Colors.purple),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: emailcontroller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return " please enter your Email";
                      }
                      if (!value.contains("@")) {
                        return "please Enter valid Email";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: ("Email"),
                        hintText: "Enter your Email",
                        hintStyle: TextStyle(color: Colors.purple),
                        floatingLabelStyle: TextStyle(color: Colors.purple),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: pcontroller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return " please enter your Password";
                      }
                      if (value.length < 8) {
                        return "please Enter valid Password";
                      }
                      return null;
                    },
                    // this will not show the password
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: ("Password"),
                        hintText: "Enter your Password",
                        hintStyle: TextStyle(color: Colors.purple),
                        floatingLabelStyle: TextStyle(color: Colors.purple),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    //put  Validation
                    validator: (value) {
                      if (value != pcontroller.value.text) {
                        return " please enter same password";
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: ("Confirm password"),
                        hintText: "Enter your Confirm password",
                        hintStyle: TextStyle(color: Colors.purple),
                        floatingLabelStyle: TextStyle(color: Colors.purple),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: _dateController,
                    decoration: const InputDecoration(
                      labelText: 'Date of Birth',
                      hintText: 'Select Date',
                    ),
                    readOnly: true,
                    onTap: () => _selectDate(context),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return " please enter your Date of Birth";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(children: [
                    const Text("Select your gender      "),
                    const Text('male'),
                    Radio(
                        value: 'male',
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value.toString();
                          });
                        }),
                    const Text("female"),
                    Radio(
                        value: 'female',
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value.toString();
                          });
                        }),
                  ]),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.purple),
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    if (_myFormKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FormDataScreen(
                            name: ucontroller.text,
                            email: emailcontroller.text,
                            gender: gender.toString(),
                            date: _dateController.text,
                          ),
                        ),
                      );
                    }
                  },
                )
              ],
            )),
      ),
    );
  }
}

// next screen class for showing data
class FormDataScreen extends StatelessWidget {
  final String name;
  final String email;
  final String gender;
  final String date;

  const FormDataScreen({
    super.key,
    required this.name,
    required this.email,
    required this.gender,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submitted Data'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Name: $name',
            ),
            Text(
              'Email: $email',
            ),
            Text(
              'gender: $gender',
            ),
            Text(
              'date: $date',
            ),
          ],
        ),
      ),
    );
  }
}
