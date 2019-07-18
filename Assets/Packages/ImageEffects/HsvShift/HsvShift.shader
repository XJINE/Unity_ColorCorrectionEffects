Shader "ImageEffect/HsvShift"
{
    Properties
    {
        [HideInInspector]
        _MainTex("Texture", 2D) = "white" {}
        _Shift("(Hue, Saturation, Value, Shift)", Vector) = (0, 0, 0, 1)
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM

            #include "UnityCG.cginc"
            #include "Assets/Packages/Shaders/ColorCollection.cginc"

            #pragma vertex vert_img
            #pragma fragment frag

            sampler2D _MainTex;
            float4 _Shift;

            fixed4 frag(v2f_img input) : SV_Target
            {
                return HsvShift(tex2D(_MainTex, input.uv), _Shift);
            }

            ENDCG
        }
    }
}