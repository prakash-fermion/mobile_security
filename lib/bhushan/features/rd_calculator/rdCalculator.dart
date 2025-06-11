import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile_security/bhushan/core/utils/utils.dart';

class RDCalculatorScreen extends StatefulWidget {
  const RDCalculatorScreen({super.key});

  @override
  State<RDCalculatorScreen> createState() => _RDCalculatorScreenState();
}

class _RDCalculatorScreenState extends State<RDCalculatorScreen> {
  double investmentAmount = 100000;
  double investmentPeriod = 36;
  double interestRate = 3.2;
  TextEditingController investmentAmountController = TextEditingController(
    text: "100000",
  );
  double calculateRDMaturity({
    required double monthlyDeposit,
    required int durationInMonths,
    required double annualInterestRate,
  }) {
    double r = annualInterestRate / 100; // Annual interest rate as a fraction
    double n = 4; // Interest is compounded monthly
    double maturityAmount = 0.0; // Initialize maturityAmount
    for (int month = 0; month < durationInMonths; month++) {
      double timeInYears = (durationInMonths - month) / 12.0;
      num compoundFactor = pow((1 + r / n), (n * timeInYears));
      double depositMaturity = monthlyDeposit * compoundFactor;
      maturityAmount += depositMaturity;
    }

    return maturityAmount;
  }

  @override
  Widget build(BuildContext context) {
    double maturityAmount = calculateRDMaturity(
      monthlyDeposit: investmentAmount,
      durationInMonths: investmentPeriod.toInt(),
      annualInterestRate: interestRate,
    );
    double wealthGained =
        (maturityAmount - (investmentAmount * investmentPeriod));
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Calculate Utkarsh Small Finance Bank Returns",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            const Text("Investment Amount"),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixText: '₹ ',
                hintText: 'Enter amount',
              ),
              controller: investmentAmountController,
              onChanged: (val) {
                setState(() {
                  investmentAmount = double.tryParse(val) ?? 100000;
                });
              },
            ),
            const SizedBox(height: 20),
            Text("Investment Period (in months): ${investmentPeriod.toInt()}"),
            Slider(
              value: investmentPeriod,
              min: 1,
              max: 120,
              divisions: 119,
              label: investmentPeriod.toStringAsFixed(0),
              onChanged: (val) {
                setState(() {
                  investmentPeriod = val;
                });
              },
            ),
            Text("Interest Rate: ${interestRate.toStringAsFixed(1)}%"),
            Slider(
              value: interestRate,
              min: 1,
              max: 10,
              divisions: 90,
              label: "${interestRate.toStringAsFixed(1)}%",
              onChanged: (val) {
                setState(() {
                  interestRate = val;
                });
              },
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${Utils.formatAmount(investmentAmount)}\nTotal Investment",
                ),
                Text("${Utils.formatAmount(wealthGained)}\nWealth Gained"),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                "${Utils.formatAmount(maturityAmount)}",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            const Center(child: Text("Maturity Amount")),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: const [
                  Expanded(
                    child: Text("Invest in SIP to earn ₹37,83,253 more"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
