package com.example.pigeon_typechannel;

import androidx.annotation.NonNull;

import github.penguin.reference.method_channel.ReferenceMessageCodec;
import github.penguin.reference.reference.InstanceConverter;
import github.penguin.reference.reference.InstanceManager;
import io.flutter.embedding.engine.plugins.FlutterPlugin;

/** PigeonTypechannelPlugin */
public class PigeonTypechannelPlugin implements FlutterPlugin {
  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    new ApiRegistrar(new ApiRegistrar.ApiImplementations(flutterPluginBinding.getTextureRegistry()),
        flutterPluginBinding.getBinaryMessenger(),
        new InstanceManager(),
        new ReferenceMessageCodec(),
        new InstanceConverter.StandardInstanceConverter()).setupApis();
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {

  }
}
