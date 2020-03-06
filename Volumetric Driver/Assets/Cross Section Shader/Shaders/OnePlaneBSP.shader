Shader "CrossSection/OnePlaneBSP" {
	Properties{
		_Color("Color", Color) = (1,1,1,1)
		_CrossColor("Cross Section Color", Color) = (1,1,1,1)
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_Glossiness("Smoothness", Range(0,1)) = 0.5
		_Metallic("Metallic", Range(0,1)) = 0.0
		_PlaneNormal("PlaneNormal",Vector) = (0,1,0,0)
		_PlanePosition("PlanePosition",Vector) = (0,0,0,1)
		_StencilMask("Stencil Mask", Range(0, 255)) = 255
		_SliceWidth("Slice Width", Range(0, 1)) = 0.5
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		//LOD 200
		Stencil
		{
			Ref [_StencilMask]
			CompBack Always
			PassBack Replace

			CompFront Always
			PassFront Zero
		}
		Cull Back

		
			
		
			CGPROGRAM
			// Physically based Standard lighting model, and enable shadows on all light types
			#pragma surface surf Standard fullforwardshadows

			// Use shader model 3.0 target, to get nicer looking lighting
	#pragma target 3.0

			sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;

			float3 worldPos;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;
		fixed4 _CrossColor;
		fixed3 _PlaneNormal;
		fixed3 _PlanePosition;
		float _SliceWidth;
		bool checkVisability(fixed3 worldPos)
		{
			
			float dotProd1 = dot(worldPos - _PlanePosition, _PlaneNormal);
            float dotProd2 = dot(worldPos - (_PlanePosition - fixed3 (0, _SliceWidth, 0)), _PlaneNormal);
			
			return dotProd1 > 0 || dotProd2 < 0;
		}
		void surf(Input IN, inout SurfaceOutputStandard o) {
			if (checkVisability(IN.worldPos))discard;
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;
		}
		ENDCG
		
			Cull Front
			CGPROGRAM
#pragma surface surf NoLighting  noambient

		struct Input {
			half2 uv_MainTex;
			float3 worldPos;

		};
		sampler2D _MainTex;
		fixed4 _Color;
		fixed4 _CrossColor;
		fixed3 _PlaneNormal;
		fixed3 _PlanePosition;
		float _SliceWidth;
		bool checkVisability(fixed3 worldPos)
		{
			float dotProd1 = dot(worldPos - _PlanePosition, _PlaneNormal);
			float dotProd2 = dot(worldPos - (_PlanePosition - fixed3 (0, _SliceWidth, 0)), _PlaneNormal);
			
			return dotProd1 > 0 || dotProd2 < 0;
		}
		fixed4 LightingNoLighting(SurfaceOutput s, fixed3 lightDir, fixed atten)
		{
			fixed4 c;
			c.rgb = s.Albedo;
			c.a = s.Alpha;
			return c;
		}

		void surf(Input IN, inout SurfaceOutput o)
		{
			if (checkVisability(IN.worldPos))discard;
			o.Albedo = _CrossColor;

		}
			ENDCG
		
		
		// Pass{
        //         CGPROGRAM
 
        //         #pragma vertex vert
        //         #pragma fragment frag
        //         #include "UnityCG.cginc"
 
        //         struct v2f {
        //             float4 pos : SV_POSITION;
		// 			fixed4 color : COLOR;
        //         };
 
        //         fixed4 _Color;

		// 		fixed3 _PlaneNormal;
		// 		fixed3 _PlanePosition;
		// 		float _SliceWidth;
		// 		bool checkVisability(fixed3 worldPos)
		// 		{
		// 			float dotProd1 = dot(worldPos - _PlanePosition, _PlaneNormal);
		// 			float dotProd2 = dot(worldPos - (_PlanePosition - fixed3 (0, _SliceWidth, 0)), _PlaneNormal);
			
		// 			return dotProd1 > 0 || dotProd2 < 0;
		// 		}
 
        //         v2f vert(appdata_base v)
        //         {
        //             v2f o;
		// 			o.pos = UnityObjectToClipPos(v.vertex);
					
		// 			o.color = fixed4(1.0, 1.0, 1.0, 1.0);
		// 			if (checkVisability(o.pos.xyz)){
		// 				o.pos = 0;
		// 				o.color = 0;
		// 			} else {
						 
        //             	o.pos.y -= o.pos.w / _ScreenParams.y * 0.5;
                    	
		// 			}
		// 			return o;
                    
        //         }
 
        //         fixed4 frag(v2f i) : SV_Target
        //         {
        //             return _Color;
        //         }

				

        //         ENDCG
        //     }

	}

	
	//FallBack "Diffuse"
}
