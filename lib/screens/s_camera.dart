import 'dart:async';
import 'package:camera/camera.dart';
import 'package:do_it/screens/s_addpost.dart';
import 'package:do_it/screens/s_upload.dart';
import 'package:do_it/widgets/w_circleiconbutton.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:get/get.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({
    super.key,
    required this.cameras,
  });

  final List<CameraDescription> cameras;

  @override
  State<CameraScreen> createState() => _CameraScreen();
}

class _CameraScreen extends State<CameraScreen> {
  late CameraController _frontcontroller; // 카메라 제어하는데 사용
  late CameraController _rearcontroller;
  bool _isRealCameraSelected = true;
  double _currentScale = 1.0;
  double _baseScale = 1.0;
  bool _isFlashed = false;

  @override
  void initState() {
    super.initState();
    _rearcontroller = CameraController(
      widget.cameras[0],
      ResolutionPreset.ultraHigh,
    );

    _frontcontroller = CameraController(
      widget.cameras[1],
      ResolutionPreset.ultraHigh,
    );

    Future.wait([
      _frontcontroller.initialize(),
      _rearcontroller.initialize(),
    ]).then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _frontcontroller.dispose();
    _rearcontroller.dispose();

    super.dispose();
  }

  Future<void> _takePhotosSimultaneously() async {
    try {
      final image = await _rearcontroller.takePicture();

      if (!mounted) return;

      await Get.to(() => UploadScreen(imagePath: image.path));
    } catch (e) {
      return;
    }
  }

  void _switchCamera() {
    if (_isRealCameraSelected) {
      setState(() => _isRealCameraSelected = !_isRealCameraSelected);
      _rearcontroller = CameraController(
        widget.cameras[1],
        ResolutionPreset.ultraHigh,
      );
      _frontcontroller = CameraController(
        widget.cameras[0],
        ResolutionPreset.ultraHigh,
      );
    } else {
      setState(() => _isRealCameraSelected = !_isRealCameraSelected);
      _rearcontroller = CameraController(
        widget.cameras[0],
        ResolutionPreset.ultraHigh,
      );
      _frontcontroller = CameraController(
        widget.cameras[1],
        ResolutionPreset.ultraHigh,
      );
    }
    Future.wait([
      _frontcontroller.initialize(),
      _rearcontroller.initialize(),
    ]).then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  Future<void> turnFlashOn() async {
    await _rearcontroller.setFlashMode(FlashMode.torch);
  }

  Future<void> turnFlashOff() async {
    await _rearcontroller.setFlashMode(FlashMode.off);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _frontcontroller.value.isInitialized &&
              _rearcontroller.value.isInitialized
          ? Stack(
              children: [
                SizedBox(
                  // 후면 카메라 프리뷰 크기 설정
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: GestureDetector(
                    onScaleStart: (details) {
                      _baseScale = _currentScale;
                    },
                    onScaleUpdate: (details) {
                      setState(() {
                        _currentScale = math.max(
                          1.0,
                          math.min(_baseScale * details.scale, 5.0),
                        );
                      });
                    },
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..scale(_currentScale),
                      child: CameraPreview(_rearcontroller),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  child: Container(
                    height: 120,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                Positioned(
                  top: 60,
                  child: IconButton(
                    onPressed: () {
                      Get.to(() => const AddpostScreen(),
                          transition: Transition.fade);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.black.withOpacity(0.5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 10),
                        CircleIconButton(
                          backgroundcolor: Colors.grey,
                          size: 30,
                          icon: _isFlashed ? Icons.flash_on : Icons.flash_off,
                          onPressed: () {
                            if (!_isFlashed) {
                              setState(() {
                                _isFlashed = !_isFlashed;
                                turnFlashOn();
                              });
                            } else {
                              setState(() {
                                _isFlashed = !_isFlashed;
                                turnFlashOff();
                              });
                            }
                          },
                        ),
                        CircleIconButton(
                          backgroundcolor: Colors.grey,
                          size: 60,
                          icon: Icons.camera,
                          onPressed: _takePhotosSimultaneously,
                        ),
                        CircleIconButton(
                          backgroundcolor: Colors.grey,
                          size: 30,
                          icon: Icons.refresh_rounded,
                          onPressed: _switchCamera,
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Container(
              color: Colors.black,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
    );
  }
}
