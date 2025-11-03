import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/category_provider.dart';
import '../providers/transaction_provider.dart';
import '../utils/colors.dart';
import '../widgets/balance_card.dart';
import '../widgets/income_expense_card.dart';
import '../widgets/transaction_tile.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final txProvider = Provider.of<TransactionProvider>(context);
    final catProvider = Provider.of<CategoryProvider>(context, listen: false);

    // Format mata uang
    final currencyFormatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Manual refresh
          Provider.of<TransactionProvider>(context, listen: false).loadTransactions();
          Provider.of<CategoryProvider>(context, listen: false).loadCategories();
        },
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // 1. Balance Card
            BalanceCard(
              balance: currencyFormatter.format(txProvider.totalBalance),
            ),
            const SizedBox(height: 16),
      
            // 2. Income & Expense
            IncomeExpenseCard(
              income: currencyFormatter.format(txProvider.totalIncome),
              expense: currencyFormatter.format(txProvider.totalExpense),
            ),
            const SizedBox(height: 24),
      
            // 3. Recent Transactions
            Text(
              'Transaksi Terbaru',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
      
            // 4. Daftar Transaksi
            txProvider.transactions.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text('Belum ada transaksi.'),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: txProvider.transactions.length > 5
                        ? 5
                        : txProvider.transactions.length, // Batasi 5
                    itemBuilder: (ctx, index) {
                      final tx = txProvider.transactions[index];
                      final category = catProvider.getCategoryById(tx.categoryId);
      
                      return TransactionTile(
                        transaction: tx,
                        category: category,
                        formatter: currencyFormatter,
                        onDelete: () {
                           txProvider.deleteTransaction(tx.id);
                           ScaffoldMessenger.of(context).showSnackBar(
                             const SnackBar(content: Text('Transaksi dihapus!'))
                           );
                        },
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}