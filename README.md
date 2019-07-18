# Unity_ColorCollection

<img src="https://github.com/XJINE/Unity_ColorCollection/blob/master/Screenshot.png" width="100%" height="auto" />

``ColorCollection.cginc`` provides some functions for color collection.
And there are some ImageEffects of these.

## Import to Your Project

You can import this asset from UnityPackage.

- [ColorCollection.unitypackage](https://github.com/XJINE/Unity_ColorCollection/blob/master/ColorCollection.unitypackage)
- [ColorCollectionCginc.unitypackage](https://github.com/XJINE/Unity_ColorCollection/blob/master/ColorCollectionCginc.unitypackage)

``ColorCollectionCginc.unitypackage`` includes only ``ColorCollection.cginc`` file.

### Dependencies

You have to import following assets to use this asset.

- [Unity_ImageEffectBase](https://github.com/XJINE/Unity_ImageEffectBase)

## Functions

```hlsl
float4 RgbToHsv(float4 rgb)
float4 HsvToRgb(float4 hsv)
float4 RgbToHsl(float4 rgb)
float4 HslToRgb(float4 hsl)

float4 HsvShift(float4 rgb, float4 shift)
float4 HslShift(float4 rgb, float4 shift)

float4 GrayScale(float4 color)
float4 GrayScaleREC601(float4 color)
float4 GrayScaleREC709(float4 color)

float4 BrightnessSaturationContrast
(float4 color, float brightness, float saturation, float contrast)

float4 ColorCollection
(float4 color, float4 bscPrams, float4 hsvShift)
```