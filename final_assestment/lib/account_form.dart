import 'package:flutter/material.dart';

class AccountForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController gigIdController;
  final TextEditingController nameController;
  final TextEditingController pricingController;
  final VoidCallback onSubmit;

  AccountForm({
    required this.formKey,
    required this.gigIdController,
    required this.nameController,
    required this.pricingController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: gigIdController,
              decoration: InputDecoration(labelText: 'GIG ID'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter GIG ID';
                }
                return null;
              },
            ),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'NAME'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter NAME';
                }
                return null;
              },
            ),
            TextFormField(
              controller: pricingController,
              decoration: InputDecoration(labelText: 'PRICING'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter PRICING';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onSubmit,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
