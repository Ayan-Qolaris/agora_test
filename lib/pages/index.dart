import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_test/pages/call.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final _channelController = TextEditingController();
  bool _validateError = false;
  ClientRole? _role = ClientRole.Broadcaster;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agora"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 40,
              ),
              TextField(
                controller: _channelController,
                decoration: InputDecoration(
                  errorText:
                      _validateError ? "Channel name is mandatory" : null,
                  hintText: "Channel name",
                ),
              ),
              const SizedBox(height: 30),
              RadioListTile(
                title: const Text("Broadcaster"),
                value: ClientRole.Broadcaster,
                groupValue: _role,
                onChanged: (ClientRole? value) {
                  setState(() {
                    _role = value;
                  });
                },
              ),
              RadioListTile(
                title: const Text("Audience"),
                value: ClientRole.Audience,
                groupValue: _role,
                onChanged: (ClientRole? value) {
                  setState(() {
                    _role = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: onJoin,
                child: const Text("Join"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onJoin() async {
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if (_channelController.text.isNotEmpty) {
      await _handleCameraAndMic(Permission.camera);
      await _handleCameraAndMic(Permission.microphone);
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CallPage(channelName: _channelController.text, role: _role),
          ),
        );
      }
    }
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final _status = await permission.request();
    log("status -> $_status");
  }

  @override
  void dispose() {
    _channelController.dispose();
    super.dispose();
  }
}
