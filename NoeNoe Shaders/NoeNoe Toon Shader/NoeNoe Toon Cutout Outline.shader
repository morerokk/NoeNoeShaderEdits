Shader "NoeNoe/NoeNoe Toon Shader/NoeNoe Toon Cutout Outline" {
    Properties {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Main texture (RGB)", 2D) = "white" {}
        _StaticToonLight ("Static Toon Light", Vector) = (0,3,0,0)
		_WorldLightIntensity ("World Light Dir Multiplier", Range(0, 10)) = 1
		[Toggle(_)] _OverrideWorldLight ("Override World Light", Float) = 0
        [Toggle(_)] _BillboardStaticLight ("Billboard Static Light", Float ) = 0
        _Ramp ("Ramp", 2D) = "white" {}
        _ToonContrast ("Toon Contrast", Range(0, 1)) = 0.25
        _EmissionMap ("Emission Map", 2D) = "white" {}
        _Emission ("Emission", Range(0, 10)) = 0
        _Intensity ("Intensity", Range(0, 10)) = 0.8
        _Saturation ("Saturation", Range(0, 1)) = 0.65
        _NormalMap ("Normal Map", 2D) = "bump" {}
        _OutlineWidth ("Outline Width", Float ) = 0
        _OutlineColor ("Outline Tint", Color) = (0,0,0,1)
		_OutlineTex ("Outline Texture", 2D) = "white" {}
        [Toggle(_)] _ScreenSpaceOutline ("Screen-Space Outline", Float ) = 0
		[Enum(Normal,8,Outer Only,6)] _OutlineStencilComp ("Outline Mode", Float) = 8
		[Toggle(_)] _OutlineCutout ("Cutout Outlines", Float) = 1
        _Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "RenderType"="TransparentCutout"
        }
		
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Cull Off
			
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
            uniform float4 _Color;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform sampler2D _EmissionMap; uniform float4 _EmissionMap_ST;
            uniform float _Emission;
            uniform sampler2D _NormalMap; uniform float4 _NormalMap_ST;
            uniform float _Intensity;
            float3 Function_node_3693( float3 normal ){
            return ShadeSH9(half4(normal, 1.0));
            
            }
			
			float _Cutoff;
			
			float _OverrideWorldLight;
            
            uniform float4 _StaticToonLight;
            uniform sampler2D _Ramp; uniform float4 _Ramp_ST;
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
            #pragma vertex vert
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
            uniform sampler2D _OutlineTex; uniform float4 _OutlineTex_ST;
            uniform float _OutlineWidth;
            uniform fixed _ScreenSpaceOutline;
            uniform float4 _OutlineColor;
			
            float3 Function_node_3693( float3 normal ){
            return ShadeSH9(half4(normal, 1.0));
            
            }
			
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
            uniform sampler2D _Ramp; uniform float4 _Ramp_ST;
			
			uniform sampler2D _NormalMap; uniform float4 _NormalMap_ST;
			
            uniform float _Saturation;
            uniform float _Intensity;
            uniform fixed _BillboardStaticLight;
            uniform float _ToonContrast;
			
			float _WorldLightIntensity;

			float4 lightDirection(float4 fallback, float alwaysUseFallback)
			{
				// Try to get world light direction
				float4 worldLightDir = _WorldSpaceLightPos0 * _WorldLightIntensity;
				if(all(worldLightDir == float4(0,0,0,0)))
				{
					worldLightDir = fallback;
				}
				return lerp(worldLightDir, fallback, alwaysUseFallback);
			}
			
			struct VertexInput {
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float4 tangent : TANGENT;
				float2 texcoord0 : TEXCOORD0;
			};

			struct VertexOutput {
				float4 pos : SV_POSITION;
				float2 uv0 : TEXCOORD0;
				float4 posWorld : TEXCOORD1;
				float3 normalDir : TEXCOORD2;
				float3 tangentDir : TEXCOORD3;
				float3 bitangentDir : TEXCOORD4;
				float4 lightDir : TEXCOORD7;
				LIGHTING_COORDS(5,6)
			};

			VertexOutput vert (VertexInput v) {
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
				o.lightDir = lightDirection(_StaticToonLight, _OverrideWorldLight);
				TRANSFER_VERTEX_TO_FRAGMENT(o)
				return o;
			}

			float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
				float isFrontFace = ( facing >= 0 ? 1 : 0 );
				float faceSign = ( facing >= 0 ? 1 : -1 );

				float4 staticLightDir = i.lightDir;
				
				i.normalDir = normalize(i.normalDir);
				i.normalDir *= faceSign;
				
				float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
				float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
				float3 _NormalMap_var = UnpackNormal(tex2D(_NormalMap,TRANSFORM_TEX(i.uv0, _NormalMap)));
				float3 normalLocal = _NormalMap_var.rgb;
				float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
				float4 _MainTex_var = tex2D(_OutlineTex,TRANSFORM_TEX(i.uv0, _OutlineTex));
				float SurfaceAlpha = _MainTex_var.a;

				// Only clip if outline cutout is on
				clip(SurfaceAlpha - _Cutoff + (1 - _OutlineCutout));
				
				float3 lightColor = _LightColor0.rgb;
			////// Lighting:
				float attenuation = LIGHT_ATTENUATION(i) / SHADOW_ATTENUATION(i);
				
				float3 FlatLighting = saturate((Function_node_3693( float3(0,1,0) )+(_LightColor0.rgb*attenuation)));
				float3 MappedTexture = (_MainTex_var.rgb*_OutlineColor.rgb);
				
				float SaturationVar = _Saturation;
				float IntensityVar = _Intensity;
				
				float3 Diffuse = lerp(lerp(MappedTexture,dot(MappedTexture,float3(0.3,0.59,0.11)),(-0.5)),dot(lerp(MappedTexture,dot(MappedTexture,float3(0.3,0.59,0.11)),(-0.5)),float3(0.3,0.59,0.11)),(1.0 - SaturationVar));
				float node_424 = 0.5;
				float node_7394_if_leA = step(_BillboardStaticLight,1.0);
				float node_7394_if_leB = step(1.0,_BillboardStaticLight);
				float3 VRPosition = VRViewPosition();
				float3 node_3406 = (i.posWorld.rgb-VRPosition);
				float3 node_1153 = (-1*(node_3406/length(node_3406))).rgb;
				float2 node_7017 = normalize(float2(node_1153.r,node_1153.b));
				float2 node_7930 = node_7017.rg;
				float2 node_8628 = (float2((-1*node_7930.g),node_7930.r)*(-1*staticLightDir.r)).rg;
				float2 node_3851 = (node_7017*staticLightDir.b).rg;
				float3 StaticLightDirection = lerp((node_7394_if_leA*staticLightDir.rgb)+(node_7394_if_leB*staticLightDir.rgb),(float3(node_8628.r,staticLightDir.g,node_8628.g)+float3(node_3851.r,staticLightDir.g,node_3851.g)),node_7394_if_leA*node_7394_if_leB);
				float node_1617 = 0.5*dot((normalDirection*faceSign),StaticLightDirection)+0.5;
				float2 node_8091 = float2(node_1617,node_1617);
				
				float4 node_9498 = tex2D(_Ramp,TRANSFORM_TEX(node_8091, _Ramp));
				float ToonContrast_var = _ToonContrast;
				
				float3 StaticToonLighting = node_9498.rgb;
				float3 finalColor = saturate(((IntensityVar*FlatLighting*Diffuse) > 0.5 ?  (1.0-(1.0-2.0*((IntensityVar*FlatLighting*Diffuse)-0.5))*(1.0-lerp(float3(node_424,node_424,node_424),StaticToonLighting,ToonContrast_var))) : (2.0*(IntensityVar*FlatLighting*Diffuse)*lerp(float3(node_424,node_424,node_424),StaticToonLighting,ToonContrast_var))) );
				
				#ifdef UNITY_PASS_FORWARDBASE
					finalColor = emissive + finalColor;
				#endif
				
				float finalAlpha = 1;
				
				// Transparent stuff, use alpha and multiply by opacity
				// Forward additive pass multiplies the colors instead
				#ifdef NOENOETOON_TRANSPARENT
					#ifdef UNITY_PASS_FORWARDBASE
						finalAlpha = _MainTex_var.a * _Opacity;
					#else
						finalAlpha = 0;
						finalColor *= (SurfaceAlpha * _Opacity);
					#endif
				#endif
				
				return fixed4(finalColor,finalAlpha);
			}
			
            ENDCG
        }
		
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            Cull Off
            
            
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
            uniform float4 _Color;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform sampler2D _EmissionMap; uniform float4 _EmissionMap_ST;
            uniform float _Emission;
            uniform sampler2D _NormalMap; uniform float4 _NormalMap_ST;
            uniform float _Intensity;
            float3 Function_node_3693( float3 normal ){
            return ShadeSH9(half4(normal, 1.0));
            
            }
			
			float _Cutoff;
			
			float _OverrideWorldLight;
            
            uniform float4 _StaticToonLight;
            uniform sampler2D _Ramp; uniform float4 _Ramp_ST;
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
    FallBack "Diffuse"
}
