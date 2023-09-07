import 'package:camera/camera.dart';
import 'package:do_it/screens/s_addpost.dart';
import 'package:do_it/widgets/w_circleiconbutton.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:get/get.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
    required this.cameras,
  });

  final List<CameraDescription> cameras;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _frontcontroller; // 카메라 제어하는데 사용
  late CameraController _rearcontroller;
  bool _isRealCameraSelected = true;
  double _currentScale = 1.0;
  double _baseScale = 1.0;
  bool _isFlashed = false;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _rearcontroller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.cameras[0],
      // Define the resolution to use.
      ResolutionPreset.ultraHigh,
    );

    _frontcontroller = CameraController(
      widget.cameras[1],
      ResolutionPreset.ultraHigh,
    );

    // Next, initialize the controller. This returns a Future.
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
      // Ensure that the camera is initialized.
      // Attempt to take a picture and get the file `image`
      // where it was saved.
      final rearimage = await _rearcontroller.takePicture();

      if (!mounted) return;

      // If the picture was taken, display it on a new screen.
      Get.to(() => const AddPostScreen());
    } catch (e) {
      // If an error occurs, log the error to the console.
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
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: _frontcontroller.value.isInitialized &&
              _rearcontroller.value.isInitialized
          // If the Future is complete, display the preview.
          ? Stack(
              children: [
                SizedBox(
                  // 후면 카메라 프리뷰 크기 설정
                  width: Get.width,
                  height: Get.height,
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
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
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
                          backgroundcolor: const Color(0xff3B3B3B),
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
                            backgroundcolor: const Color(0xff3B3B3B),
                            size: 60,
                            icon: Icons.camera,
                            onPressed: _takePhotosSimultaneously),
                        CircleIconButton(
                            backgroundcolor: const Color(0xff3B3B3B),
                            size: 30,
                            icon: Icons.refresh_rounded,
                            onPressed: _switchCamera),
                        const SizedBox(width: 10)
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
