Shader "Custom/LineShader" {
	Properties {
		_VoidColor ("VoidColor", Color) = (1,0,0,1)
		_RimColor("RimColor", Color) = (1,0,0,1)
		_RimAngleThreod ("RimAngleThreod",Float) = 1
		_Shiness("Shiness", Float) = 1
		//entity line border style
		[Toggle] _IsCloseSharp("IsCloseSharp", Float) = 0
		
		_Entity ("Entity", 2D) = "white"{}
		//xu xian feng ge
		_False ("False", 2D) = "white"{}
		//wu xian feng geng ge
	}
	SubShader {
		Pass{
			Tags { "RenderType"="Opaque" }
			LOD 200
			Cull off

			CGPROGRAM
			// Physically based Standard lighting model, and enable shadows on all light types
			#pragma vertex vert
			#pragma fragment frag

			uniform sampler2D _Entity;
			uniform sampler2D _False;

			uniform float _IsCloseSharp;
			uniform float4 _Entity_ST;
			uniform float4 _False_ST;

			uniform float4 _VoidColor;
			uniform float _RimAngleThreod;
			uniform float4 _RimColor;

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

			float4 frag(vertexOutput i): COLOR {
				float3 normalDirection=normalize(i.normalDirection);	
				float3 viewDirection=normalize(_WorldSpaceCameraPos.xyz-mul(unity_ObjectToWorld,i.objectPosition).xyz);	
				float doCos = dot(viewDirection, normalDirection);
				float cosRadian = acos(doCos);//[0, pi]
				float cosAngle = cosRadian * 180 / 3.1415926;
				//1. view rim with Entity style and return
				if(90 - _RimAngleThreod < cosAngle && cosAngle < 90){// + _RimAngleThreod){
					return _RimColor;//float4(1,0,0,1);
				}
//				float tmpValue = _IsCloseSharp;
//				if(cosAngle == 1.0f) {
//					discard;
//				}

				float4 texColor;

				//2. yellow -> discard todo
				//3. need board
				bool isBackSide = doCos < 0;

				if(isBackSide) {
					texColor = tex2D(_False, i.tex.xy *  _False_ST.xy + _False_ST.zw);
				} else {
					texColor = tex2D(_Entity, i.tex.xy * _Entity_ST.xy + _Entity_ST.zw);
				}

				if(_IsCloseSharp == 1.0f || texColor.x > 0.5f) {
					discard;
				}

				return texColor;
			}

			ENDCG
		}
	}
	FallBack "Diffuse"
}
