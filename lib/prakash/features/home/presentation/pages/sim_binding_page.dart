import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_security/prakash/core/utils/custom_logger.dart';
import 'package:mobile_security/prakash/core/utils/utils.dart';
import 'package:mobile_security/prakash/features/home/presentation/bloc/home_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class SimBindingPage extends StatefulWidget {
  const SimBindingPage({super.key});

  @override
  State<SimBindingPage> createState() => _SimBindingPageState();
}

class _SimBindingPageState extends State<SimBindingPage>
    with WidgetsBindingObserver {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  String? _deviceId;
  bool _isSmsSent = false;

  bool _enableSimBinding = false;

  void _getDeviceInfo() async {
    final ios = await DeviceInfoPlugin().iosInfo;

    _deviceId = ios.identifierForVendor;

    CustomLogger.info('Current Device ID: $_deviceId');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkBindingStatus();
    });
  }

  void _checkBindingStatus() {
    if (_deviceId == null) {
      Utils.showErrorSnackBar(
        context: context,
        message: 'Device ID cannot be empty',
      );
    } else {
      context.read<HomeBloc>().add(
        CheckSimBindingStatusEvent(deviceId: _deviceId!),
      );
    }
  }

  void _sendOtp() {
    if (_phoneNumberController.text.trim().isEmpty) {
      Utils.showErrorSnackBar(
        context: context,
        message: 'Phone number cannot be empty',
      );
    } else if (_phoneNumberController.text.trim().length != 10) {
      Utils.showErrorSnackBar(
        context: context,
        message: 'Phone number must be 10 digits',
      );
    } else {
      context.read<HomeBloc>().add(
        SendOtpEvent(phoneNumber: _phoneNumberController.text.trim()),
      );
    }
  }

  void _verifyOtp() {
    if (_otpController.text.trim().isEmpty) {
      Utils.showErrorSnackBar(context: context, message: 'OTP cannot be empty');
    } else {
      context.read<HomeBloc>().add(
        VerifyOtpEvent(otp: _otpController.text.trim()),
      );
    }
  }

  void _bindSim() async {
    String serverNumber = '+918668552690';
    if (_deviceId == null) {
      Utils.showErrorSnackBar(
        context: context,
        message: 'Device ID cannot be empty',
      );
    } else {
      final bindMsg = 'BIND SIM for app Device ID: $_deviceId';
      final smsUrl = Uri.parse('sms:$serverNumber?body=$bindMsg');
      if (await canLaunchUrl(smsUrl)) {
        launchUrl(smsUrl);
        _isSmsSent = true;
      } else {
        Utils.showErrorSnackBar(
          context: context,
          message: 'Could not launch SMS app',
        );
      }
    }
  }

  void _startBackendVerification() {
    context.read<HomeBloc>().add(
      VerifySimBindingEvent(
        deviceId: _deviceId!,
        mobileNumber: _phoneNumberController.text.trim(),
      ),
    );
    CustomLogger.info('_startBackendVerification');
    _isSmsSent = false;
  }

  @override
  void initState() {
    CustomLogger.info('starting initState _isSmsSent: $_isSmsSent');
    WidgetsBinding.instance.addObserver(this);
    _getDeviceInfo();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    CustomLogger.info('AppLifecycleState: $state _isSmsSent: $_isSmsSent');
    if (state == AppLifecycleState.resumed && _isSmsSent) {
      _startBackendVerification();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _phoneNumberController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SIM/Device Binding'),
        centerTitle: true,
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is OtpGenerated) {
            Utils.showSuccessSnackBar(
              context: context,
              message: 'OTP sent successfully',
            );
          } else if (state is OtpVerified) {
            _enableSimBinding = true;
            Utils.showSuccessSnackBar(
              context: context,
              message: 'OTP verified successfully',
            );
          } else if (state is HomeFailure) {
            CustomLogger.error(state.message);
            Utils.showErrorSnackBar(context: context, message: state.message);
          } else if (state is SimBindingVerified) {
            Utils.showSuccessSnackBar(
              context: context,
              message: 'SIM/Device binding verified successfully',
            );
          } else if(state is SimNotBounded) {
            Utils.showErrorSnackBar(
              context: context,
              message: 'SIM/Device not bound',
            );
          }
        },
        builder: (context, state) {
          if (state is SimBindingVerified) {
            return const Center(
              child: Text(
                'SIM/Device binding verified successfully',
                style: TextStyle(fontSize: 20),
              ),
            );
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Bind your SIM/Device to your account',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _phoneNumberController,
                    maxLength: 10,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      _sendOtp();
                    },
                    child: Text('Send OTP'),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _otpController,
                    decoration: InputDecoration(
                      labelText: 'OTP',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),

                  TextButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      _verifyOtp();
                    },
                    child: Text('Verify OTP'),
                  ),

                  const SizedBox(height: 16),
                  if(_enableSimBinding)
                  TextButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      _bindSim();
                    },
                    child: Text('Bind SIM/Device'),
                  ),
                  const SizedBox(height: 16),

                  if (state is HomeLoading)
                    const Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
