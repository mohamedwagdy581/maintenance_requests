import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maintenance/modules/request_order/requests_cubit/requests_cubit.dart';
import 'package:flutter_maintenance/modules/request_order/requests_cubit/requests_states.dart';

import '../../shared/components/components.dart';

class RequestOrderScreen extends StatefulWidget {
  const RequestOrderScreen({Key? key}) : super(key: key);

  @override
  _RequestOrderScreenState createState() => _RequestOrderScreenState();
}

class _RequestOrderScreenState extends State<RequestOrderScreen> {
  var selectedType;

  int _cityValue = 1;

  int _schoolValue = 1;

  int _machineValue = 1;

  int _machineTypeValue = 1;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var consultationController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (BuildContext context)  => RequestCubit(),
      child: BlocConsumer<RequestCubit, RequestStates>(
        listener: (context, state) {},
        builder: (context,  state)
        {
          return  SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.03,
                    ),
                    // City ListTile with DropdownButton
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[300],
                      ),
                      child: ListTile(
                        title: const Text(
                          'Select your City',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        trailing: DropdownButton(
                          value: _cityValue,
                          borderRadius: BorderRadius.circular(15.0),
                          items: const [
                            DropdownMenuItem(
                              value: 1,
                              child: Text("City"),
                            ),
                            DropdownMenuItem(
                              value: 2,
                              child: Text("Jazan "),
                            ),
                            DropdownMenuItem(
                              value: 3,
                              child: Text("Emarah"),
                            ),
                            DropdownMenuItem(
                              value: 4,
                              child: Text("Sabia "),
                            ),
                            DropdownMenuItem(
                              value: 5,
                              child: Text("Edarah"),
                            ),
                            DropdownMenuItem(
                              value: 6,
                              child: Text("Jeddah "),
                            ),
                            DropdownMenuItem(
                              value: 7,
                              child: Text("Ryadh "),
                            ),
                            DropdownMenuItem(
                              value: 8,
                              child: Text("Other City"),
                            ),
                          ],
                          onChanged: (int? value) {
                            setState(() {
                              _cityValue = value!;
                            });
                          },
                          hint: const Text("Select School"),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),

                    // School ListTile with DropdownButton
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[300],
                      ),
                      child: ListTile(
                        title: const Text(
                          'Select your School',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        trailing: DropdownButton(
                          value: _schoolValue,
                          borderRadius: BorderRadius.circular(15.0),
                          items: const [
                            DropdownMenuItem(
                              value: 1,
                              child: Text("School"),
                            ),
                            DropdownMenuItem(
                              value: 2,
                              child: Text("Jazan School"),
                            ),
                            DropdownMenuItem(
                              value: 3,
                              child: Text("Emarah"),
                            ),
                            DropdownMenuItem(
                              value: 4,
                              child: Text("Sabia School"),
                            ),
                            DropdownMenuItem(
                              value: 5,
                              child: Text("Edarah"),
                            ),
                            DropdownMenuItem(
                              value: 6,
                              child: Text("Jeddah School"),
                            ),
                            DropdownMenuItem(
                              value: 7,
                              child: Text("Ryadh School"),
                            ),
                            DropdownMenuItem(
                              value: 8,
                              child: Text("Other School"),
                            ),
                          ],
                          onChanged: (int? value) {
                            setState(() {
                              _schoolValue = value!;
                            });
                          },
                          hint: const Text("Select School"),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),

                    // Machine ListTile with DropdownButton
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[300],
                      ),
                      child: ListTile(
                        title: const Text(
                          'Select your Machine',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        trailing: DropdownButton(
                          value: _machineValue,
                          borderRadius: BorderRadius.circular(15.0),
                          items: const [
                            DropdownMenuItem(
                              value: 1,
                              child: Text("Machine"),
                            ),
                            DropdownMenuItem(
                              value: 2,
                              child: Text("Printer"),
                            ),
                            DropdownMenuItem(
                              value: 3,
                              child: Text("Laptop"),
                            ),
                            DropdownMenuItem(
                              value: 4,
                              child: Text("PC"),
                            ),
                            DropdownMenuItem(
                              value: 5,
                              child: Text("Projector"),
                            ),
                            DropdownMenuItem(
                              value: 6,
                              child: Text("Accessories"),
                            ),
                          ],
                          onChanged: (int? value) {
                            setState(() {
                              _machineValue = value!;
                            });
                          },
                          hint: const Text("Select Machine"),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),

                    // Machine Type ListTile with DropdownButton
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[300],
                      ),
                      child: ListTile(
                        title: const Text(
                          'Select Machine Type',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        trailing: DropdownButton(
                          value: _machineTypeValue,
                          borderRadius: BorderRadius.circular(15.0),
                          items: const [
                            DropdownMenuItem(
                              value: 1,
                              child: Text("Machine Type"),
                            ),
                            DropdownMenuItem(
                              value: 2,
                              child: Text("Lenovo"),
                            ),
                            DropdownMenuItem(
                              value: 3,
                              child: Text("Samsung"),
                            ),
                            DropdownMenuItem(
                              value: 4,
                              child: Text("Dell"),
                            ),
                            DropdownMenuItem(
                              value: 5,
                              child: Text("Apple"),
                            ),
                            DropdownMenuItem(
                              value: 6,
                              child: Text("Sony"),
                            ),
                            DropdownMenuItem(
                              value: 7,
                              child: Text("Redmi"),
                            ),
                            DropdownMenuItem(
                              value: 8,
                              child: Text("Toshiba"),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _machineTypeValue = value!;
                            });
                          },
                          hint: const Text("Select Machine Type"),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),

                    // Consultation TextField
                    SizedBox(
                      width: width * 0.8, //height: 350,
                      child: TextField(
                        controller: consultationController,
                        textDirection: TextDirection.rtl,
                        maxLines: 5,
                        style: const TextStyle(
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.end,
                        decoration: const InputDecoration(
                          hintText: ' !اكتب استفسارك',
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: height * 0.03,
                    ),

                    ConditionalBuilder(
                      condition: state is! RequestLoadingState,
                      builder: (context) =>
                          defaultButton(
                            onPressed: () {
                              if(_formKey.currentState!.validate())
                              {
                                final city = _cityValue.toString();
                                final school = _cityValue.toString();
                                final machine = _cityValue.toString();
                                final machineType = _cityValue.toString();
                                final consultation = _cityValue.toString();

                                RequestCubit.get(context).userRequest(
                                  city: city,
                                  school: school,
                                  machine: machine,
                                  machineType: machineType,
                                  consultation: consultation,
                                );
                              }
                            },
                            text: 'Done',
                          ),
                      fallback: (context) =>
                      const Center(child: CircularProgressIndicator()),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
