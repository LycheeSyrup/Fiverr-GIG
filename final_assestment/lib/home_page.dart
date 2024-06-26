import 'package:flutter/material.dart';
import 'account.dart';
import 'account_form.dart';
import 'account_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Account> accounts = []; // List to store created accounts
  bool isCreatePage = true; // Toggle flag to switch between pages

  final ScrollController _createScrollController = ScrollController(); // Scroll controller for create page
  final ScrollController _viewScrollController = ScrollController(); // Scroll controller for view page

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Key for the form
  final TextEditingController _gigIdController = TextEditingController(); // Controller for GIG ID field
  final TextEditingController _nameController = TextEditingController(); // Controller for NAME field
  final TextEditingController _pricingController = TextEditingController(); // Controller for PRICING field

  int? _editingIndex; // Index of the account being edited

  // Toggle between create and view pages
  void _togglePage() {
    setState(() {
      isCreatePage = !isCreatePage;
      _clearForm();
    });
  }

  // Clear the form fields
  void _clearForm() {
    _gigIdController.clear();
    _nameController.clear();
    _pricingController.clear();
    _editingIndex = null;
  }

  // Submit the form and add or edit the account
  void _submitForm() {
    if (_formKey.currentState!.validate()) { // Validate the form
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm Submission'),
            content: Text('Do you want to submit the form?'),
            actions: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Confirm'),
                onPressed: () {
                  setState(() {
                    if (_editingIndex == null) {
                      // Add the account to the list
                      accounts.insert(0, Account(
                        gigId: _gigIdController.text,
                        name: _nameController.text,
                        pricing: double.parse(_pricingController.text),
                      ));
                    } else {
                      // Update the existing account
                      accounts[_editingIndex!] = Account(
                        gigId: _gigIdController.text,
                        name: _nameController.text,
                        pricing: double.parse(_pricingController.text),
                      );
                    }
                  });
                  Navigator.of(context).pop();
                  _clearForm();
                  // Switch to view page
                  setState(() {
                    isCreatePage = false;
                  });
                },
              ),
            ],
          );
        },
      );
    }
  }

  // Edit an existing account
  void _editAccount(int index) {
    _gigIdController.text = accounts[index].gigId;
    _nameController.text = accounts[index].name;
    _pricingController.text = accounts[index].pricing.toString();
    setState(() {
      isCreatePage = true;
      _editingIndex = index;
    });
  }

  // Delete an account
  void _deleteAccount(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Do you want to delete this account?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                setState(() {
                  accounts.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic App'),
        actions: [
          IconButton(
            icon: Icon(isCreatePage ? Icons.visibility : Icons.create),
            onPressed: _togglePage,
          ),
        ],
      ),
      body: isCreatePage
          ? AccountForm(
        formKey: _formKey,
        gigIdController: _gigIdController,
        nameController: _nameController,
        pricingController: _pricingController,
        onSubmit: _submitForm,
      )
          : AccountList(
        accounts: accounts,
        onEdit: _editAccount,
        onDelete: _deleteAccount,
        scrollController: _viewScrollController,
      ), // Show the appropriate page
    );
  }
}
