Shader "learn/2_colorWarp"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _NoiseTex ("Texture", 2D) = "white" {}
        _Color ("Color", COLOR) = (1,1,1,1)
        _Intensity ("Warp Intensity", FLOAT) = 0.5
        //_Direction ("Direction", VECTOR) = (1,1,1)
        
        //TODO: implement later
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
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };
            //
            sampler2D _MainTex;
            sampler2D _NoiseTex;
            //float4 _NoiseTex;
            float _Intensity;
            float4 _Color;
            float4 _MainTex_ST;
            float2 _Direction;
            //
            
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);


                
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                _Direction = float2(1,0.05) * _Time;

                fixed2 noise;
                noise.x = tex2D(_NoiseTex, i.uv + float2(1,0) * _Time).r;
                noise.y = tex2D(_NoiseTex, i.uv + float2(0,0.1) * _Time).g;

                fixed4 col = tex2D(_MainTex, i.uv+ (noise * _Intensity)) * _Color;
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;// * /*(noise1.r +*/ noise2.r;
            }
            ENDCG
        }
    }
}
