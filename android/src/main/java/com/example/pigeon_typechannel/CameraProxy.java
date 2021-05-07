package com.example.pigeon_typechannel;

import android.hardware.Camera;

import io.flutter.view.TextureRegistry;

public class CameraProxy implements Messages.Camera {
  public final Camera camera;
  public final TextureRegistry textureRegistry;
  public TextureRegistry.SurfaceTextureEntry currentTextureEntry;

  public CameraProxy(TextureRegistry textureRegistry) {
    camera = Camera.open();
    this.textureRegistry = textureRegistry;
  }

  public void release() {
    camera.release();
  }

  public void startPreview() {
    camera.startPreview();
  }

  public void stopPreview() {
    camera.stopPreview();
  }

  public void setDisplayOrientation(Integer degrees) {
    camera.setDisplayOrientation(degrees);
  }

  public Long attachPreviewTexture() throws Exception {
    if (currentTextureEntry != null) return currentTextureEntry.id();

    currentTextureEntry = textureRegistry.createSurfaceTexture();
    camera.setPreviewTexture(currentTextureEntry.surfaceTexture());
    return currentTextureEntry.id();
  }

  public void releasePreviewTexture() throws Exception {
    if (currentTextureEntry == null) return;
    camera.setPreviewTexture(null);
    currentTextureEntry.release();
    currentTextureEntry = null;
  }
}
