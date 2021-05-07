package com.example.pigeon_typechannel;

import github.penguin.reference.method_channel.ReferenceMessageCodec;
import github.penguin.reference.reference.InstanceConverter.StandardInstanceConverter;
import github.penguin.reference.reference.InstanceManager;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.view.TextureRegistry;

public class ApiRegistrar {
  public final ApiImplementations implementations;
  public final BinaryMessenger binaryMessenger;
  public final InstanceManager instanceManager;
  public final ReferenceMessageCodec messageCodec;
  public final StandardInstanceConverter instanceConverter;

  public static class ApiImplementations {
    public final TextureRegistry textureRegistry;

    public ApiImplementations(TextureRegistry textureRegistry) {
      this.textureRegistry = textureRegistry;
    }

    public Messages.$CameraApi getCameraApi() {
      return new CameraApi(textureRegistry);
    }
  }

  public static class CameraApi implements Messages.$CameraApi {
    public final TextureRegistry textureRegistry;

    public CameraApi(TextureRegistry textureRegistry) {
      this.textureRegistry = textureRegistry;
    }

    @Override
    public Messages.Camera $create() {
      return new CameraProxy(textureRegistry);
    }

    @Override
    public void release(Messages.Camera camera) {
      ((CameraProxy) camera).release();
    }

    @Override
    public void startPreview(Messages.Camera camera) {
      ((CameraProxy) camera).startPreview();
    }

    @Override
    public void stopPreview(Messages.Camera camera) {
      ((CameraProxy) camera).stopPreview();
    }

    @Override
    public void setDisplayOrientation(Messages.Camera camera, int degrees) {
      ((CameraProxy) camera).setDisplayOrientation(degrees);
    }

    @Override
    public int attachPreviewTexture(Messages.Camera camera) throws Exception {
      return ((CameraProxy) camera).attachPreviewTexture().intValue();
    }

    @Override
    public void releasePreviewTexture(Messages.Camera camera) throws Exception {
      ((CameraProxy) camera).releasePreviewTexture();
    }
  }

  public ApiRegistrar(ApiImplementations implementations, BinaryMessenger binaryMessenger, InstanceManager instanceManager, ReferenceMessageCodec messageCodec, StandardInstanceConverter instanceConverter) {
    this.implementations = implementations;
    this.binaryMessenger = binaryMessenger;
    this.instanceManager = instanceManager;
    this.messageCodec = messageCodec;
    this.instanceConverter = instanceConverter;
  }

  public void setupApis() {
    Messages.$CameraApi.setup(binaryMessenger, instanceManager, messageCodec, instanceConverter, implementations.getCameraApi());
  }

  public void removeApis() {
    Messages.$CameraApi.setup(binaryMessenger, instanceManager, messageCodec, instanceConverter, null);
  }
}
