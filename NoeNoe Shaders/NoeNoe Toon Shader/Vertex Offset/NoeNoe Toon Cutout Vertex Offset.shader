Shader "NoeNoe/NoeNoe Overlay Shader/Misc/NoeNoe Toon Cutout Vertex Offset" {
    Properties {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Main texture (RGB)", 2D) = "white" {}
        _StaticToonLight ("Static Toon Light", Vector) = (0,3,0,0)
		_WorldLightIntensity ("World Light Dir Multiplier", Range(0, 10)) = 1
		[Toggle(_)] _OverrideWorldLight ("Override World Light", Float) = 0
        [Toggle(_)] _BillboardStaticLight ("Billboard Static Light", Float ) = 0
        _Ramp ("Default Ramp", 2D) = "white" {}
        _ToonContrast ("Default Toon Contrast", Range(0, 1)) = 0.25
        _EmissionMap ("Emission Map", 2D) = "white" {}
        _Emission ("Emission", Range(0, 10)) = 0
        _Intensity ("Default Intensity", Range(0, 10)) = 0.8
        _Saturation ("Default Saturation", Range(0, 1)) = 0.65
        _NormalMap ("Normal Map", 2D) = "bump" {}
        _OutlineWidth ("Outline Width", Float ) = 0
        _OutlineColor ("Outline Color", Color) = (0,0,0,1)
        [Toggle(_)] _ScreenSpaceOutline ("Screen-Space Outline", Float ) = 0
		[Enum(Normal,8,Outer Only,6)] _OutlineStencilComp ("Outline Mode", Float) = 8
        _Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
		[Enum(Both,0,Front,2,Back,1)] _Cull("Sidedness", Float) = 2
		_VertexOffset ("Vertex Offset", Vector) = (0,0,0,0)
		_VertexRotation ("Local Rotation", Vector) = (0,0,0,0)
		_VertexScale ("Scale", Vector) = (1,1,1,1)
		[NoScaleOffset] _RampMaskTex ("Ramp Mask", 2D) = "black"
		[NoScaleOffset] _RampR ("Ramp (R)", 2D) = "white" {}
		_ToonContrastR ("Toon Contrast (R)", Range(0, 1)) = 0.25
        _IntensityR ("Intensity (R)", Range(0, 10)) = 0.8
        _SaturationR ("Saturation (R)", Range(0, 1)) = 0.65
		[NoScaleOffset] _RampG ("Ramp (G)", 2D) = "white" {}
		_ToonContrastG ("Toon Contrast (G)", Range(0, 1)) = 0.25
        _IntensityG ("Intensity (G)", Range(0, 10)) = 0.8
        _SaturationG ("Saturation (G)", Range(0, 1)) = 0.65
		[NoScaleOffset] _RampB ("Ramp (B)", 2D) = "white" {}
		_ToonContrastB ("Toon Contrast (B)", Range(0, 1)) = 0.25
        _IntensityB ("Intensity (B)", Range(0, 10)) = 0.8
        _SaturationB ("Saturation (B)", Range(0, 1)) = 0.65
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
			
			Stencil {
				Ref 8
				Comp Always
				Pass Replace
			}
            
			Cull [_Cull]            
            
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
			float4 _VertexOffset;
			
			float _OverrideWorldLight;
			
			uniform sampler2D _RampMaskTex;
			uniform sampler2D _RampR;
			uniform float _ToonContrastR;	
			uniform sampler2D _RampG;
			uniform float _ToonContrastG;
			uniform sampler2D _RampB;
			uniform float _ToonContrastB;
			
			uniform float _IntensityR;
			uniform float _SaturationR;
			uniform float _IntensityG;
			uniform float _SaturationG;
			uniform float _IntensityB;
			uniform float _SaturationB;			
            
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

			float _WorldLightIntensity;
			float4 _VertexRotation;
			float4 _VertexScale;

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

			inline float3x3 xRotation3dRadians(float rad) {
				float s = sin(rad);
				float c = cos(rad);
				return float3x3(
					1, 0, 0,
					0, c, s,
					0, -s, c);
			}
			 
			inline float3x3 yRotation3dRadians(float rad) {
				float s = sin(rad);
				float c = cos(rad);
				return float3x3(
					c, 0, -s,
					0, 1, 0,
					s, 0, c);
			}
			 
			inline float3x3 zRotation3dRadians(float rad) {
				float s = sin(rad);
				float c = cos(rad);
				return float3x3(
					c, s, 0,
					-s, c, 0,
					0, 0, 1);
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
				float4 lightDir : TEXCOORD7; // AutoLight took 5 already
				LIGHTING_COORDS(5,6)
			};

			VertexOutput vert (VertexInput v) {

				//Apply scale
				v.vertex *= _VertexScale;

				// Apply rotation
				float3 vertexPos = v.vertex.xyz;
				vertexPos = mul(xRotation3dRadians(radians(_VertexRotation.x)), vertexPos);
				vertexPos = mul(yRotation3dRadians(radians(_VertexRotation.y)), vertexPos);
				vertexPos = mul(zRotation3dRadians(radians(_VertexRotation.z)), vertexPos);
				v.vertex = float4(vertexPos, v.vertex.w);
				
				//Apply offset
				v.vertex += _VertexOffset;

				VertexOutput o = (VertexOutput)0;
				o.uv0 = v.texcoord0;
				o.normalDir = UnityObjectToWorldNormal(v.normal);
				o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
				o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
				o.posWorld = mul(unity_ObjectToWorld, v.vertex);
				float3 lightColor = _LightColor0.rgb;
				
				o.pos = UnityObjectToClipPos(v.vertex);
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
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float SurfaceAlpha = _MainTex_var.a;
                clip(SurfaceAlpha - _Cutoff);
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i) / SHADOW_ATTENUATION(i);
////// Emissive:
                float4 _EmissionMap_var = tex2D(_EmissionMap,TRANSFORM_TEX(i.uv0, _EmissionMap));
                float3 MappedEmissive = (_EmissionMap_var.rgb*_Emission);
                float3 emissive = MappedEmissive;
                float3 FlatLighting = saturate((Function_node_3693( float3(0,1,0) )+(_LightColor0.rgb*attenuation)));
                float3 MappedTexture = (_MainTex_var.rgb*_Color.rgb);
				
				// Masking for saturation and intensity
				float SaturationVar;
				float IntensityVar;
				float4 maskColor = tex2D(_RampMaskTex,TRANSFORM_TEX(i.uv0, _MainTex));
				if(maskColor.r > 0.5) {
					SaturationVar = _SaturationR;
					IntensityVar = _IntensityR;
				} else if(maskColor.g > 0.5) {
					SaturationVar = _SaturationG;
					IntensityVar = _IntensityG;
				} else if(maskColor.b > 0.5) {
					SaturationVar = _SaturationB;
					IntensityVar = _IntensityB;
				} else {				
					SaturationVar = _Saturation;
					IntensityVar = _Intensity;
				}
				
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
				
				//Ramping
                float4 node_9498;
				float ToonContrast_var;
				if(maskColor.r > 0.5) {
					node_9498 = tex2D(_RampR,TRANSFORM_TEX(node_8091, _Ramp));
					ToonContrast_var = _ToonContrastR;
				} else if(maskColor.g > 0.5) {
					node_9498 = tex2D(_RampG,TRANSFORM_TEX(node_8091, _Ramp));
					ToonContrast_var = _ToonContrastG;
				} else if(maskColor.b > 0.5) {
					node_9498 = tex2D(_RampB,TRANSFORM_TEX(node_8091, _Ramp));
					ToonContrast_var = _ToonContrastB;
				} else {				
					node_9498 = tex2D(_Ramp,TRANSFORM_TEX(node_8091, _Ramp));
					ToonContrast_var = _ToonContrast;
				}
				
                float3 StaticToonLighting = node_9498.rgb;
                float3 finalColor = emissive + saturate(((IntensityVar*FlatLighting*Diffuse) > 0.5 ?  (1.0-(1.0-2.0*((IntensityVar*FlatLighting*Diffuse)-0.5))*(1.0-lerp(float3(node_424,node_424,node_424),StaticToonLighting,ToonContrast_var))) : (2.0*(IntensityVar*FlatLighting*Diffuse)*lerp(float3(node_424,node_424,node_424),StaticToonLighting,ToonContrast_var))) );
                return fixed4(finalColor,1);
            }
            ENDCG
        }
		
        Pass {
            Name "Outline"
            Tags {
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
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #include "AutoLight.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _OutlineWidth;
            uniform fixed _ScreenSpaceOutline;
            uniform float4 _OutlineColor;
			
			float _Cutoff;
			
			float _OverrideWorldLight;
			
			float4 _VertexOffset;
			float4 _VertexRotation;
			float4 _VertexScale;
			
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
            };
			
			inline float3x3 xRotation3dRadians(float rad) {
				float s = sin(rad);
				float c = cos(rad);
				return float3x3(
					1, 0, 0,
					0, c, s,
					0, -s, c);
			}
			 
			inline float3x3 yRotation3dRadians(float rad) {
				float s = sin(rad);
				float c = cos(rad);
				return float3x3(
					c, 0, -s,
					0, 1, 0,
					s, 0, c);
			}
			 
			inline float3x3 zRotation3dRadians(float rad) {
				float s = sin(rad);
				float c = cos(rad);
				return float3x3(
					c, s, 0,
					-s, c, 0,
					0, 0, 1);
			}
			
            VertexOutput vert (VertexInput v) {
			
				//Apply scale
				v.vertex *= _VertexScale;

				// Apply rotation
				float3 vertexPos = v.vertex.xyz;
				vertexPos = mul(xRotation3dRadians(radians(_VertexRotation.x)), vertexPos);
				vertexPos = mul(yRotation3dRadians(radians(_VertexRotation.y)), vertexPos);
				vertexPos = mul(zRotation3dRadians(radians(_VertexRotation.z)), vertexPos);
				v.vertex = float4(vertexPos, v.vertex.w);
				
				//Apply offset
				v.vertex += _VertexOffset;
			
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float node_8257 = (_OutlineWidth*0.001);
                float OutlineScale = lerp( node_8257, (distance(_WorldSpaceCameraPos,mul(unity_ObjectToWorld, v.vertex).rgb)*node_8257), _ScreenSpaceOutline );
                o.pos = UnityObjectToClipPos( float4(v.vertex.xyz + v.normal*OutlineScale,1));
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float SurfaceAlpha = _MainTex_var.a;
                float node_7192 = SurfaceAlpha;
                clip(node_7192 - _Cutoff);
                return fixed4(_OutlineColor.rgb,0);
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
			float4 _VertexOffset;
			
			float _OverrideWorldLight;
			
			uniform sampler2D _RampMaskTex;
			uniform sampler2D _RampR;
			uniform float _ToonContrastR;	
			uniform sampler2D _RampG;
			uniform float _ToonContrastG;
			uniform sampler2D _RampB;
			uniform float _ToonContrastB;
			
			uniform float _IntensityR;
			uniform float _SaturationR;
			uniform float _IntensityG;
			uniform float _SaturationG;
			uniform float _IntensityB;
			uniform float _SaturationB;
            
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
			
			float _WorldLightIntensity;
			float4 _VertexRotation;
			float4 _VertexScale;

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

			inline float3x3 xRotation3dRadians(float rad) {
				float s = sin(rad);
				float c = cos(rad);
				return float3x3(
					1, 0, 0,
					0, c, s,
					0, -s, c);
			}
			 
			inline float3x3 yRotation3dRadians(float rad) {
				float s = sin(rad);
				float c = cos(rad);
				return float3x3(
					c, 0, -s,
					0, 1, 0,
					s, 0, c);
			}
			 
			inline float3x3 zRotation3dRadians(float rad) {
				float s = sin(rad);
				float c = cos(rad);
				return float3x3(
					c, s, 0,
					-s, c, 0,
					0, 0, 1);
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
				float4 lightDir : TEXCOORD7; // AutoLight took 5 already
				LIGHTING_COORDS(5,6)
			};

			VertexOutput vert (VertexInput v) {

				//Apply scale
				v.vertex *= _VertexScale;

				// Apply rotation
				float3 vertexPos = v.vertex.xyz;
				vertexPos = mul(xRotation3dRadians(radians(_VertexRotation.x)), vertexPos);
				vertexPos = mul(yRotation3dRadians(radians(_VertexRotation.y)), vertexPos);
				vertexPos = mul(zRotation3dRadians(radians(_VertexRotation.z)), vertexPos);
				v.vertex = float4(vertexPos, v.vertex.w);
				
				//Apply offset
				v.vertex += _VertexOffset;

				VertexOutput o = (VertexOutput)0;
				o.uv0 = v.texcoord0;
				o.normalDir = UnityObjectToWorldNormal(v.normal);
				o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
				o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
				o.posWorld = mul(unity_ObjectToWorld, v.vertex);
				float3 lightColor = _LightColor0.rgb;
				
				o.pos = UnityObjectToClipPos(v.vertex);
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
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float SurfaceAlpha = _MainTex_var.a;
                clip(SurfaceAlpha - _Cutoff);
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i) / SHADOW_ATTENUATION(i);
                float3 FlatLighting = saturate((Function_node_3693( float3(0,1,0) )+(_LightColor0.rgb*attenuation)));
                float3 MappedTexture = (_MainTex_var.rgb*_Color.rgb);
				
				// Masking for saturation and intensity
				float SaturationVar;
				float IntensityVar;
				float4 maskColor = tex2D(_RampMaskTex,TRANSFORM_TEX(i.uv0, _MainTex));
				if(maskColor.r > 0.5) {
					SaturationVar = _SaturationR;
					IntensityVar = _IntensityR;
				} else if(maskColor.g > 0.5) {
					SaturationVar = _SaturationG;
					IntensityVar = _IntensityG;
				} else if(maskColor.b > 0.5) {
					SaturationVar = _SaturationB;
					IntensityVar = _IntensityB;
				} else {				
					SaturationVar = _Saturation;
					IntensityVar = _Intensity;
				}
				
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
				
				//Ramping
                float4 node_9498;
				float ToonContrast_var;
				if(maskColor.r > 0.5) {
					node_9498 = tex2D(_RampR,TRANSFORM_TEX(node_8091, _Ramp));
					ToonContrast_var = _ToonContrastR;
				} else if(maskColor.g > 0.5) {
					node_9498 = tex2D(_RampG,TRANSFORM_TEX(node_8091, _Ramp));
					ToonContrast_var = _ToonContrastG;
				} else if(maskColor.b > 0.5) {
					node_9498 = tex2D(_RampB,TRANSFORM_TEX(node_8091, _Ramp));
					ToonContrast_var = _ToonContrastB;
				} else {				
					node_9498 = tex2D(_Ramp,TRANSFORM_TEX(node_8091, _Ramp));
					ToonContrast_var = _ToonContrast;
				}
				
                float3 StaticToonLighting = node_9498.rgb;
                float3 finalColor = saturate(((IntensityVar*FlatLighting*Diffuse) > 0.5 ?  (1.0-(1.0-2.0*((IntensityVar*FlatLighting*Diffuse)-0.5))*(1.0-lerp(float3(node_424,node_424,node_424),StaticToonLighting,ToonContrast_var))) : (2.0*(IntensityVar*FlatLighting*Diffuse)*lerp(float3(node_424,node_424,node_424),StaticToonLighting,ToonContrast_var))) );
                return fixed4(finalColor * 1,0);
            }
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1
            
			Cull [_Cull]
            
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
			float4 _VertexOffset;

			float4 _VertexRotation;
			float4 _VertexScale;

			inline float3x3 xRotation3dRadians(float rad) {
				float s = sin(rad);
				float c = cos(rad);
				return float3x3(
					1, 0, 0,
					0, c, s,
					0, -s, c);
			}
			 
			inline float3x3 yRotation3dRadians(float rad) {
				float s = sin(rad);
				float c = cos(rad);
				return float3x3(
					c, 0, -s,
					0, 1, 0,
					s, 0, c);
			}
			 
			inline float3x3 zRotation3dRadians(float rad) {
				float s = sin(rad);
				float c = cos(rad);
				return float3x3(
					c, s, 0,
					-s, c, 0,
					0, 0, 1);
			}

			//Shadowcaster functions
			struct VertexInputShadow {
				float4 vertex : POSITION;
				float2 texcoord0 : TEXCOORD0;
			};
			struct VertexOutputShadow {
				V2F_SHADOW_CASTER;
				float2 uv0 : TEXCOORD1;
			};

			VertexOutputShadow vertShadow (VertexInputShadow v) {

				//Apply scale
				v.vertex *= _VertexScale;

				// Apply rotation
				float3 vertexPos = v.vertex.xyz;
				vertexPos = mul(xRotation3dRadians(radians(_VertexRotation.x)), vertexPos);
				vertexPos = mul(yRotation3dRadians(radians(_VertexRotation.y)), vertexPos);
				vertexPos = mul(zRotation3dRadians(radians(_VertexRotation.z)), vertexPos);
				v.vertex = float4(vertexPos, v.vertex.w);
				v.vertex += _VertexOffset;

				VertexOutputShadow o = (VertexOutputShadow)0;
				o.uv0 = v.texcoord0;				
				o.pos = UnityObjectToClipPos(v.vertex);
				TRANSFER_SHADOW_CASTER(o)
				return o;
			}
			float4 fragShadow(VertexOutputShadow i, float facing : VFACE) : COLOR {
				float isFrontFace = ( facing >= 0 ? 1 : 0 );
				float faceSign = ( facing >= 0 ? 1 : -1 );
				float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
				float SurfaceAlpha = _MainTex_var.a;
				clip(SurfaceAlpha - _Cutoff);
				SHADOW_CASTER_FRAGMENT(i)
			}

            ENDCG
        }
        Pass {
            Name "Meta"
            Tags {
                "LightMode"="Meta"
            }
            
			Cull [_Cull]
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_META 1
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #include "UnityMetaPass.cginc"
            #include "AutoLight.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _EmissionMap; uniform float4 _EmissionMap_ST;
            uniform float _Emission;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST );
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : SV_Target {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                UnityMetaInput o;
                UNITY_INITIALIZE_OUTPUT( UnityMetaInput, o );
                
                float4 _EmissionMap_var = tex2D(_EmissionMap,TRANSFORM_TEX(i.uv0, _EmissionMap));
                float3 MappedEmissive = (_EmissionMap_var.rgb*_Emission);
                o.Emission = MappedEmissive;
                
                float3 diffColor = float3(0,0,0);
                o.Albedo = diffColor;
                
                return UnityMetaFragment( o );
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
