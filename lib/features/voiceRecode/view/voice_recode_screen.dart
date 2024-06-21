import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';


class VoiceRecodeScreen extends StatefulWidget {
  @override
  _VoiceRecodeScreenState createState() => _VoiceRecodeScreenState();
}

class _VoiceRecodeScreenState extends State<VoiceRecodeScreen> {
  FlutterSoundRecorder? _recorder;
  FlutterSoundPlayer? _player;
  bool _isRecording = false;
  bool _isPlaying = false;
  String _path = 'audio_recording.aac';

  @override
  void initState() {
    super.initState();
    _recorder = FlutterSoundRecorder();
    _player = FlutterSoundPlayer();
    _openAudioSession();
  }

  Future<void> _openAudioSession() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }
    await _recorder!.openRecorder();
    await _player!.openPlayer();
  }

  @override
  void dispose() {
    _recorder!.closeRecorder();
    _player!.closePlayer();
    _recorder = null;
    _player = null;
    super.dispose();
  }

  Future<void> _startRecording() async {
    await _recorder!.startRecorder(
      toFile: _path,
      codec: Codec.aacADTS,
    );
    setState(() {
      _isRecording = true;
    });
  }

  Future<void> _stopRecording() async {
    await _recorder!.stopRecorder();
    setState(() {
      _isRecording = false;
    });
  }

  Future<void> _startPlaying() async {
    await _player!.startPlayer(
      fromURI: _path,
      codec: Codec.aacADTS,
      whenFinished: () {
        setState(() {
          _isPlaying = false;
        });
      },
    );
    setState(() {
      _isPlaying = true;
    });
  }

  Future<void> _stopPlaying() async {
    await _player!.stopPlayer();
    setState(() {
      _isPlaying = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Recorder'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _isRecording ? _stopRecording : _startRecording,
              child: Text(_isRecording ? 'Stop Recording' : 'Start Recording'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isPlaying ? _stopPlaying : _startPlaying,
              child: Text(_isPlaying ? 'Stop Playing' : 'Start Playing'),
            ),
          ],
        ),
      ),
    );
  }
}
