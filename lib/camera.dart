import 'package:pigeon_typechannel/messages.dart' as pig;

class Camera implements pig.Camera {
  /// Default constructor for [Camera].
  ///
  /// This should only be used when subclassing or testing. Otherwise, an
  /// instance should be provided from [open].
  Camera({pig.$CameraApi? cameraApi})
      : _cameraApi = cameraApi ?? pig.$CameraApi() {
    _cameraApi.$create(true, this);
  }

  final pig.$CameraApi _cameraApi;

  int? _currentTexture;

  /// Disconnects and releases the [Camera] object resources.
  ///
  /// You must call this as soon as you're done with the [Camera] object.
  Future<void> release() => _cameraApi.release(this);

  /// Starts capturing and drawing preview frames to the screen.
  ///
  /// Preview will not actually start until a texture is supplied with
  /// [attachPreviewTexture].
  Future<void> startPreview() => _cameraApi.startPreview(this);

  /// Stops capturing and drawing preview frames to the surface.
  ///
  /// Resets the camera for a future call to [startPreview].
  Future<void> stopPreview() => _cameraApi.stopPreview(this);

  Future<int> attachPreviewTexture() async {
    return _currentTexture ??= (await _cameraApi.attachPreviewTexture(this))!;
  }

  Future<void> releasePreviewTexture() {
    _currentTexture = null;
    return _cameraApi.releasePreviewTexture(this);
  }

  Future<void> setDisplayOrientation(int degrees) {
    return _cameraApi.setDisplayOrientation(this, degrees);
  }
}
