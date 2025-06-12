import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sim_data/sim_data_model.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_security/core/utils/custom_logger.dart';
import 'package:mobile_security/features/sim_binding/bloc/sim_binding_event.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/utils/utils.dart';
import '../bloc/sim_binding_bloc.dart';
import '../bloc/sim_binding_states.dart';

class SimBindingScreen extends StatefulWidget {
  const SimBindingScreen({super.key});

  @override
  State<SimBindingScreen> createState() => _SimBindingScreenState();
}

class _SimBindingScreenState extends State<SimBindingScreen> {
  SimDataModel? _selectedSim;
  @override
  void initState() {
    super.initState();
    context.read<SimBindingBloc>().add(LoadSimBinding());
    // _fetchSimData();
    _fetchDeviceInfo();
  }

  final deviceInfoPlugin = DeviceInfoPlugin();
  String deviceData = "";
  String serialNo = "";
  Future<void> _fetchDeviceInfo() async {
    try {
      // if (Theme.of(context).platform == TargetPlatform.android) {
      final androidInfo = await deviceInfoPlugin.androidInfo;
      CustomLogger.info("androidInfo: $androidInfo");
      deviceData =
          'Android ${androidInfo.version.release} (SDK ${androidInfo.version.sdkInt}), '
          'Manufacturer: ${androidInfo.manufacturer}, Model: ${androidInfo.id}';
      CustomLogger.info("deviceData: $deviceData");
      serialNo = androidInfo.id;
      // } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      //   final iosInfo = await deviceInfoPlugin.iosInfo;
      //   deviceData =
      //       'iOS ${iosInfo.systemName} ${iosInfo.systemVersion}, '
      //       'Model: ${iosInfo.utsname.machine}';
      // } else {
      //   deviceData = 'Unsupported platform';
      // }
      CustomLogger.info('Device Info: $deviceData');
    } catch (e) {
      CustomLogger.info('Failed to get device info: $e');
    }
  }

  void _bindSim() async {
    String serverNumber = '+919370636502';
    if (serialNo == "") {
      Utils.showErrorSnackBar(
        context: context,
        message: 'Device ID cannot be empty',
      );
    } else {
      final bindMsg =
          'BIND SIM for app Device ID: $serialNo and SIM: ${_selectedSim?.cardId}';
      final smsUrl = Uri.parse('sms:$serverNumber?body=$bindMsg');
      if (await canLaunchUrl(smsUrl)) {
        launchUrl(smsUrl);
      } else {
        Utils.showErrorSnackBar(
          context: context,
          message: 'Could not launch SMS app',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select SIM'),
        leading: Container(width: 0),
        backgroundColor: Colors.blueAccent,
      ),
      body: BlocBuilder<SimBindingBloc, SimBindingState>(
        builder: (context, state) {
          if (state is SimBindingLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SimBindingSuccess) {
            final simCards = state.simData;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select a SIM to proceed:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: simCards.length,
                      itemBuilder: (context, index) {
                        final sim = simCards[index];
                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: Icon(
                              Icons.sim_card,
                              color: Colors.blueAccent,
                            ),
                            title: Text(
                              'SIM ${index + 1}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'Carrier: ${sim.carrierName}\n'
                              'Country: ${sim.countryCode}',
                            ),
                            trailing: Radio<SimDataModel>(
                              value: sim,
                              groupValue: _selectedSim,
                              onChanged: (SimDataModel? value) {
                                setState(() {
                                  _selectedSim = value;
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  if (_selectedSim != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          _bindSim();

                          await Future.delayed(const Duration(seconds: 3));

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Selected SIM: ${_selectedSim?.carrierName} \n Device Serial No: $serialNo',
                              ),
                            ),
                          );

                          context.pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Continue',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          } else if (state is SimBindingFailure) {
            return Center(
              child: Text(
                'Error: ${state.error}',
                style: TextStyle(color: Colors.red),
              ),
            );
          }
          return Center(child: Text('No SIM data available.'));
        },
      ),
    );
  }
}
