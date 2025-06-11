import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_security/bhushan/features/dynamic_form/bloc/dynamic_form_event.dart';
import 'package:mobile_security/bhushan/features/dynamic_form/data/models/dynamic_form_model.dart';
import '../../../../core/constants/app_string.dart';
import '../../../../core/utils/utils.dart';
import '../../bloc/dynamic_form_bloc.dart';
import '../../bloc/dynamic_form_state.dart';
import 'dynamic_form_widget.dart';

class DynamicFormPage extends StatefulWidget {
  const DynamicFormPage({super.key});

  @override
  State<DynamicFormPage> createState() => _DynamicFormPageState();
}

class _DynamicFormPageState extends State<DynamicFormPage> {
  List<DynamicFormModel> _formEntityList = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};

  void _setupFormData() {
    for (var formEntity in _formEntityList) {
      switch (formEntity.widget) {
        case AppStrings.textFormFieldWidget:
          _formData[formEntity.attributes.label] = '';
          break;
        case AppStrings.dropdownButtonFormFieldWidget:
          _formData[formEntity.attributes.label] = null;
          break;
        case AppStrings.checkboxWidget:
          _formData[formEntity.attributes.label] = false;
          break;
        case AppStrings.radioWidget:
          _formData[formEntity.attributes.label] = null;
          break;
        case AppStrings.rangeSliderWidget:
          _formData[formEntity.attributes.label] = RangeValues(
            double.tryParse(formEntity.attributes.min ?? '0.0') ?? 0.0,
            double.tryParse(formEntity.attributes.max ?? '100.0') ?? 100.0,
          );
          break;
        case AppStrings.sliderWidget:
          _formData[formEntity.attributes.label] =
              double.tryParse(formEntity.attributes.min ?? '0.0') ?? 0.0;
          break;
        case AppStrings.switchWidget:
          _formData[formEntity.attributes.label] = false;
          break;
        default:
          _formData[formEntity.attributes.label] = null;
      }
    }
  }

  void _updateFormData(String label, dynamic value) {
    _formData[label] = value;
    setState(() {});
  }

  @override
  void initState() {
    context.read<DynamicFormBloc>().add(DynamicFormEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            if (!_formKey.currentState!.validate()) {
                              Utils.showErrorSnackBar(
                                context: context,
                                message:
                                    'Please fill all required fields correctly.',
                              );
                            } else {
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
