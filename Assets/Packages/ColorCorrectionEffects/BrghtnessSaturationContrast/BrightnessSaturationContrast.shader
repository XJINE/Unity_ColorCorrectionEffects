Shader "ImageEffect/BrghtnessSaturationContrast"
{
    Properties
    {
        [HideInInspector]
        _MainTex("Texture", 2D) = "white" {}
        _Params("(Brightness, Saturation, Contrast, _)", Vector) = (1, 1, 1, 0)
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
            float4 _Params;

            fixed4 frag(v2f_img input) : SV_Target
            {
                float4 color = tex2D(_MainTex, input.uv);
                return BrightnessSaturationContrast(color, _Params.x, _Params.y, _Params.z);
            }

            ENDCG
        }
    }
}