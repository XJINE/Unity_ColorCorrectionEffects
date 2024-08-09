Shader "ImageEffect/ColorCorrection"
{
    Properties
    {
        [HideInInspector]
        _MainTex  ("Texture",                               2D    ) = "white" {}
        _BscParams("(Brightness, Saturation, Contrast, _)", Vector) = (1, 1, 1, 0)
        _HsvShift ("(Hue, Saturation, Value, Shift)",       Vector) = (0, 0, 0, 1)
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM

            #include "UnityCG.cginc"
            #include "Packages/com.xjine.color_correction_shader/ColorCorrection.cginc"

            #pragma vertex vert_img
            #pragma fragment frag

            sampler2D _MainTex;

            float4 _BscParams;
            float4 _HsvShift;

            fixed4 frag(v2f_img input) : SV_Target
            {
                return ColorCorrection(tex2D(_MainTex, input.uv), _BscParams, _HsvShift);
            }

            ENDCG
        }
    }
}