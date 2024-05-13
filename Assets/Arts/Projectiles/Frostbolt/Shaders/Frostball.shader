// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Unlit/Frostball"
{
	Properties
	{
		_Main_Color("Main_Color", Color) = (0.3632075,0.6126482,1,0)
		[HDR]_Add_Color("Add_Color", Color) = (0.1462264,0.8399816,1,0)
		_Frostbolt_Tex("Frostbolt_Tex", 2D) = "white" {}
		_Tex_Tile("Tex_Tile", Float) = 1
		_Tex_X_Offset("Tex_X_Offset", Float) = 0
		_Tex_Y_Offset("Tex_Y_Offset", Float) = 0
		_Frensel_Scale("Frensel_Scale", Float) = 0.61
		_Frensel_Power("Frensel_Power", Float) = 2.13
		_Blink_Speed("Blink_Speed", Float) = 3
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
		};

		uniform sampler2D _Frostbolt_Tex;
		uniform float _Tex_Tile;
		uniform float _Tex_X_Offset;
		uniform float _Tex_Y_Offset;
		uniform float4 _Add_Color;
		uniform float _Blink_Speed;
		uniform float4 _Main_Color;
		uniform float _Frensel_Scale;
		uniform float _Frensel_Power;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 temp_cast_0 = (_Tex_Tile).xx;
			float2 appendResult23 = (float2(_Tex_X_Offset , _Tex_Y_Offset));
			float2 uv_TexCoord17 = i.uv_texcoord * temp_cast_0 + appendResult23;
			float4 tex2DNode13 = tex2D( _Frostbolt_Tex, uv_TexCoord17 );
			float mulTime11 = _Time.y * _Blink_Speed;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float fresnelNdotV2 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode2 = ( 0.0 + _Frensel_Scale * pow( 1.0 - fresnelNdotV2, _Frensel_Power ) );
			float4 lerpResult6 = lerp( ( tex2DNode13 + ( _Add_Color * ( tex2DNode13.a * (0.0 + (sin( mulTime11 ) - -1.0) * (1.0 - 0.0) / (0.0 - -1.0)) ) ) ) , _Main_Color , fresnelNode2);
			o.Emission = lerpResult6.rgb;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Unlit keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				float3 worldNormal : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.worldNormal = worldNormal;
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = IN.worldNormal;
				SurfaceOutput o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutput, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18500
1920;-91;1920;1138;468.9091;686.004;1.475036;True;False
Node;AmplifyShaderEditor.RangedFloatNode;16;-575.0425,658.1285;Inherit;False;Property;_Blink_Speed;Blink_Speed;8;0;Create;True;0;0;False;0;False;3;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-858.8945,535.0875;Inherit;False;Property;_Tex_X_Offset;Tex_X_Offset;4;0;Create;True;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-860.8945,669.0875;Inherit;False;Property;_Tex_Y_Offset;Tex_Y_Offset;5;0;Create;True;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;11;-405.8407,661.7463;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-788.8945,402.0875;Inherit;False;Property;_Tex_Tile;Tex_Tile;3;0;Create;True;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;23;-658.8945,548.0875;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SinOpNode;10;-210.8412,663.5461;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;14;-384.5298,259.5113;Inherit;True;Property;_Frostbolt_Tex;Frostbolt_Tex;2;0;Create;True;0;0;False;0;False;bf28bb5567a37a54f8434ceb10813616;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TextureCoordinatesNode;17;-479.3108,497.6111;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;12;-53.04097,653.7463;Inherit;True;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;13;-80.33017,152.9109;Inherit;True;Property;_TextureSample0;Texture Sample 0;3;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;253.5585,450.7287;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;26;287.6065,178.227;Inherit;False;Property;_Add_Color;Add_Color;1;1;[HDR];Create;True;0;0;False;0;False;0.1462264,0.8399816,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;520.3065,247.1271;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;5;766.3053,139.9949;Inherit;False;Property;_Frensel_Scale;Frensel_Scale;6;0;Create;True;0;0;False;0;False;0.61;1.79;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;770.8048,229.2948;Inherit;False;Property;_Frensel_Power;Frensel_Power;7;0;Create;True;0;0;False;0;False;2.13;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;25;719.0056,-130.2732;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;8;1047.126,246.6172;Inherit;False;Property;_Main_Color;Main_Color;0;0;Create;True;0;0;False;0;False;0.3632075,0.6126482,1,0;0.3632075,0.6126482,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FresnelNode;2;963.1031,-8.805051;Inherit;True;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;6;1306.411,-158.7382;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1734.454,-188.4847;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;Unlit/Frostball;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;11;0;16;0
WireConnection;23;0;20;0
WireConnection;23;1;21;0
WireConnection;10;0;11;0
WireConnection;17;0;18;0
WireConnection;17;1;23;0
WireConnection;12;0;10;0
WireConnection;13;0;14;0
WireConnection;13;1;17;0
WireConnection;15;0;13;4
WireConnection;15;1;12;0
WireConnection;24;0;26;0
WireConnection;24;1;15;0
WireConnection;25;0;13;0
WireConnection;25;1;24;0
WireConnection;2;2;5;0
WireConnection;2;3;9;0
WireConnection;6;0;25;0
WireConnection;6;1;8;0
WireConnection;6;2;2;0
WireConnection;0;2;6;0
ASEEND*/
//CHKSM=59911C7CC4F59AA6E9A46B5FCB04940CEF3E185E