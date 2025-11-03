import 'package:flutter/material.dart';
import '../utils/colors.dart';

class BalanceCard extends StatelessWidget {
  final String balance;
  const BalanceCard({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primary,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Saldo',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white70),
            ),
            const SizedBox(height: 8),
            Text(
              balance,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}