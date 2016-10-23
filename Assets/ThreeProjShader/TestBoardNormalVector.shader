Shader "Custom/TestBoardNormalVector" {
	Properties {
//		_Color ("Color", Color) = (1,1,1,1)
	}
	SubShader {
		Pass{
			Tags { "RenderType"="Opaque" }
			LOD 200
			
			CGPROGRAM
			// Physically based Standard lighting model, and enable shadows on all light types
			#pragma vertex vert
			#pragma fragment frag

			struct vertexInput {
				float4 vertex:POSITION;
				float3 normal:NORMAL;
				float4 texcoord:TEXCOORD0;
			};
			struct vertexOutput{
				float4 objectPosition:TEXCOORD1;
				float4 pos:SV_POSITION;
				float3 normalDirection:TEXCOORD2;
				float4 tex:TEXCOORD3;
			};

			vertexOutput vert(vertexInput v) {
				vertexOutput o;
				o.normalDirection=mul(unity_ObjectToWorld,v.normal);
				//o.normalDirection=v.normal;
				o.objectPosition=v.vertex;
				o.pos=mul(UNITY_MATRIX_MVP,v.vertex);
				o.tex=v.texcoord;
				return o;	
			}

			float4 frag(vertexOutput i):COLOR {
				float3 nor = i.normalDirection;
				return float4(nor.x, nor.y, nor.z, 1);
			}

			ENDCG
		}
	}
	FallBack "Diffuse"
}
