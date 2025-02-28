import 'dart:async';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:foxShop/core/constants/app_colors.dart';
import 'package:foxShop/core/constants/app_enum.dart';
import 'package:foxShop/core/constants/app_icons.dart';
import 'package:foxShop/core/constants/app_size_config.dart';
import 'package:foxShop/core/di/injection.dart';
import 'package:foxShop/core/helper/audio_processor.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/core/utils/app_format.dart';
import 'package:foxShop/presentation/widgets/icon_widget.dart';
import 'package:foxShop/presentation/widgets/text_widget.dart';
import 'package:path_provider/path_provider.dart';

class VoiceMessageBubble extends StatefulWidget {
  const VoiceMessageBubble({
    super.key,
    required this.url,
    required this.timestamp,
    required this.isRead,
    required this.type,
  });
  final String url;
  final String timestamp;
  final bool isRead;
  final BubbleType type;

  @override
  State<VoiceMessageBubble> createState() => _VoiceMessageBubbleState();
}

class _VoiceMessageBubbleState extends State<VoiceMessageBubble> {
  late PlayerController _playerController;
  StreamSubscription<FileResponse>? _streamSubscription;
  StreamSubscription<int>? _progressSubscription; // Track progress
  late AudioProcessor _audioProcessor;
  final _isLoading = ValueNotifier<bool>(true);
  String? _filePath;
  final _maxDuration = ValueNotifier<int>(1);
  final _currentDuration = ValueNotifier<int>(0);
  final _currentPosition = ValueNotifier<int>(0);
  final _waveformData = ValueNotifier<List<double>>([]);
  final _isPlaying = ValueNotifier<bool>(false);
  final style = PlayerWaveStyle(
    liveWaveColor: appWhite,
    spacing: 5.scale,
    waveThickness: 2.5.scale,
    scaleFactor: 70.scale,
  );

  @override
  void initState() {
    super.initState();
    _playerController = PlayerController();
    _audioProcessor = AudioProcessor();
    _playerController.updateFrequency = UpdateFrequency.high;

    _cacheAndPrepareAudio();
  }

  Future<String> _getTemporaryPath() async {
    final tempDir = await getTemporaryDirectory();
    return tempDir.path;
  }

  void _cacheAndPrepareAudio() async {
    final tempPath = await _getTemporaryPath();
    final fileName = widget.url.split('/').last;
    final newFilePath = '$tempPath/$fileName';

    // Fetch the audio file from cache manager
    final file = await di.get<BaseCacheManager>().getSingleFile(widget.url);

    // Copy the cached file to a temporary directory
    await file.copy(newFilePath);

    if (File(newFilePath).existsSync()) {
      _filePath = newFilePath;

      // Prepare the player with the valid file path
      final samples =
          style.getSamplesForWidth((AppSizeConfig.screenWidth * 0.5) / 2);

      //
      await _playerController.preparePlayer(
          path: _filePath!, noOfSamples: samples);
      _maxDuration.value = _playerController.maxDuration;
      _isLoading.value = false;
      _waveformData.value =
          await _playerController.extractWaveformData(path: _filePath!);
    }
  }

  void _playPauseAudio() async {
    if (_playerController.playerState.isPlaying) {
      await _playerController.pausePlayer();
      _isPlaying.value = false;
    } else if (_playerController.playerState.isPaused) {
      await _playerController.seekTo(_currentPosition.value);
      await _playerController.startPlayer();
      _isPlaying.value = true;
    } else if (_playerController.playerState.isStopped) {
      await _playerController.seekTo(0);
      await _playerController.startPlayer();
      _isPlaying.value = true;
    } else {
      await _playerController.startPlayer();
      _isPlaying.value = true;
      _progressSubscription =
          _playerController.onCurrentDurationChanged.listen((duration) {
        _currentPosition.value = duration;
        _currentDuration.value = duration;
      });
    }
  }

  @override
  void dispose() {
    _playerController.dispose();
    _streamSubscription?.cancel();
    _progressSubscription?.cancel();
    _audioProcessor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: AppSizeConfig.screenWidth * 0.75),
      child: Card(
        color: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.scale),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.scale),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: GestureDetector(
              onTap: () => _playPauseAudio(),
              child: ValueListenableBuilder(
                valueListenable: _isLoading,
                builder: (context, value, child) {
                  return CircleAvatar(
                    child: value
                        ? CircularProgressIndicator(color: appWhite)
                        : ValueListenableBuilder(
                            valueListenable: _isPlaying,
                            builder: (context, isPlaying, child) {
                              return Icon(
                                isPlaying
                                    ? Icons.pause_rounded
                                    : Icons.play_arrow_rounded,
                                color: appWhite,
                              );
                            },
                          ),
                  );
                },
              ),
            ),
            title: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.scale),
              child: ValueListenableBuilder(
                valueListenable: _waveformData,
                builder: (context, waveformData, child) {
                  return AudioFileWaveforms(
                    key: ValueKey(_playerController.playerKey),
                    waveformData: waveformData,
                    size: Size(AppSizeConfig.screenWidth * 0.5, 25.scale),
                    playerController: _playerController,
                    enableSeekGesture: true,
                    // continuousWaveform: false,
                    waveformType: WaveformType.fitWidth,
                    playerWaveStyle: style,
                  );
                },
              ),
            ),
            subtitle: Row(
              spacing: 5.scale,
              children: [
                Row(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: _currentDuration,
                      builder: (context, currentDuration, child) {
                        return TextWidget(
                          text: "${AppFormat.formatDuration(currentDuration)} ",
                          color: widget.type == BubbleType.sendBubble
                              ? appWhite
                              : appBlack,
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: _maxDuration,
                      builder: (context, maxDuration, child) {
                        return TextWidget(
                          text: "/ ${AppFormat.formatDuration(maxDuration)}",
                          color: widget.type == BubbleType.sendBubble
                              ? appWhite
                              : appBlack,
                        );
                      },
                    )
                  ],
                ),
                Spacer(),
                TextWidget(
                  text: widget.timestamp,
                  color: widget.type == BubbleType.sendBubble
                      ? appWhite
                      : appBlack,
                ),
                IconWidget(
                  assetName: widget.isRead ? checkReadSvg : checkSvg,
                  colorFilter: ColorFilter.mode(
                    widget.type == BubbleType.sendBubble ? appWhite : appBlack,
                    BlendMode.srcIn,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
