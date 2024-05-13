// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Unlit/Fireball"
{
	Properties
	{
		_Lava_Tex("Lava_Tex", 2D) = "white" {}
		_Ground_Tex("Ground_Tex", 2D) = "white" {}
		_Tilling("Tilling", Float) = 1
		_Main_Color("Main_Color", Color) = (0.6037736,0.240491,0,0)
		_Add_Color("Add_Color", Color) = (0.9811321,0.9789501,0,0)
		_Twirl_Speed("Twirl_Speed", Float) = 0.18
		_Twirl_Strength("Twirl_Strength", Float) = -1.36
		_Blink_Speed("Blink_Speed", Float) = 3
		_Frensel_Color("Frensel_Color", Color) = (0.3632075,0.6126482,1,0)
		_Frensel_Scale("Frensel_Scale", Float) = 0.61
		_Frensel_Power("Frensel_Power", Float) = 2.13
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
		};

		uniform sampler2D _Lava_Tex;
		uniform float _Tilling;
		uniform float _Twirl_Strength;
		uniform float _Twirl_Speed;
		uniform float4 _Add_Color;
		uniform float4 _Main_Color;
		SamplerState sampler_Lava_Tex;
		uniform float _Blink_Speed;
		uniform sampler2D _Ground_Tex;
		SamplerState sampler_Ground_Tex;
		uniform float4 _Frensel_Color;
		uniform float _Frensel_Scale;
		uniform float _Frensel_Power;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 temp_cast_0 = (_Tilling).xx;
			float2 uv_TexCoord3 = i.uv_texcoord * temp_cast_0;
			float2 center45_g6 = float2( 0.5,0.5 );
			float2 delta6_g6 = ( uv_TexCoord3 - center45_g6 );
			float angle10_g6 = ( length( delta6_g6 ) * _Twirl_Strength );
			float x23_g6 = ( ( cos( angle10_g6 ) * delta6_g6.x ) - ( sin( angle10_g6 ) * delta6_g6.y ) );
			float2 break40_g6 = center45_g6;
			float mulTime14 = _Time.y * _Twirl_Speed;
			float2 temp_cast_1 = (mulTime14).xx;
			float2 break41_g6 = temp_cast_1;
			float y35_g6 = ( ( sin( angle10_g6 ) * delta6_g6.x ) + ( cos( angle10_g6 ) * delta6_g6.y ) );
			float2 appendResult44_g6 = (float2(( x23_g6 + break40_g6.x + break41_g6.x ) , ( break40_g6.y + break41_g6.y + y35_g6 )));
			float4 tex2DNode1 = tex2D( _Lava_Tex, appendResult44_g6 );
			float mulTime19 = _Time.y * _Blink_Speed;
			float4 lerpResult26 = lerp( _Add_Color , _Main_Color , ( tex2DNode1.a * (0.0 + (sin( mulTime19 ) - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)) ));
			float4 tex2DNode29 = tex2D( _Ground_Tex, uv_TexCoord3 );
			float4 lerpResult32 = lerp( ( tex2DNode1 + lerpResult26 ) , tex2DNode29 , tex2DNode29.a);
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float fresnelNdotV38 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode38 = ( 0.0 + _Frensel_Scale * pow( 1.0 - fresnelNdotV38, _Frensel_Power ) );
			float4 lerpResult39 = lerp( lerpResult32 , _Frensel_Color , fresnelNode38);
			o.Emission = lerpResult39.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18500
1920;-91;1920;1138;1991.155;1200.997;2.651267;True;False
Node;AmplifyShaderEditor.RangedFloatNode;35;-1248.51,-299.9175;Inherit;False;Property;_Tilling;Tilling;2;0;Create;True;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-1279,59;Inherit;False;Property;_Twirl_Speed;Twirl_Speed;5;0;Create;True;0;0;False;0;False;0.18;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-941.0057,553.8661;Inherit;False;Property;_Blink_Speed;Blink_Speed;7;0;Create;True;0;0;False;0;False;3;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;19;-771.8038,557.4839;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-1028,-324;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;11;-1134,-81;Inherit;False;Property;_Twirl_Strength;Twirl_Strength;6;0;Create;True;0;0;False;0;False;-1.36;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;14;-1050,45;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;20;-576.805,559.2838;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;10;-778,-130;Inherit;True;Twirl;-1;;6;90936742ac32db8449cd21ab6dd337c8;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;4;FLOAT2;-1.08,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1;-480.4839,-164.5938;Inherit;True;Property;_Lava_Tex;Lava_Tex;0;0;Create;True;0;0;False;0;False;-1;None;8117d30f00f956b44bebc8b3ba30d9d5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;21;-453.4716,546.8336;Inherit;True;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;27;-162.5578,251.4997;Inherit;False;Property;_Add_Color;Add_Color;4;0;Create;True;0;0;False;0;False;0.9811321,0.9789501,0,0;1,0.3490932,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;23;-147.8236,65.07495;Inherit;False;Property;_Main_Color;Main_Color;3;0;Create;True;0;0;False;0;False;0.6037736,0.240491,0,0;1,0.6924707,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-134.4074,475.7753;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;26;78.30021,252.7886;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;37;147.4406,748.5123;Inherit;False;Property;_Frensel_Power;Frensel_Power;10;0;Create;True;0;0;False;0;False;2.13;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;29;-479.7415,-392.6615;Inherit;True;Property;_Ground_Tex;Ground_Tex;1;0;Create;True;0;0;False;0;False;-1;None;3233e8c7d346072449e3386cc98822a1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;36;171.0306,618.2555;Inherit;False;Property;_Frensel_Scale;Frensel_Scale;9;0;Create;True;0;0;False;0;False;0.61;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;28;340.9392,112.1985;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;32;570.0218,-133.1315;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;40;445.0823,800.4095;Inherit;False;Property;_Frensel_Color;Frensel_Color;8;0;Create;True;0;0;False;0;False;0.3632075,0.6126482,1,0;0.745283,0.03214946,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FresnelNode;38;360.9798,524.9227;Inherit;True;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;39;717.0823,400.4095;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1012.597,228.3521;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;Unlit/Fireball;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;19;0;18;0
WireConnection;3;0;35;0
WireConnection;14;0;16;0
WireConnection;20;0;19;0
WireConnection;10;1;3;0
WireConnection;10;3;11;0
WireConnection;10;4;14;0
WireConnection;1;1;10;0
WireConnection;21;0;20;0
WireConnection;22;0;1;4
WireConnection;22;1;21;0
WireConnection;26;0;27;0
WireConnection;26;1;23;0
WireConnection;26;2;22;0
WireConnection;29;1;3;0
WireConnection;28;0;1;0
WireConnection;28;1;26;0
WireConnection;32;0;28;0
WireConnection;32;1;29;0
WireConnection;32;2;29;4
WireConnection;38;2;36;0
WireConnection;38;3;37;0
WireConnection;39;0;32;0
WireConnection;39;1;40;0
WireConnection;39;2;38;0
WireConnection;0;2;39;0
ASEEND*/
//CHKSM=DE7D86BBAF3838697169392C302A5524A7E16506