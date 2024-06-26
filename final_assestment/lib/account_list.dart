import 'package:flutter/material.dart';
import 'account.dart';

class AccountList extends StatelessWidget {
  final List<Account> accounts;
  final Function(int) onEdit;
  final Function(int) onDelete;
  final ScrollController scrollController;

  AccountList({
    required this.accounts,
    required this.onEdit,
    required this.onDelete,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.all(16.0),
      itemCount: accounts.length,
      itemBuilder: (context, index) {
        final account = accounts[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text(account.name),
            subtitle: Text('GIG ID: ${account.gigId}\nPricing: \$${account.pricing.toStringAsFixed(2)}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => onEdit(index),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => onDelete(index),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
