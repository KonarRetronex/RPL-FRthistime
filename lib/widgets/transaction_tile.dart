import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/category_model.dart';
import '../models/transaction_model.dart';
import '../utils/colors.dart';
import 'glass_card.dart';

class TransactionTile extends StatelessWidget {
  final TransactionModel transaction;
  final CategoryModel category;
  final NumberFormat formatter;
  final VoidCallback onDelete;

  const TransactionTile({
    super.key,
    required this.transaction,
    required this.category,
    required this.formatter,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.type == TransactionType.income;
    final color = isIncome ? AppColors.income : AppColors.expense;
    final sign = isIncome ? '+' : '-';
    // Ganti ikon berdasarkan kategori (Contoh sederhana)
    final icon = category.name.toLowerCase() == 'shopping' 
                 ? Icons.shopping_bag 
                 : Icons.wallet_travel; // Ikon default

    return GlassCard(
      padding: const EdgeInsets.all(12.0),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          backgroundColor: AppColors.glass.withOpacity(0.2),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        title: Text(
          category.name,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
        ),
        subtitle: Text(
          DateFormat('E, dd/MM/yyyy').format(transaction.date), // Format tanggal baru
          style: Theme.of(context).textTheme.labelMedium,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$sign ${formatter.format(transaction.amount)}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            // Tombol delete (mungkin di-hide agar UI lebih bersih, 
            // atau ganti dengan gestur 'onLongPress' pada GlassCard)
            IconButton(
              icon: Icon(Icons.delete_outline, color: Colors.grey[600]),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}