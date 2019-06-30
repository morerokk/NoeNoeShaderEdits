Shader "NoeNoe/NoeNoe Overlay Shader/Misc/NoeNoe Skybox" {
    Properties {
        _Color ("Color", Color) = (1,1,1,1)
        _TileOverlay ("Tile Overlay", 2D) = "white" {}
        _TileSpeedX ("Tile Speed X", Range(-1, 1)) = 0
        _TileSpeedY ("Tile Speed Y", Range(-1, 1)) = 0
        _CubemapOverlay ("Cubemap Overlay", Cube) = "_Skybox" {}
		_CubemapRotation ("Cubemap Initial Rotation", Vector) = (0,0,0,0)
        _CubemapRotationSpeed ("Cubemap Rotation Speed", Vector) = (0,0,0,0)
        _CrossfadeTileCubemap ("Crossfade Tile / Cubemap", Range(0, 2)) = 2
        _Intensity ("Intensity", Range(0, 10)) = 0.8
        _Saturation ("Saturation", Range(0, 1)) = 0.65
		[Enum(Both,0,Front,2,Back,1)] _Cull("Sidedness", Float) = 1
    }
    SubShader {
        Tags {
            "Queue"="Background"
            "RenderType"="Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
			Cull [_Cull]
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float4 _Color;
            uniform sampler2D _TileOverlay; uniform float4 _TileOverlay_ST;
            uniform float _TileSpeedX;
            uniform float _TileSpeedY;
            uniform samplerCUBE _CubemapOverlay;
            uniform float _CrossfadeTileCubemap;
            uniform float _Intensity;
            uniform float _Saturation;
			
            float3 CubemapRotator( float3 Dir , float AngX , float AngY , float AngZ )
			{
				AngX = radians(AngX);
				AngY = radians(AngY);
				AngZ = radians(AngZ);
				
				float3x3 rotationX ={float3(1.0,0.0,0.0),
											float3(0.0,cos(AngX),-sin(AngX)),
											float3(0.0,sin(AngX),cos(AngX))};
				float3 Val = mul(Dir, rotationX);
				
				float3x3 rotationY ={float3(cos(AngY),0.0,sin(AngY)),
											float3(0.0,1.0,0.0),
											float3(-sin(AngY),0.0,cos(AngY))};
				Val = mul(Val, rotationY);
				
				float3x3 rotationZ ={float3(cos(AngZ),-sin(AngZ),0.0),
											float3(sin(AngZ),cos(AngZ),0.0),
											float3(0.0,0.0,1.0)};
				Val = mul(Val, rotationZ);
				
				return Val;
            }
            
            uniform float4 _CubemapRotationSpeed;
            uniform float4 _CubemapRotation;
            struct VertexInput {
                float4 vertex : POSITION;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
////// Lighting:
                float FlatLighting = 1.0;
                float node_6078 = 1.0;
                float3 VRDirection = viewDirection;
                float3 node_769 = VRDirection.rgb;
                float4 node_47 = _Time;
                float3 node_5198 = (_CubemapRotationSpeed.rgb*node_47.g).rgb;
				
				//Apply time rotation
                float3 RotatedCubemapDirection = CubemapRotator( float3(node_769.r,(node_769.g*(-1.0)),node_769.b) , node_5198.r , node_5198.g , node_5198.b );
				//Apply initial rotation
				RotatedCubemapDirection = CubemapRotator( float3(node_769.r,(node_769.g*(-1.0)),node_769.b) , _CubemapRotation.x, _CubemapRotation.y, _CubemapRotation.z);
				
                float OverlayCrossfade = _CrossfadeTileCubemap;
                float node_640 = OverlayCrossfade;
                float node_9795 = 0.1;
                float3 node_4810 = VRDirection.brg;
                float2 ViewDirUVs = (1.0 - float2(((atan2(node_4810.r,node_4810.g)/6.28318530718)+0.5),(acos(node_4810.b)/(-1*3.141592654)))).rg;
                float2 TileUVs = ((float2((node_9795*_TileSpeedX),(node_9795*_TileSpeedY))*node_47.g)+ViewDirUVs);
                float2 node_6429 = TileUVs;
                float4 _TileOverlay_var = tex2D(_TileOverlay,TRANSFORM_TEX(node_6429, _TileOverlay));
                float3 Overlay = (lerp(float3(node_6078,node_6078,node_6078),(texCUBE(_CubemapOverlay,RotatedCubemapDirection).rgb*1.0),saturate(node_640))*lerp(float3(node_6078,node_6078,node_6078),_TileOverlay_var.rgb,saturate((node_6078+(1.0 - node_640)))));
                float3 MappedTexture = (Overlay*_Color.rgb);
                float3 Diffuse = lerp(lerp(MappedTexture,dot(MappedTexture,float3(0.3,0.59,0.11)),(-0.5)),dot(lerp(MappedTexture,dot(MappedTexture,float3(0.3,0.59,0.11)),(-0.5)),float3(0.3,0.59,0.11)),(1.0 - _Saturation));
                float3 finalColor = (_Intensity*FlatLighting*Diffuse);
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
}
