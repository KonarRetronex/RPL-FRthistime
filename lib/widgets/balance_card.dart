import 'package:flutter/material.dart';
import 'glass_card.dart';

class BalanceCard extends StatelessWidget {
  final String balance;
  const BalanceCard({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      color: Colors.white, // Kartu ini putih solid
      borderRadius: 24,
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Balance',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.black54, // Teks di kartu putih jadi gelap
                ),
          ),
          const SizedBox(height: 8),
          Text(
            balance,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: Colors.black87, // Teks di kartu putih jadi gelap
                  fontSize: 28, // Sesuaikan ukuran
                ),
          ),
        ],
      ),
    );
  }
}