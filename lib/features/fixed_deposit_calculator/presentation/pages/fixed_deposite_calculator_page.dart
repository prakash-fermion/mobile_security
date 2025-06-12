import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_security/core/constants/app_strings.dart';
import 'package:mobile_security/core/utils/custom_logger.dart';
import 'package:mobile_security/core/utils/utils.dart';
import 'package:mobile_security/features/fixed_deposit_calculator/domain/entities/calculation_request_entity.dart';
import 'package:mobile_security/features/fixed_deposit_calculator/domain/entities/dropdown_entity.dart';
import 'package:mobile_security/features/fixed_deposit_calculator/domain/entities/interest_rate_entity.dart';
import 'package:mobile_security/features/fixed_deposit_calculator/presentation/bloc/fixed_deposit_calculator_bloc.dart';

class FixedDepositeCalculatorPage extends StatefulWidget {
  const FixedDepositeCalculatorPage({super.key});

  @override
  State<FixedDepositeCalculatorPage> createState() =>
      _FixedDepositeCalculatorPageState();
}

class _FixedDepositeCalculatorPageState
    extends State<FixedDepositeCalculatorPage> {
  final TextEditingController _amountController = TextEditingController();

  List<DropdownEntity> _citizenList = [];
  List<InterestRateEntity> _interestRateList = [];

  DropdownEntity? _selectedCitizen;
  InterestRateEntity? _selectedInterestRate;

  int _principleAmount = 0;
  int _maturityAmount = 0;
  int _interestEarned = 0;

  void _initApiCall() {
    context.read<FixedDepositCalculatorBloc>().add(FetchCitizenListEvent());
    context.read<FixedDepositCalculatorBloc>().add(FetchInterestRateEvent());
  }

  double _getInterestRate() {
    if (_selectedCitizen?.code == 'YES') {
      return _selectedInterestRate?.seniorInterestRate ?? 0;
    } else {
      return _selectedInterestRate?.junioInterestRate ?? 0;
    }
  }

  void _calculateFD() {
    if (_amountController.text.trim().isNotEmpty &&
        _selectedCitizen != null &&
        _selectedInterestRate != null) {
      context.read<FixedDepositCalculatorBloc>().add(
        CalculateFixedDepositEvent(
          calculationRequest: CalculationRequestEntity(
            principalAmount: _principleAmount,
            interestRate: _getInterestRate(),
            tenure: _selectedInterestRate?.tenure ?? 0,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    _initApiCall();
    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.fixedDepositCalculator)),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey, width: 1),
        ),

        child: BlocConsumer<
          FixedDepositCalculatorBloc,
          FixedDepositCalculatorState
        >(
          listener: (context, state) {
            if (state is FixedDepositCalculatorCitizenLoaded) {
              _citizenList = state.citizenList;
              _selectedCitizen = _citizenList[1];
            } else if (state is FixedDepositCalculatorInterestRateLoaded) {
              _interestRateList = state.interestRateList;
            } else if (state is FixedDepositCalculatorFailure) {
              Utils.showErrorSnackBar(context: context, message: state.message);
            } else if (state is FixedDepositCalculatorSuccess) {
              _maturityAmount = state.calculationEntity.maturityAmount;
              _interestEarned = state.calculationEntity.interestEarned;
            }
          },
          builder: (context, state) {
            if (state is FixedDepositCalculatorLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppStrings.appName,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _amountWidget(),
                  const SizedBox(height: 10),
                  _seniorCitizenWidget(),
                  const SizedBox(height: 10),
                  _interestRateAndTenureWidget(),
                  const SizedBox(height: 10),
                  _labelWidget(
                    label: AppStrings.investmentAmount,
                    value:
                        _amountController.text.trim().isEmpty
                            ? '₹0'
                            : _amountController.text.trim(),
                  ),
                  const SizedBox(height: 10),
                  _labelWidget(
                    label: AppStrings.compounding,
                    value: 'Quarterly',
                  ),
                  const SizedBox(height: 10),
                  _labelWidget(
                    label: AppStrings.fdRateApplicable,
                    value: '${_getInterestRate()}%',
                  ),
                  const SizedBox(height: 10),
                  _labelWidget(
                    label: AppStrings.fdTenure,
                    value: _selectedInterestRate?.tenureLabel ?? "0",
                  ),
                  const SizedBox(height: 10),
                  _labelWidget(
                    label: AppStrings.maturityAmount,
                    value: Utils.formatIndianCurrency(_maturityAmount),
                  ),
                  const SizedBox(height: 10),
                  _labelWidget(
                    label: AppStrings.interestEarned,
                    value: Utils.formatIndianCurrency(_interestEarned),
                    isGreen: true,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _amountWidget() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.amount,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black45,
              fontSize: 14,
            ),
          ),
          TextFormField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            maxLength: 16,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              counterText: '',
            ),
            onChanged: (value) {
              _principleAmount = int.tryParse(value) ?? 0;
              _calculateFD();
              _amountController.text = Utils.formatIndianCurrency(
                _principleAmount,
              );
              _amountController.selection = TextSelection.fromPosition(
                TextPosition(offset: _amountController.text.length),
              );
              CustomLogger.info('Amount changed: $value');
            },
          ),
        ],
      ),
    );
  }

  Widget _seniorCitizenWidget() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.srCitizen,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black45,
              fontSize: 14,
            ),
          ),
          DropdownButtonFormField<DropdownEntity>(
            value: _selectedCitizen,
            icon: Icon(Icons.keyboard_arrow_down),
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
            ),
            items:
                _citizenList
                    .map(
                      (DropdownEntity item) => DropdownMenuItem<DropdownEntity>(
                        value: item,
                        child: Text(item.label ?? ''),
                      ),
                    )
                    .toList(),
            onChanged: (value) {
              setState(() {
                _selectedCitizen = value;
                _calculateFD();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _interestRateAndTenureWidget() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.interestRateAndTenure,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black45,
              fontSize: 14,
            ),
          ),
          DropdownButtonFormField<InterestRateEntity>(
            value: _selectedInterestRate,
            icon: Icon(Icons.keyboard_arrow_down),
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
            ),
            items:
                _interestRateList
                    .map(
                      (
                        InterestRateEntity item,
                      ) => DropdownMenuItem<InterestRateEntity>(
                        value: item,
                        child: Text(
                          _selectedCitizen?.code == 'YES'
                              ? '${item.tenureLabel} (${item.seniorInterestRate}%)'
                              : '${item.tenureLabel} (${item.junioInterestRate}%)',
                        ),
                      ),
                    )
                    .toList(),
            onChanged: (value) {
              _selectedInterestRate = value;
              _calculateFD();
            },
          ),
        ],
      ),
    );
  }

  Widget _labelWidget({
    required String label,
    required String value,
    bool isGreen = false,
  }) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black45,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                // Calculate the number of dots based on available width
                final double dashWidth = 4.0;
                final double gapWidth = 4.0;
                final int dashCount =
                    (constraints.maxWidth / (dashWidth + gapWidth)).floor();
                return Row(
                  children: List.generate(dashCount, (_) {
                    return Container(
                      width: dashWidth,
                      height: 1,
                      color: Colors.black45,
                      margin: EdgeInsets.symmetric(horizontal: gapWidth / 2),
                    );
                  }),
                );
              },
            ),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: isGreen ? Colors.green : Colors.black,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
