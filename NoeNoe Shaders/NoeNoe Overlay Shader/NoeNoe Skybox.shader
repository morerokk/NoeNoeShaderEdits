Shader "NoeNoe/NoeNoe Overlay Shader/Misc/NoeNoe Skybox" {
    Properties {
        [HDR] _Color ("Color", Color) = (1,1,1,1)
        [Toggle(_PANO_ON)] _PanoEnabled ("Enable Panosphere", Int) = 1
        _TileOverlay ("Tile Overlay", 2D) = "white" {}
        _TileSpeedX ("Tile Speed X", Range(-1, 1)) = 0
        _TileSpeedY ("Tile Speed Y", Range(-1, 1)) = 0
        [Toggle(_CUBEMAP_ON)] _CubemapEnabled ("Enable Cubemap", Int) = 1
        [NoScaleOffset] _CubemapOverlay ("Cubemap Overlay", Cube) = "_Skybox" {}
        _CubemapRotation ("Cubemap Initial Rotation", Vector) = (0,0,0,0)
        _CubemapRotationSpeed ("Cubemap Rotation Speed", Vector) = (0,0,0,0)
        _CrossfadeTileCubemap ("Crossfade Tile / Cubemap", Range(0, 1)) = 1
        _Saturation ("Saturation", Range(0, 2)) = 1
        [Enum(Both,0,Front,2,Back,1)] _Cull("Sidedness", Float) = 1
    }
    SubShader {
        Tags {
            "Queue"="Background"
            "RenderType"="Background"
            "PreviewType"="Skybox"
        }
        Pass {            
            Cull [_Cull]
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma shader_feature_local _PANO_ON
            #pragma shader_feature_local _CUBEMAP_ON
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
            
            float3 VRWorldSpaceCameraPos()
            {
                #if defined(USING_STEREO_MATRICES)
                    return lerp(unity_StereoWorldSpaceCameraPos[0], unity_StereoWorldSpaceCameraPos[1], 0.5);
                #else
                    return _WorldSpaceCameraPos;
                #endif
            }
            
            float2 PanoProjection(float3 coords)
            {
                float3 normalizedCoords = normalize(coords);
                float latitude = acos(normalizedCoords.y);
                float longitude = atan2(normalizedCoords.z, normalizedCoords.x);
                float2 sphereCoords = float2(longitude, latitude) * float2(0.5/UNITY_PI, 1.0/UNITY_PI);
                sphereCoords = float2(0.5,1.0) - sphereCoords;
                return (sphereCoords + float4(0, 1-unity_StereoEyeIndex,1,0.5).xy) * float4(0, 1-unity_StereoEyeIndex,1,0.5).zw;
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
                float3 viewDirection = normalize(VRWorldSpaceCameraPos() - i.posWorld.xyz);
                
                #if defined(_PANO_ON)
                    // Get pano overlay
                    float2 panoUV = PanoProjection(-viewDirection);
                    float2 ddxuv = ddx(panoUV);
                    float2 ddyuv = ddy(panoUV);
                    if(any(fwidth(panoUV) > .5))
                    {
                        ddxuv = ddyuv = 0.001;
                    }
                    
                    panoUV += float2(_TileSpeedX * _Time.y, _TileSpeedY * _Time.y);
                    float4 panoOverlay = tex2D(_TileOverlay, TRANSFORM_TEX(panoUV, _TileOverlay), ddxuv, ddyuv);
                #endif
                
                #if defined(_CUBEMAP_ON)
                    // Get cubemap overlay
                    float4 cubeRotation = _CubemapRotation + (_CubemapRotationSpeed * _Time.y);
                    float3 RotatedCubemapDirection = CubemapRotator(-viewDirection, cubeRotation.x, cubeRotation.y + 180, cubeRotation.z);
                
                    // sample the cubemap texture
                    float4 cubeOverlay = texCUBE(_CubemapOverlay, RotatedCubemapDirection);
                #endif
                
                // Mix panosphere and cubemap together
                #if defined(_PANO_ON) && defined(_CUBEMAP_ON)
                    float4 col = lerp(panoOverlay, cubeOverlay, _CrossfadeTileCubemap);
                #elif defined(_PANO_ON)
                    float4 col = panoOverlay;
                #elif defined(_CUBEMAP_ON)
                    float4 col = cubeOverlay;
                #else
                    // This condition should only be temporary
                    float4 col = float4(1,1,1,1);
                #endif
                
                // Apply saturation
                float desaturated = Luminance(col);
                col.xyz = lerp(float3(desaturated, desaturated, desaturated), col.xyz, _Saturation);
                
                // Apply color/intensity
                col *= _Color;
                
                return col;
            }
            ENDCG
        }
    }
}
