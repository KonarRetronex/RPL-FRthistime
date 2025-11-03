import 'package:flutter/material.dart';
import '../utils/colors.dart';

class IncomeExpenseCard extends StatelessWidget {
  final String income;
  final String expense;

  const IncomeExpenseCard({
    super.key,
    required this.income,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildCard(
            context,
            'Pemasukan',
            income,
            AppColors.income,
            Icons.arrow_downward,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildCard(
            context,
            'Pengeluaran',
            expense,
            AppColors.expense,
            Icons.arrow_upward,
          ),
        ),
      ],
    );
  }

  Widget _buildCard(
    BuildContext context,
    String title,
    String amount,
    Color color,
    IconData icon,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.1),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.labelMedium),
                const SizedBox(height: 4),
                Text(
                  amount,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 16, color: color),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}