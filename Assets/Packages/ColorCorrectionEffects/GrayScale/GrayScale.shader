Shader "ImageEffect/GrayScale"
{
    Properties
    {
        [HideInInspector]
        _MainTex("Texture", 2D) = "white" {}

        [KeywordEnum(NORMAL, REC601, REC709)]
        _GrayScaleType("GrayScale Type", Int) = 0
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM

            #include "UnityCG.cginc"
            #include "Packages/com.xjine.color_correction_shader/ColorCorrection.cginc"

            #pragma vertex   vert_img
            #pragma fragment frag
            #pragma shader_feature _GRAYSCALETYPE_NORMAL _GRAYSCALETYPE_REC601 _GRAYSCALETYPE_REC709

            sampler2D _MainTex;

            fixed4 frag(v2f_img input) : SV_Target
            {
                float4 color = tex2D(_MainTex, input.uv);

                #ifdef _GRAYSCALETYPE_NORMAL

                return GrayScale(color);

                #elif _GRAYSCALETYPE_REC601

                return GrayScaleREC601(color);

                #else

                return GrayScaleREC709(color);

                #endif
            }

            ENDCG
        }
    }
}