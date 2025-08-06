import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyListState extends StatelessWidget {
  const EmptyListState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.lock_outline, size: 64, color: Colors.grey[400]),
          SizedBox(height: 16),
          Text(
            'No passwords found',
            style: GoogleFonts.bebasNeue(color: Colors.grey[600], fontSize: 20),
          ),
          SizedBox(height: 8),
          Text(
            'Tap the + button to add your first password',
            style: GoogleFonts.poppins(color: Colors.grey[500], fontSize: 14),
          ),
        ],
      ),
    );
  }
}
