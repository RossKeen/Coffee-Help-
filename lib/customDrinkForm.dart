import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomDrinkForm extends StatefulWidget {
  final VoidCallback parentReload;
  CustomDrinkForm({required this.parentReload});

  @override
  State<CustomDrinkForm> createState() => _CustomDrinkFormState(parentReload);
}

class _CustomDrinkFormState extends State<CustomDrinkForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final VoidCallback parentReload;
  _CustomDrinkFormState(this.parentReload);

  final _nameController = TextEditingController();
  final _caffeineController = TextEditingController();
  @override
  void dispose() {
    _caffeineController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future addNewDrink(name, caffeine) async {
    final id = new DateTime.now().millisecondsSinceEpoch.toString();
    final newDrink = FirebaseFirestore.instance.collection('drinks').doc(id);
    final newDrinkInfo = {
      'caffeine': int.parse(caffeine),
      'favourited': false,
      'id': id,
      'name': name,
      'custom': true,
    };
    await newDrink.set(newDrinkInfo);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Enter your own drink here',
                  style: TextStyle(fontSize: 20),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(
                  flex: 2,
                ),
                Expanded(
                  flex: 10,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: _nameController,
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(7),
                      hintText: 'Enter your drink name',
                      filled: true,
                      fillColor: Color.fromARGB(255, 232, 230, 198),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                Expanded(
                    flex: 4,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: _caffeineController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(7),
                        hintText: 'mg',
                        filled: true,
                        fillColor: Color.fromARGB(255, 232, 230, 198),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Add mg';
                        }
                        return null;
                      },
                    )),
                Spacer(
                  flex: 2,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: ElevatedButton(
                style: OutlinedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(204, 102, 0, 1)),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    addNewDrink(_nameController.text, _caffeineController.text);
                    parentReload();
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
