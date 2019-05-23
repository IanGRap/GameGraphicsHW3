Shader "Custom/ParticleShader"
{
    Properties
    {
        _Color("Color", color) = (0, 0, 0, 0)
    }
    SubShader
    {
        Tags {"Queue"="Transparent" "RenderType"="Opaque" }
        LOD 100
        
        Blend One One
        ZWrite off
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            struct appdata
            {
                float4 vertex : POSITION;
            };

            struct v2f
            {   
                float4 vertex : SV_POSITION;
            };

			float4 _Color;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                return o;
            }

			float4 frag(v2f i) : SV_Target
			{
				return _Color;
            }
            ENDCG
        }
    }
}
