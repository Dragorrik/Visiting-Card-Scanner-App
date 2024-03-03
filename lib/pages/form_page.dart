import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vcard_app/models/contact_model.dart';
import 'package:vcard_app/pages/home_page.dart';
import 'package:vcard_app/providers/contact_provider.dart';
import 'package:vcard_app/utils/helpers.dart';

class FormPage extends StatefulWidget {
  static const String routeName = '/form';
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final designationController = TextEditingController();
  final companyController = TextEditingController();
  final websiteController = TextEditingController();
  final addressController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late ContactModel contactModel;

  @override
  void didChangeDependencies() {
    contactModel=ModalRoute.of(context)!.settings.arguments as ContactModel;
    nameController.text=contactModel.name;
    mobileController.text=contactModel.mobile;
    emailController.text=contactModel.email;
    companyController.text=contactModel.company;
    designationController.text=contactModel.designation;
    addressController.text=contactModel.address;
    websiteController.text=contactModel.website;

    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Contact"),
        actions: [IconButton(onPressed: _saveContact, icon: const Icon(Icons.save))],
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Contact name",
                    prefixIcon: Icon(
                      Icons.person,
                    ),
                    filled: true,
                    fillColor: Colors.black26,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field can not be empty";
                    }
                    if (value.length > 30) {
                      return "Name can not be that long!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: mobileController,
                  decoration: const InputDecoration(
                    labelText: "Mobile No",
                    prefixIcon: Icon(Icons.phone),
                    filled: true,
                    fillColor: Colors.black26,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field can not be empty";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Email Address",
                    prefixIcon: Icon(Icons.email),
                    filled: true,
                    fillColor: Colors.black26,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: TextFormField(
                  controller: companyController,
                  decoration: const InputDecoration(
                    labelText: "Company Name",
                    prefixIcon: Icon(Icons.location_city),
                    filled: true,
                    fillColor: Colors.black26,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: TextFormField(
                  controller: designationController,
                  decoration: const InputDecoration(
                    labelText: "Designation",
                    prefixIcon: Icon(Icons.stadium_rounded),
                    filled: true,
                    fillColor: Colors.black26,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    labelText: "Street Address",
                    prefixIcon: Icon(Icons.location_on),
                    filled: true,
                    fillColor: Colors.black26,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: TextFormField(
                  controller: websiteController,
                  decoration: const InputDecoration(
                    labelText: "Website",
                    prefixIcon: Icon(Icons.web_sharp),
                    filled: true,
                    fillColor: Colors.black26,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveContact() async {
    if (formKey.currentState!.validate()) {
        contactModel.name=  nameController.text;
        contactModel.mobile=  mobileController.text;
        contactModel.email=  emailController.text;
        contactModel.address=  addressController.text;
        contactModel.company=  companyController.text;
        contactModel.designation=  designationController.text;
        contactModel.website=  websiteController.text;

      Provider.of<ContactProvider>(context,listen: false).insertContact(contactModel).then((value) {
        if(value>0){
          showMsg(context, "Saved");
          Navigator.popUntil(context, ModalRoute.withName(HomePage.routeName));
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    designationController.dispose();
    companyController.dispose();
    websiteController.dispose();
    addressController.dispose();
  }
}
