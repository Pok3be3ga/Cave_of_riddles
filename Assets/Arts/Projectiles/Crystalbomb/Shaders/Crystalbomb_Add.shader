// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Unlit/Crystal_Add"
{
	Properties
	{
		_Opacity_Value("Opacity_Value", Range( 0 , 1)) = 1
		_Main_Tex("Main_Tex", 2D) = "white" {}
		_Tiling("Tiling", Float) = 0
		_Main_Color("Main_Color", Color) = (0.9743459,0.5518868,1,0)
		_Opacity_Color("Opacity_Color", Color) = (0.4715316,0,0.8113208,0)
		_Coloms_Rows("Coloms_Rows", Float) = 0
		_Fleepbook_Speed("Fleepbook_Speed", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha noshadow nolightmap  nodynlightmap nodirlightmap 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _Opacity_Color;
		uniform float4 _Main_Color;
		uniform sampler2D _Main_Tex;
		SamplerState sampler_Main_Tex;
		uniform float _Tiling;
		uniform float _Coloms_Rows;
		uniform float _Fleepbook_Speed;
		uniform float _Opacity_Value;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 temp_cast_0 = (_Tiling).xx;
			float2 uv_TexCoord19 = i.uv_texcoord * temp_cast_0;
			float temp_output_4_0_g1 = _Coloms_Rows;
			float temp_output_5_0_g1 = _Coloms_Rows;
			float2 appendResult7_g1 = (float2(temp_output_4_0_g1 , temp_output_5_0_g1));
			float totalFrames39_g1 = ( temp_output_4_0_g1 * temp_output_5_0_g1 );
			float2 appendResult8_g1 = (float2(totalFrames39_g1 , temp_output_5_0_g1));
			float mulTime6 = _Time.y * _Fleepbook_Speed;
			float clampResult42_g1 = clamp( 0.0 , 0.0001 , ( totalFrames39_g1 - 1.0 ) );
			float temp_output_35_0_g1 = frac( ( ( mulTime6 + clampResult42_g1 ) / totalFrames39_g1 ) );
			float2 appendResult29_g1 = (float2(temp_output_35_0_g1 , ( 1.0 - temp_output_35_0_g1 )));
			float2 temp_output_15_0_g1 = ( ( uv_TexCoord19 / appendResult7_g1 ) + ( floor( ( appendResult8_g1 * appendResult29_g1 ) ) / appendResult7_g1 ) );
			float4 tex2DNode2 = tex2D( _Main_Tex, temp_output_15_0_g1 );
			float4 lerpResult23 = lerp( _Opacity_Color , _Main_Color , tex2DNode2.a);
			o.Emission = lerpResult23.rgb;
			o.Alpha = ( ( tex2DNode2.a + _Opacity_Color.r ) * _Opacity_Value );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18500
1913;-73;1920;1120;1556.427;464.9506;1.524916;True;False
Node;AmplifyShaderEditor.RangedFloatNode;13;-1428,191;Inherit;False;Property;_Fleepbook_Speed;Fleepbook_Speed;6;0;Create;True;0;0;False;0;False;0;30;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1469.561,-62.62109;Inherit;False;Property;_Tiling;Tiling;2;0;Create;True;0;0;False;0;False;0;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;6;-1211,185;Inherit;False;1;0;FLOAT;30;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-1276.561,45.37891;Inherit;False;Property;_Coloms_Rows;Coloms_Rows;5;0;Create;True;0;0;False;0;False;0;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;19;-1236.561,-128.6211;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;1;-1007,2;Inherit;False;Flipbook;-1;;1;53c2488c220f6564ca6c90721ee16673;2,71,0,68,0;8;51;SAMPLER2D;0.0;False;13;FLOAT2;0,0;False;4;FLOAT;4;False;5;FLOAT;4;False;24;FLOAT;0;False;2;FLOAT;0;False;55;FLOAT;0;False;70;FLOAT;0;False;5;COLOR;53;FLOAT2;0;FLOAT;47;FLOAT;48;FLOAT;62
Node;AmplifyShaderEditor.SamplerNode;2;-670,-87;Inherit;True;Property;_Main_Tex;Main_Tex;1;0;Create;True;0;0;False;0;False;-1;2e1e6bccba87a3945b5e918a91f1616f;c18d1a1e5915b68408b0fa5b5d8b91e0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;8;-309,153;Inherit;False;Property;_Opacity_Color;Opacity_Color;4;0;Create;True;0;0;False;0;False;0.4715316,0,0.8113208,0;0.4925209,0,0.5754716,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;9;-304,-417;Inherit;False;Property;_Main_Color;Main_Color;3;0;Create;True;0;0;False;0;False;0.9743459,0.5518868,1,0;1,0.5424526,0.7439176,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;15;-280.5613,476.3789;Inherit;False;Property;_Opacity_Value;Opacity_Value;0;0;Create;True;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;12;64,145;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;359.0291,316.1797;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;23;-5.970947,-148.8203;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;552,-105;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;Unlit/Crystal_Add;False;False;False;False;False;False;True;True;True;False;False;False;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;6;0;13;0
WireConnection;19;0;20;0
WireConnection;1;13;19;0
WireConnection;1;4;14;0
WireConnection;1;5;14;0
WireConnection;1;2;6;0
WireConnection;2;1;1;0
WireConnection;12;0;2;4
WireConnection;12;1;8;1
WireConnection;22;0;12;0
WireConnection;22;1;15;0
WireConnection;23;0;8;0
WireConnection;23;1;9;0
WireConnection;23;2;2;4
WireConnection;0;2;23;0
WireConnection;0;9;22;0
ASEEND*/
//CHKSM=94292669CA24E07D9D22E95283510A9E70509594