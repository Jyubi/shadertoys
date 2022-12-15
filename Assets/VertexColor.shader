Shader "Unlit/VertexColor"
{
    Properties
    {
        _RedTex ("Color Red", 2D) = "red" {}
        _BlueTex ("Color Blue", 2D) = "blue" {}
        _GreenTex ("Color Green", 2D) = "green" {}
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                
                float4 color : COLOR;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
                
                fixed4 color : COLOR;
            };

            sampler2D _MainTex;
            sampler2D _RedTex;
            sampler2D _BlueTex;
            sampler2D _GreenTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);

                o.color = v.color;
                
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 redCol = tex2D(_RedTex, i.uv);
                redCol *= i.color.r;
                fixed4 greenCol = tex2D(_GreenTex, i.uv);
                greenCol *= i.color.g;
                fixed4 blueCol = tex2D(_BlueTex, i.uv);
                blueCol *= i.color.b;
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return redCol+greenCol+blueCol;
            }
            ENDCG
        }
    }
}
