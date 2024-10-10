import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WalletTransaction {
  final String id;
  final double amount;
  final String type;  
  final DateTime date;
  final String status;  

  WalletTransaction({
    required this.id,
    required this.amount,
    required this.type,
    required this.date,
    required this.status,
  });
}





class WalletManager extends StatefulWidget {
  @override
  _WalletManagerState createState() => _WalletManagerState();
}

class _WalletManagerState extends State<WalletManager> {
  double walletBalance = 1000.0; // Initial balance
  List<WalletTransaction> transactions = [];
  final TextEditingController withdrawalController = TextEditingController();

  void requestWithdrawal(double amount) {
    setState(() {
      if (amount <= walletBalance) {
        walletBalance -= amount;
        transactions.add(WalletTransaction(
          id: DateTime.now().toString(),
          amount: amount,
          type: 'withdrawal',
          date: DateTime.now(),
          status: 'pending',
        ));
        withdrawalController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Insufficient balance!')),
        );
      }
    });
  }

  void showWithdrawalDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Request Withdrawal'),
          content: TextField(
            controller: withdrawalController,
            decoration: InputDecoration(labelText: 'Amount'),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () {
                double amount = double.tryParse(withdrawalController.text) ?? 0;
                requestWithdrawal(amount);
                Navigator.of(context).pop();
              },
              child: Text('Request'),
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
        title: Text('Wallet Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Current Balance: \$${walletBalance.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: showWithdrawalDialog,
                child: Text('Request Withdrawal'),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Transaction History:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return ListTile(
                    title: Text(
                      '${transaction.type.toUpperCase()}: \$${transaction.amount.toStringAsFixed(2)}',
                    ),
                    subtitle: Text(
                      DateFormat('yyyy-MM-dd – kk:mm').format(transaction.date),
                    ),
                    trailing: Text(transaction.status),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}