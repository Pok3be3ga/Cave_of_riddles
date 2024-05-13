// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Crystalbomb"
{
	Properties
	{
		_Expansion_Value("Expansion_Value", Float) = 0
		_Albedo_Tex("Albedo_Tex", 2D) = "white" {}
		_Normal_Tex("Normal_Tex", 2D) = "bump" {}
		_Main_Color("Main_Color", Color) = (0.9052305,0,1,0)
		_Add_Color("Add_Color", Color) = (1,0,0.5678148,0)
		_Frensel_Color("Frensel_Color", Color) = (0.3632075,0.6126482,1,0)
		_Frensel_Front("Frensel_Front", Float) = 0.61
		_Frensel_Back("Frensel_Back", Float) = 0.61
		_Ripple_Speed("Ripple_Speed", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Off
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 4.6
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
			float3 worldPos;
			INTERNAL_DATA
			float3 worldNormal;
			half ASEVFace : VFACE;
		};

		uniform float _Expansion_Value;
		uniform float _Ripple_Speed;
		uniform float4 _Main_Color;
		uniform float4 _Add_Color;
		uniform sampler2D _Albedo_Tex;
		uniform float4 _Albedo_Tex_ST;
		uniform float4 _Frensel_Color;
		uniform sampler2D _Normal_Tex;
		uniform float4 _Normal_Tex_ST;
		uniform float _Frensel_Front;
		uniform float _Frensel_Back;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float Expansion_Value83 = (0.0 + (_Expansion_Value - 1.0) * (2.0 - 0.0) / (15.0 - 1.0));
			float3 appendResult79 = (float3(Expansion_Value83 , Expansion_Value83 , Expansion_Value83));
			float mulTime15 = _Time.y * _Ripple_Speed;
			float3 ase_vertexNormal = v.normal.xyz;
			v.vertex.xyz += ( ( appendResult79 + ((0.02 + (Expansion_Value83 - 0.0) * (0.0 - 0.02) / (1.0 - 0.0)) + (sin( mulTime15 ) - 0.0) * (0.0 - (0.02 + (Expansion_Value83 - 0.0) * (0.0 - 0.02) / (1.0 - 0.0))) / (1.0 - 0.0)) ) * ase_vertexNormal );
			v.vertex.w = 1;
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Normal = float3(0,0,1);
			float2 uv_Albedo_Tex = i.uv_texcoord * _Albedo_Tex_ST.xy + _Albedo_Tex_ST.zw;
			float4 lerpResult12 = lerp( _Main_Color , _Add_Color , tex2D( _Albedo_Tex, uv_Albedo_Tex ));
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float2 uv_Normal_Tex = i.uv_texcoord * _Normal_Tex_ST.xy + _Normal_Tex_ST.zw;
			float3 tex2DNode73 = UnpackNormal( tex2D( _Normal_Tex, uv_Normal_Tex ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_worldTangent = WorldNormalVector( i, float3( 1, 0, 0 ) );
			float3 ase_worldBitangent = WorldNormalVector( i, float3( 0, 1, 0 ) );
			float3x3 ase_tangentToWorldFast = float3x3(ase_worldTangent.x,ase_worldBitangent.x,ase_worldNormal.x,ase_worldTangent.y,ase_worldBitangent.y,ase_worldNormal.y,ase_worldTangent.z,ase_worldBitangent.z,ase_worldNormal.z);
			float Expansion_Value83 = (0.0 + (_Expansion_Value - 1.0) * (2.0 - 0.0) / (15.0 - 1.0));
			float temp_output_93_0 = ( _Frensel_Front + Expansion_Value83 );
			float fresnelNdotV9 = dot( mul(ase_tangentToWorldFast,tex2DNode73), ase_worldViewDir );
			float fresnelNode9 = ( 0.0 + temp_output_93_0 * pow( max( 1.0 - fresnelNdotV9 , 0.0001 ), temp_output_93_0 ) );
			float temp_output_92_0 = ( _Frensel_Back + Expansion_Value83 );
			float fresnelNdotV76 = dot( mul(ase_tangentToWorldFast,tex2DNode73), ase_worldViewDir );
			float fresnelNode76 = ( 0.0 + temp_output_92_0 * pow( max( 1.0 - fresnelNdotV76 , 0.0001 ), temp_output_92_0 ) );
			float switchResult63 = (((i.ASEVFace>0)?(fresnelNode9):(fresnelNode76)));
			float4 lerpResult10 = lerp( ( i.vertexColor * lerpResult12 ) , _Frensel_Color , switchResult63);
			o.Emission = lerpResult10.rgb;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Unlit keepalpha fullforwardshadows nolightmap  nodynlightmap nodirlightmap nofog vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.6
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
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				half4 color : COLOR0;
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
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				o.color = v.color;
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
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				surfIN.vertexColor = IN.color;
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
1920;-92;1920;1139;2156.009;368.2349;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;78;-1437.114,222.631;Inherit;False;Property;_Expansion_Value;Expansion_Value;0;0;Create;True;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;94;-1188.009,73.76511;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;15;False;3;FLOAT;0;False;4;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;83;-953.1144,220.631;Inherit;False;Expansion_Value;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-881.7704,415.14;Inherit;False;Property;_Ripple_Speed;Ripple_Speed;8;0;Create;True;0;0;False;0;False;1;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;90;-935.8461,-360.3099;Inherit;False;Property;_Frensel_Back;Frensel_Back;7;0;Create;True;0;0;False;0;False;0.61;-0.03;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-928.8239,-570.3243;Inherit;False;Property;_Frensel_Front;Frensel_Front;6;0;Create;True;0;0;False;0;False;0.61;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;91;-994.4792,-265.3024;Inherit;False;83;Expansion_Value;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;86;-880.089,586.9834;Inherit;False;83;Expansion_Value;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;15;-701.4846,424.1401;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;85;-473.6987,252.7477;Inherit;False;83;Expansion_Value;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;88;-579.4373,590.1147;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0.02;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;73;-1278.172,-615.6496;Inherit;True;Property;_Normal_Tex;Normal_Tex;2;0;Create;True;0;0;False;0;False;-1;None;0348280d54ceb344882ab1470ebbb622;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;93;-730.4792,-585.3024;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;13;-1020.549,-1109.049;Inherit;False;Property;_Add_Color;Add_Color;4;0;Create;True;0;0;False;0;False;1,0,0.5678148,0;0.4811321,0.07035396,0.359772,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-1044.95,-930.1488;Inherit;True;Property;_Albedo_Tex;Albedo_Tex;1;0;Create;True;0;0;False;0;False;-1;89e34608f32201b4493be7555376f210;89e34608f32201b4493be7555376f210;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;92;-721.4792,-307.3024;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;17;-505.7585,427.2055;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;5;-1001.85,-1286.049;Inherit;False;Property;_Main_Color;Main_Color;3;0;Create;True;0;0;False;0;False;0.9052305,0,1,0;0.144606,0,0.1886789,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;52;-343.2376,433.7932;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;3;-635.6501,-1431.749;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FresnelNode;9;-638.8293,-779.0276;Inherit;True;Standard;TangentNormal;ViewDir;False;True;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;79;-239.6987,234.7916;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;12;-610.4493,-1175.549;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FresnelNode;76;-600.2298,-491.1637;Inherit;True;Standard;TangentNormal;ViewDir;False;True;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwitchByFaceNode;63;-169.4947,-650.7194;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;77;-115.6987,363.7917;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2;-253.55,-1306.349;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.NormalVertexDataNode;44;-204.3986,685.0256;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;8;-303.0909,-1070.141;Inherit;False;Property;_Frensel_Color;Frensel_Color;5;0;Create;True;0;0;False;0;False;0.3632075,0.6126482,1,0;0.5802817,0,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;82.92836,585.5485;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;10;-16.49718,-1164.871;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;627.3629,-700.333;Float;False;True;-1;6;ASEMaterialInspector;0;0;Unlit;Crystalbomb;False;False;False;False;False;False;True;True;True;True;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;94;0;78;0
WireConnection;83;0;94;0
WireConnection;15;0;14;0
WireConnection;88;0;86;0
WireConnection;93;0;7;0
WireConnection;93;1;91;0
WireConnection;92;0;90;0
WireConnection;92;1;91;0
WireConnection;17;0;15;0
WireConnection;52;0;17;0
WireConnection;52;3;88;0
WireConnection;9;0;73;0
WireConnection;9;2;93;0
WireConnection;9;3;93;0
WireConnection;79;0;85;0
WireConnection;79;1;85;0
WireConnection;79;2;85;0
WireConnection;12;0;5;0
WireConnection;12;1;13;0
WireConnection;12;2;1;0
WireConnection;76;0;73;0
WireConnection;76;2;92;0
WireConnection;76;3;92;0
WireConnection;63;0;9;0
WireConnection;63;1;76;0
WireConnection;77;0;79;0
WireConnection;77;1;52;0
WireConnection;2;0;3;0
WireConnection;2;1;12;0
WireConnection;46;0;77;0
WireConnection;46;1;44;0
WireConnection;10;0;2;0
WireConnection;10;1;8;0
WireConnection;10;2;63;0
WireConnection;0;2;10;0
WireConnection;0;11;46;0
ASEEND*/
//CHKSM=905B9C0E17F00D0EC2150A1EF7BCFDC388B65B9A