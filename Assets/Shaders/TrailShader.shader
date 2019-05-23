Shader "Custom/TrailShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
		_LowStartColor ("Low Start Color", Color) = (1, 0, 0, 1)
		_LowEndColor ("Low End Color", Color) = (1, 1, 1, 1)
		_HighStartColor("High Start Color", Color) = (1, 0, 0, 1)
		_HighEndColor("High End Color", Color) = (1, 1, 1, 1)
		_LerpValue("Lerp Value", Float) = 0
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
                //Define UV data
				float3 uv : TEXCOORD0;
            };

            struct v2f
            {   
                float4 vertex : SV_POSITION;
                //Define UV data
				float3 uv : TEXCOORD0;
            };

            sampler2D _MainTex;
			float4 _LowStartColor;
			float4 _LowEndColor;
			float4 _HighStartColor;
			float4 _HighEndColor;
			float _LerpValue;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv; //Correct this for particle shader
             
                return o;
            }

			float4 frag(v2f i) : SV_Target
			{
				float2 uv = i.uv.xy;
				//Get particle age percentage
				float agePercent = i.uv.z;

				//Sample color from particle texture
				float4 texColor = tex2D(_MainTex, uv);
				//Find "start color"
				float4 sColor = texColor * lerp(_LowStartColor, _HighStartColor, _LerpValue);
				//Find "end color"
				float4 eColor = texColor * lerp(_LowEndColor, _HighEndColor, _LerpValue);

				//Do a linear interpolation of start color and end color based on particle age percentage
				float4 color = lerp(sColor, eColor, agePercent);
				return color;
            }
            ENDCG
        }
    }
}
