Shader "NoeNoe/NoeNoe Toon Shader/NoeNoe Toon Cutout Outline" {
    Properties {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Main texture (RGB)", 2D) = "white" {}
        _StaticToonLight ("Static Toon Light", Vector) = (0,3,0,0)
		_WorldLightIntensity ("World Light Dir Multiplier", Range(0, 10)) = 1
		[Toggle(_)] _OverrideWorldLight ("Override World Light", Float) = 0
        [Toggle(_)] _BillboardStaticLight ("Billboard Static Light", Float ) = 0
        _RealRamp ("Ramp", 2D) = "white" {}
		_RampTint ("Ramp Tint", Range(0,1)) = 0
        _ToonContrast ("Toon Contrast", Range(0, 1)) = 0.25
        _EmissionMap ("Emission Map", 2D) = "white" {}
        _EmissionColor ("Emission", Color) = (0,0,0)
        _Intensity ("Intensity", Range(0, 10)) = 0.8
        _Saturation ("Saturation", Range(0, 1)) = 0.65
        _NormalMap ("Normal Map", 2D) = "bump" {}
		[Enum(None,0,Metallic,1,Specular,2)] _MetallicMode("Metallic Mode", Float) = 0
		[NoScaleOffset] _MetallicGlossMap("Metallic Map", 2D) = "white" {}
		_Metallic("Metallic", Range( 0 , 1)) = 0
		_Glossiness("Smoothness", Range( 0 , 1)) = 0
        _SpecColor("Specular Color", Color) = (0,0,0,0)
        _SpecGlossMap("Specular Map", 2D) = "white" {}
        _OutlineWidth ("Outline Width", Float ) = 0
        _OutlineColor ("Outline Tint", Color) = (0,0,0,1)
		_OutlineTex ("Outline Texture", 2D) = "white" {}
        [Toggle(_)] _ScreenSpaceOutline ("Screen-Space Outline", Float ) = 0
		[Enum(Normal,8,Outer Only,6)] _OutlineStencilComp ("Outline Mode", Float) = 8
		[Toggle(_)] _OutlineCutout ("Cutout Outlines", Float) = 1
        _Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
		[Enum(Both,0,Front,2,Back,1)] _Cull("Sidedness", Float) = 2
		_Ramp ("Fallback Ramp", 2D) = "white" {}
		[Toggle(_)] _ReceiveShadows ("Receive Shadows", Float) = 0
    }
    SubShader {
        Tags { "RenderType"="TransparentCutout" "Queue"="AlphaTest" }
		
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Cull [_Cull]
			
			Stencil {
				Ref 8
				Comp Always
				Pass Replace
			}
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
			#pragma shader_feature _METALLICGLOSSMAP
			#pragma shader_feature _SPECGLOSSMAP

            uniform float4 _Color;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform sampler2D _EmissionMap; uniform float4 _EmissionMap_ST;
            uniform sampler2D _NormalMap; uniform float4 _NormalMap_ST;
            uniform float _Intensity;
			
			float _Cutoff;
			
			float _OverrideWorldLight;
            
            uniform float4 _StaticToonLight;
            uniform sampler2D _RealRamp; uniform float4 _RealRamp_ST;
            float3 VRViewPosition(){
            #if defined(USING_STEREO_MATRICES)
            float3 leftEye = unity_StereoWorldSpaceCameraPos[0];
            float3 rightEye = unity_StereoWorldSpaceCameraPos[1];
            
            float3 centerEye = lerp(leftEye, rightEye, 0.5);
            #endif
            #if !defined(USING_STEREO_MATRICES)
            float3 centerEye = _WorldSpaceCameraPos;
            #endif
            return centerEye;
            }
            
            uniform float _Saturation;
            uniform fixed _BillboardStaticLight;
            uniform float _ToonContrast;
			
			#include "NoeNoeToonEdits.cginc"
			
            ENDCG
        }
		
        Pass {
            Name "Outline"
            Tags {
				"LightMode"="ForwardBase"
            }
            Cull Front
			
			Stencil {
				Ref 8
				Comp [_OutlineStencilComp]
				Pass Keep
			}
            
            CGPROGRAM
            #pragma vertex vertOutline
            #pragma fragment frag
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #include "AutoLight.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            //#pragma multi_compile_fwdbase_fullshadows
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
			
			#define NOENOETOON_OUTLINE_PASS
			
            uniform sampler2D _OutlineTex; uniform float4 _OutlineTex_ST;
            uniform float _OutlineWidth;
            uniform fixed _ScreenSpaceOutline;
            uniform float4 _OutlineColor;
			
			float3 VRViewPosition(){
            #if defined(USING_STEREO_MATRICES)
            float3 leftEye = unity_StereoWorldSpaceCameraPos[0];
            float3 rightEye = unity_StereoWorldSpaceCameraPos[1];
            
            float3 centerEye = lerp(leftEye, rightEye, 0.5);
            #endif
            #if !defined(USING_STEREO_MATRICES)
            float3 centerEye = _WorldSpaceCameraPos;
            #endif
            return centerEye;
            }
			
			float _OutlineCutout;
			float _Cutoff;
			
			float _OverrideWorldLight;
            
            uniform float4 _StaticToonLight;
            uniform sampler2D _RealRamp; uniform float4 _RealRamp_ST;
			
			uniform sampler2D _NormalMap; uniform float4 _NormalMap_ST;
			
            uniform float _Saturation;
            uniform float _Intensity;
            uniform fixed _BillboardStaticLight;
            uniform float _ToonContrast;
			
			#include "NoeNoeToonEdits.cginc"

			VertexOutput vertOutline (VertexInput v) {
				VertexOutput o = (VertexOutput)0;
				o.uv0 = v.texcoord0;
				o.normalDir = UnityObjectToWorldNormal(v.normal);
				o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
				o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
				
				float3 lightColor = _LightColor0.rgb;
				
                float outlineWidth = (_OutlineWidth*0.001);
				// Scale outline by outline tex alpha
				float4 outlineTex = tex2Dlod(_OutlineTex, float4(v.texcoord0, 0, 0));
				outlineTex *= _OutlineColor;
				outlineWidth *= outlineTex.a;
				
                float OutlineScale = lerp( outlineWidth, (distance(_WorldSpaceCameraPos,mul(unity_ObjectToWorld, v.vertex).rgb)*outlineWidth), _ScreenSpaceOutline);
                o.pos = UnityObjectToClipPos(float4(v.vertex.xyz + v.normal*OutlineScale,1));
				o.posWorld = mul(unity_ObjectToWorld, float4(v.vertex.xyz + v.normal*OutlineScale,1));
				TRANSFER_VERTEX_TO_FRAGMENT(o)
				return o;
			}
			
            ENDCG
        }
		
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            Cull [_Cull]
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
			#pragma shader_feature _METALLICGLOSSMAP
			#pragma shader_feature _SPECGLOSSMAP

            uniform float4 _Color;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform sampler2D _EmissionMap; uniform float4 _EmissionMap_ST;
            uniform sampler2D _NormalMap; uniform float4 _NormalMap_ST;
            uniform float _Intensity;
			
			float _Cutoff;
			
			float _OverrideWorldLight;
            
            uniform float4 _StaticToonLight;
            uniform sampler2D _RealRamp; uniform float4 _RealRamp_ST;
            float3 VRViewPosition(){
            #if defined(USING_STEREO_MATRICES)
            float3 leftEye = unity_StereoWorldSpaceCameraPos[0];
            float3 rightEye = unity_StereoWorldSpaceCameraPos[1];
            
            float3 centerEye = lerp(leftEye, rightEye, 0.5);
            #endif
            #if !defined(USING_STEREO_MATRICES)
            float3 centerEye = _WorldSpaceCameraPos;
            #endif
            return centerEye;
            }
            
            uniform float _Saturation;
            uniform fixed _BillboardStaticLight;
            uniform float _ToonContrast;
			
			#include "NoeNoeToonEdits.cginc"		

            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1
            Cull Off
            
            CGPROGRAM
            #pragma vertex vertShadow
            #pragma fragment fragShadow
            #define UNITY_PASS_SHADOWCASTER
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #include "AutoLight.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
			
			float _Cutoff;
			
            #include "NoeNoeShadowCaster.cginc"

            ENDCG
        }
    }
	CustomEditor "NoeNoeToonEditorGUI"
}
