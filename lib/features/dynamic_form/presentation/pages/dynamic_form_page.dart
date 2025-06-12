import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_security/core/constants/app_strings.dart';
import 'package:mobile_security/core/utils/custom_logger.dart';
import 'package:mobile_security/core/utils/utils.dart';
import 'package:mobile_security/features/dynamic_form/domain/entities/form_entity.dart';
import 'package:mobile_security/features/dynamic_form/presentation/bloc/dynamic_form_bloc.dart';
import 'package:mobile_security/features/dynamic_form/presentation/pages/dynamic_widget.dart';

class DynamicFormPage extends StatefulWidget {
  const DynamicFormPage({super.key});

  @override
  State<DynamicFormPage> createState() => _DynamicFormPageState();
}

class _DynamicFormPageState extends State<DynamicFormPage> {
  List<FormEntity> _formEntityList = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};

  void _setupFormData() {
    for (var formEntity in _formEntityList) {
      switch (formEntity.widget) {
        case AppStrings.textFormFieldWidget:
          _formData[formEntity.attributesEntity?.label ?? ''] = '';
          break;
        case AppStrings.dropdownButtonFormFieldWidget:
          _formData[formEntity.attributesEntity?.label ?? ''] = null;
          break;
        case AppStrings.checkboxWidget:
          _formData[formEntity.attributesEntity?.label ?? ''] = false;
          break;
        case AppStrings.radioWidget:
          _formData[formEntity.attributesEntity?.label ?? ''] = null;
          break;
        case AppStrings.rangeSliderWidget:
          _formData[formEntity.attributesEntity?.label ?? ''] = RangeValues(
            double.tryParse(formEntity.attributesEntity?.min ?? '0.0') ?? 0.0,
            double.tryParse(formEntity.attributesEntity?.max ?? '100.0') ??
                100.0,
          );
          break;
        case AppStrings.sliderWidget:
          _formData[formEntity.attributesEntity?.label ?? ''] =
              double.tryParse(formEntity.attributesEntity?.min ?? '0.0') ?? 0.0;
          break;
        case AppStrings.switchWidget:
          _formData[formEntity.attributesEntity?.label ?? ''] = false;
          break;
        default:
          _formData[formEntity.attributesEntity?.label ?? ''] = null;
          CustomLogger.warning('Unknown widget type: ${formEntity.widget}');
      }
    }
  }

  void _updateFormData(String label, dynamic value) {
    _formData[label] = value;
    setState(() {});
    CustomLogger.info('Updated form data: $label = $value');
  }

  @override
  void initState() {
    context.read<DynamicFormBloc>().add(GetDynamicFormListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dynamic Form')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<DynamicFormBloc, DynamicFormState>(
          listener: (context, state) {
            if (state is DynamicFormFailure) {
              Utils.showErrorSnackBar(context: context, message: state.message);
            } else if (state is DynamicFormLoaded) {
              _formEntityList = state.formList;
              _setupFormData();
            }
          },
          builder: (context, state) {
            if (state is DynamicFormLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            return _formEntityList.isEmpty
                ? const Center(child: Text('No dynamic form available'))
                : SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        ListView.builder(
                          itemCount: _formEntityList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return DynamicWidget(
                              formEntity: _formEntityList[index],
                              formData: _formData,
                              onUpdate: (label, value) {
                                _updateFormData(label, value);
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            CustomLogger.info('Submit button pressed');
                            if (!_formKey.currentState!.validate()) {
                              CustomLogger.warning('Form validation failed');
                              Utils.showErrorSnackBar(
                                context: context,
                                message:
                                    'Please fill all required fields correctly.',
                              );
                            } else {
                              CustomLogger.info('Form data: $_formData');
                              Utils.showSuccessSnackBar(
                                context: context,
                                message: 'Form submitted successfully!',
                              );
                            }
                          },
                          child: const Text('Submit'),
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                );
          },
        ),
      ),
    );
  }
}
