#ifndef COLOR_COLLECTION_INCLUDED
#define COLOR_COLLECTION_INCLUDED

float4 RgbToHsv(float4 rgb)
{
    const float4 K = float4(0, -0.3333333, 0.6666666, -1);

    float4 p = rgb.g < rgb.b ? float4(rgb.bg, K.wz) : float4(rgb.gb, K.xy);
    float4 q = rgb.r < p.x   ? float4(p.xyw, rgb.r) : float4(rgb.r, p.yzx);

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;

    return float4(abs(q.z + (q.w - q.y) / (6 * d + e)), d / (q.x + e), q.x, rgb.a);
}

float4 HsvToRgb(float4 hsv)
{
    const float4 K = float4(1, 0.6666666, 0.3333333, 3);

    float3 p = abs(frac(hsv.rrr + K.xyz) * 6 - K.www);

    return float4(hsv.z * lerp(K.xxx, clamp(p - K.xxx, 0, 1), hsv.y), hsv.a);
}

inline float2 RgbToHs(float4 rgb, float fmin, float fmax, float delta, float l)
{
    float2 hs;

    hs.y = l < 0.5 ? delta / (fmax + fmin)
                   : delta / (2 - fmax - fmin);

    delta = 1 / delta;

    float deltaR = (((fmax - rgb.r) * 0.1666666) + (delta * 0.5)) * delta;
    float deltaG = (((fmax - rgb.g) * 0.1666666) + (delta * 0.5)) * delta;
    float deltaB = (((fmax - rgb.b) * 0.1666666) + (delta * 0.5)) * delta;

    hs.x = rgb.r == fmax ? deltaB - deltaG
         : rgb.g == fmax ? 0.3333333 + deltaR - deltaB
         : rgb.b == fmax ? 0.6666666 + deltaG - deltaR
         : 0;

    hs.x = hs.x < 0 ? hs.x + 1
         : hs.x > 1 ? hs.x - 1
         : hs.x;

    return hs;
}

float4 RgbToHsl(float4 rgb)
{
    float4 hsl;

    float fmin = min(min(rgb.r, rgb.g), rgb.b);
    float fmax = max(max(rgb.r, rgb.g), rgb.b);
    float delta = fmax - fmin;

    hsl.z  = (fmax + fmin) * 0.5;
    hsl.xy = delta == 0 ? 0 : RgbToHs(rgb, fmin, fmax, delta, hsl.z);
    hsl.a  = rgb.a;

    return hsl;
}

inline float HueToRgb(float f1, float f2, float hue)
{
    hue = hue < 0 ? hue + 1
        : hue > 1 ? hue - 1
        : hue;

    return 6 * hue < 1 ? f1 + (f2 - f1) * 6 * hue
         : 2 * hue < 1 ? f2
         : 3 * hue < 2 ? f1 + (f2 - f1) * (0.6666666 - hue) * 6
         : f1;
}

float4 HslToRgb(float4 hsl)
{
    if(hsl.y == 0)
    {
        return hsl.z;
    }
    else
    {
        float f2 = hsl.z < 0.5 ? hsl.z * (1 + hsl.y)
                               : hsl.z + hsl.y - (hsl.y * hsl.z);
        float f1 = 2 * hsl.z - f2;

        float4 rgb;

        rgb.r = HueToRgb(f1, f2, hsl.x + 0.3333333);
        rgb.g = HueToRgb(f1, f2, hsl.x);
        rgb.b = HueToRgb(f1, f2, hsl.x - 0.3333333);
        rgb.a = hsl.a;

        return rgb;
    }
}

float4 HsvShift(float4 rgb, float4 shift)
{
    float4 hsv = RgbToHsv(rgb);

    hsv.xyz += shift.xyz * shift.w;

    return HsvToRgb(hsv);
}

float4 HslShift(float4 rgb, float4 shift)
{
    float4 hsl = RgbToHsl(rgb);

    hsl.xyz += shift.xyz * shift.w;

    return HslToRgb(hsl);
}

float4 GrayScale(float4 color)
{
    color.rgb = (color.r + color.g + color.b) * 0.333333f;

    return color;
}

float4 GrayScaleREC601(float4 color)
{
    const float3 LUMA = float3(0.298912f, 0.586611f, 0.114478f);

    color.rgb = dot(color.rgb, LUMA);

    return color;
}

float4 GrayScaleREC709(float4 color)
{
    const float3 LUMA = float3(0.2126f, 0.7152f, 0.0722f);

    color.rgb = dot(color.rgb, LUMA);

    return color;
}

float4 BrightnessSaturationContrast(float4 color, float brightness, float saturation, float contrast)
{
    const float3 ZERO_CONTRAST = float3(0.5, 0.5, 0.5);
    
    color = float4(color.rgb * brightness, color.a);

    float4 grayScale = GrayScaleREC709(color);
    
    color = lerp(grayScale, color, saturation);

    color.rgb = lerp(ZERO_CONTRAST, color.rgb, contrast);

    return color;
}

float4 ColorCollection(float4 color, float4 bscPrams, float4 hsvShift)
{
    color = BrightnessSaturationContrast(color, bscPrams.x, bscPrams.y, bscPrams.z);
    color = HsvShift(color, hsvShift);
    return color;
}

#endif // COLOR_COLLECTION_INCLUDED