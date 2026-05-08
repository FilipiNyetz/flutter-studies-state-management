import 'package:flutter/material.dart';
import 'package:state_flow_base/logs_header.dart';
import 'package:state_flow_base/traffic_light.dart';
import 'card_logs.dart';

enum TrafficLightOptions { green, yellow, red }

class StatusLog {
  DateTime logDate;
  TrafficLightOptions logState;

  StatusLog(this.logDate, this.logState);
}

class StateFlowApp extends StatefulWidget {
  const StateFlowApp({super.key});

  @override
  State<StateFlowApp> createState() => _StateFlowAppState();
}

class _StateFlowAppState extends State<StateFlowApp> {
  TrafficLightOptions currentLight = TrafficLightOptions.green;
  List<StatusLog> statusLog = [];

  static const _green = Color(0xFF3DFF8F);
  static const _yellow = Color(0xFFFFD93D);
  static const _red = Color(0xFFFF4D4D);

  Color get _currentColor {
    switch (currentLight) {
      case .green:
        return _green;
      case .yellow:
        return _yellow;
      case .red:
        return _red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        title: const Text(
          "STATEFLOW",
          style: TextStyle(
            color: Color(0xFF888888),
            fontSize: 13,
            fontWeight: FontWeight.w500,
            letterSpacing: 3,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32),
              decoration: BoxDecoration(
                color: const Color(0xFF111111),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFF222222)),
              ),
              child: Column(
                children: [
                  // Lights
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D0D0D),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFF1E1E1E)),
                    ),
                    child: Column(
                      children: [
                        TrafficLight(color: _red, active: currentLight == .red),
                        const SizedBox(height: 16),
                        TrafficLight(
                          color: _yellow,
                          active: currentLight == .yellow,
                        ),
                        const SizedBox(height: 16),
                        TrafficLight(
                          color: _green,
                          active: currentLight == .green,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: TextStyle(
                      color: _currentColor,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.5,
                    ),
                    child: Text(currentLight.name),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "ESTADO ATUAL",
                    style: TextStyle(
                      color: Color(0xFF444444),
                      fontSize: 11,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    switch (currentLight) {
                      case .green:
                        currentLight = .yellow;
                      case .yellow:
                        currentLight = .red;
                      case .red:
                        currentLight = .green;
                    }

                    statusLog.add(StatusLog(DateTime.now(), currentLight));
                  });
                },
                child: const Text(
                  "Avançar sinal",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
            ),

            const SizedBox(height: 24),

            LogsHeader(statusLog: statusLog),

            const SizedBox(height: 10),
            Expanded(
              child: statusLog.isEmpty
                  ? const Center(
                      child: Text(
                        "Nenhuma alteração ainda",
                        style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 13,
                        ),
                      ),
                    )
                  : ListView.builder(
                      reverse: true,
                      itemCount: statusLog.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CardLogs(statusLog: statusLog[index]),
                        );
                      },
                    ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
