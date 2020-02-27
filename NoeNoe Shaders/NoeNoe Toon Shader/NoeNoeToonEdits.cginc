// Add macros for shadowless light attenuation
#ifdef POINT
    #define SHADOWLESS_LIGHT_ATTENUATION(a) (tex2D(_LightTexture0, dot(a._LightCoord,a._LightCoord).rr).r)
#endif

#ifdef SPOT
    #define SHADOWLESS_LIGHT_ATTENUATION(a) ( (a._LightCoord.z > 0) * UnitySpotCookie(a._LightCoord) * UnitySpotAttenuate(a._LightCoord.xyz))
#endif

#ifdef DIRECTIONAL
    #define SHADOWLESS_LIGHT_ATTENUATION(a) 1
#endif

#ifdef POINT_COOKIE
    #define SHADOWLESS_LIGHT_ATTENUATION(a) (tex2D(_LightTextureB0, dot(a._LightCoord,a._LightCoord).rr).r * texCUBE(_LightTexture0, a._LightCoord).w)
#endif

#ifdef DIRECTIONAL_COOKIE
    #define SHADOWLESS_LIGHT_ATTENUATION(a) (tex2D(_LightTexture0, a._LightCoord).w)
#endif

float _WorldLightIntensity;
float _ReceiveShadows;
float3 _EmissionColor;
float _Exposure;
float _ExposureContrast;

#ifdef NOENOETOON_RAMP_MASKING
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
#endif

#ifdef _METALLICGLOSSMAP
    sampler2D _MetallicGlossMap;
#endif

float _Metallic;
float _Glossiness;

#ifdef _SPECGLOSSMAP
    // float4 _SpecColor is already defined somewhere
    sampler2D _SpecGlossMap;
#endif

#if defined(_MATCAP_ADD) || defined(_MATCAP_MULTIPLY)
    sampler2D _MatCap;
    float _MatCapStrength;
#endif

#if defined(_PANO_ON) || defined(_CUBEMAP_ON)
    float _OverlayStrength;
    float _CrossfadeTileCubemap;
    float _OverlayMode;
    
    #ifdef _PANO_ON
        sampler2D _TileOverlay;
        float4 _TileOverlay_ST;
        float _TileSpeedX;
        float _TileSpeedY;
    #endif
    
    #ifdef _CUBEMAP_ON
        samplerCUBE _CubemapOverlay;
        float4 _CubemapRotation;
        float4 _CubemapRotationSpeed;
    #endif
#endif

#if defined(_RIMLIGHT_ADD) || defined(_RIMLIGHT_MIX)
    sampler2D _RimTex;
    float4 _RimLightColor;
    float _RimLightMode;
    float _RimWidth;
    float _RimInvert;
#endif

float3 GIsonarDirection()
{
    return Unity_SafeNormalize(unity_SHAr.xyz + unity_SHAg.xyz + unity_SHAb.xyz);
}

float4 lightDirection(float4 fallback)
{
    // Try to get world light direction from realtime directional light.
    float4 worldLightDir = _WorldSpaceLightPos0 * _WorldLightIntensity;
    if(all(worldLightDir.xyz == 0))
    {
        // No realtime directional lights. Try to use GI Sonar.
        float3 sonar = GIsonarDirection();
        UNITY_FLATTEN
        if(all(sonar == float3(0,0,0)))
        {
            worldLightDir = fallback;
        }
        else
        {
            worldLightDir = float4(sonar, 0);
            worldLightDir *= _WorldLightIntensity;
        }
    }
    return worldLightDir;
}

float3 FlatLightSH(float3 normal)
{
    return ShadeSH9(float4(normal, 1.0));
}

half2 matcapSample(half3 worldUp, half3 viewDirection, half3 normalDirection)
{
    half3 worldViewUp = normalize(worldUp - viewDirection * dot(viewDirection, worldUp));
    half3 worldViewRight = normalize(cross(viewDirection, worldViewUp));
    half2 matcapUV = half2(dot(worldViewRight, normalDirection), dot(worldViewUp, normalDirection)) * 0.5 + 0.5;
    return matcapUV;                
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
    LIGHTING_COORDS(5,6)
};

VertexOutput vert (VertexInput v) {
    VertexOutput o = (VertexOutput)0;
    o.uv0 = v.texcoord0;
    o.normalDir = UnityObjectToWorldNormal(v.normal);
    o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
    o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
    o.posWorld = mul(unity_ObjectToWorld, v.vertex);
    float3 lightColor = _LightColor0.rgb;
    
    o.pos = UnityObjectToClipPos(v.vertex);
    TRANSFER_VERTEX_TO_FRAGMENT(o)
    return o;
}

float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
    float isFrontFace = ( facing >= 0 ? 1 : 0 );
    float faceSign = ( facing >= 0 ? 1 : -1 );
    
    float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);

    #if defined(_OVERRIDE_WORLD_LIGHT_DIR_ON)
        float4 staticLightDir = _StaticToonLight;
    #else
        // If point or spot light, calculate the light direction from its position
        // If the light is directional or the current pass is forwardbase, grab _WorldSpaceLightPos0 as light direction
        #if defined(UNITY_PASS_FORWARDADD) && !defined(DIRECTIONAL)
            float4 staticLightDir = float4(normalize(_WorldSpaceLightPos0.xyz - i.posWorld.xyz), 0) * _WorldLightIntensity;
        #else
            float4 staticLightDir = lightDirection(_StaticToonLight);
        #endif
    #endif
    
    i.normalDir = normalize(i.normalDir);
    i.normalDir *= faceSign;
    
    float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
    #if defined(_NORMALMAP)
        float3 _NormalMap_var = UnpackNormal(tex2D(_NormalMap,TRANSFORM_TEX(i.uv0, _NormalMap)));
    #else
        float3 _NormalMap_var = UnpackNormal(float4(0.5, 0.5, 1, 1));
    #endif
    float3 normalLocal = _NormalMap_var.rgb;
    float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
    
    //Turn texture property into variable
    #ifdef NOENOETOON_OUTLINE_PASS
        sampler2D mainTexture = _OutlineTex;
        float4 mainTexture_ST = _OutlineTex_ST;
        float4 mainColor = _OutlineColor;
    #else
        sampler2D mainTexture = _MainTex;
        float4 mainTexture_ST = _MainTex_ST;
        float4 mainColor = _Color;
    #endif
    
    float4 _MainTex_var = tex2D(mainTexture,TRANSFORM_TEX(i.uv0, mainTexture));
    float SurfaceAlpha = _MainTex_var.a;
    
    #if defined(_ALPHATEST_ON)
        #ifdef NOENOETOON_OUTLINE_PASS
            // Only clip if outline cutout is on
            clip(SurfaceAlpha - _Cutoff + (1 - _OutlineCutout));
        #else
            clip(SurfaceAlpha - _Cutoff);
        #endif
    #endif
    
    float3 lightColor = _LightColor0.rgb;
////// Lighting:

    #if defined(_SHADOW_RECEIVE_ON)
        UNITY_LIGHT_ATTENUATION(attenuation, i, i.posWorld.xyz);
    #else
        // Disable shadow receiving entirely
        float attenuation = SHADOWLESS_LIGHT_ATTENUATION(i);
    #endif
    
    #if defined(_LIGHTING_PBR_ON)
        // Somewhat incorrect "PBR"-ish lighting, use normals to sample SH
        float3 FlatLighting = FlatLightSH(normalDirection) + (_LightColor0.rgb * attenuation * _Exposure);
    #elif defined(_LIGHTING_LEGACY_ON)
        // Old lighting, sample SH from upwards, add LightColor0, clamp to 0-1
        float3 FlatLighting = saturate(FlatLightSH(float3(0,1,0))+(_LightColor0.rgb*attenuation));
    #else
        // Regular toon lighting, sample ambient SH, add LightColor0 to a lesser extent
        float3 FlatLighting = FlatLightSH(float3(0,0,0)) + (_LightColor0.rgb * attenuation * _Exposure);
        
        // In ForwardBase, add vertex lights
        #if defined(VERTEXLIGHT_ON) && defined(UNITY_PASS_FORWARDBASE)
            FlatLighting += Shade4PointLights(
                unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
                unity_LightColor[0].rgb, unity_LightColor[1].rgb,
                unity_LightColor[2].rgb, unity_LightColor[3].rgb,
                unity_4LightAtten0, i.posWorld, normalDirection
            ) * _Exposure;
        #endif
    #endif
    
    float3 MappedTexture = (_MainTex_var.rgb*mainColor.rgb);
    
    #ifdef NOENOETOON_RAMP_MASKING
        // Masking for saturation and intensity
        float SaturationVar;
        float IntensityVar;
        float4 maskColor = tex2D(_RampMaskTex,TRANSFORM_TEX(i.uv0, mainTexture));
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
    #else
        float SaturationVar = _Saturation;
        float IntensityVar = _Intensity;
    #endif
    
    float3 Diffuse = lerp(lerp(MappedTexture,dot(MappedTexture,float3(0.3,0.59,0.11)),(-0.5)),dot(lerp(MappedTexture,dot(MappedTexture,float3(0.3,0.59,0.11)),(-0.5)),float3(0.3,0.59,0.11)),(1.0 - SaturationVar));
    
    // Matcap
    #if defined(_MATCAP_ADD) || defined(_MATCAP_MULTIPLY)
        half3 upVector = half3(0,1,0);
        half2 matcapUv = matcapSample(upVector, viewDirection, normalDirection);
        float4 matcapCol = tex2D(_MatCap, matcapUv);
        
        #if defined(_MATCAP_ADD)
            float3 matcapResult = Diffuse + matcapCol.rgb;
        #else
            float3 matcapResult = Diffuse * matcapCol.rgb;
        #endif
        
        Diffuse = lerp(Diffuse, matcapResult, _MatCapStrength);
    #endif
    
    // Rimlight
    #if defined(_RIMLIGHT_ADD) || defined(_RIMLIGHT_MIX)
        float rim = 1.0 - saturate(dot(normalize(viewDirection), normalDirection));
        if(_RimInvert == 1)
        {
            rim = 1 - rim;
        }
        
        float4 rimTex = tex2D(_RimTex, TRANSFORM_TEX(i.uv0, mainTexture));
        rimTex *= _RimLightColor;
        
        float3 rimColor = rimTex.rgb * smoothstep(1 - _RimWidth, 1.0, rim);
        
        #if defined(_RIMLIGHT_ADD)
            Diffuse += (rimColor * rimTex.a);
        #else   
            Diffuse = lerp(Diffuse, rimColor, rim * rimTex.a);
        #endif
    #endif
    
    // Overlay
    #if defined(_PANO_ON) || defined(_CUBEMAP_ON)
        // Get a flat view direction for panospheres and cubemaps, so they can appear infinitely far away.
        float3 flatViewDirection = VRWorldSpaceCameraPos() - i.posWorld.xyz;
    #endif
    
    #if defined(_PANO_ON)
        float2 panoUV = PanoProjection(-flatViewDirection);
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
        float4 cubeRotation = _CubemapRotation + (_CubemapRotationSpeed * _Time.y);
        float3 RotatedCubemapDirection = CubemapRotator(-flatViewDirection, cubeRotation.x, cubeRotation.y + 180, cubeRotation.z);
        float4 cubeOverlay = texCUBE(_CubemapOverlay, RotatedCubemapDirection);
    #endif
    
    // Combine panosphere and cubemaps, then combine that with the diffuse
    #if defined(_PANO_ON) || defined(_CUBEMAP_ON)
        //Create overlay depending on which mode(s) are on
        #if defined(_PANO_ON) && defined(_CUBEMAP_ON) //Both are on
            // Mix pano and cubemap overlays
            float3 overlay = lerp(panoOverlay.rgb, cubeOverlay.rgb, _CrossfadeTileCubemap);
        #elif defined(_PANO_ON) // Only pano is on
            float3 overlay = panoOverlay.rgb;
        #else // Only cubemap is on
            float3 overlay = cubeOverlay.rgb;
        #endif
        
        // Combine with diffuse
        // Allow switching between Replace and Multiply modes
        float3 overlayResult = Diffuse * overlay;
        overlayResult = lerp(overlay, overlayResult, _OverlayMode);
        
        Diffuse = lerp(Diffuse, overlayResult, _OverlayStrength);
    #endif
    
    //Reflections
    
    //Metallic
    #if defined(_METALLICGLOSSMAP)
        //Metallic workflow
        float4 metallicTex = tex2D(_MetallicGlossMap, TRANSFORM_TEX(i.uv0, mainTexture));
        float metallic = metallicTex.r * _Metallic;
        
        #ifdef UNITY_PASS_FORWARDBASE
            //Unlit reflections in ForwardBase
            float roughness = 1 - (metallicTex.a * _Glossiness);
            roughness *= 1.7 - 0.7 * roughness;
            
            float3 reflectedDir = reflect(-viewDirection, normalDirection);
            
            float3 reflectionColor;
            
            //Sample second probe if available.
            float interpolator = unity_SpecCube0_BoxMin.w;
            UNITY_BRANCH
            if(interpolator < 0.99999)
            {
                //Probe 1
                float4 reflectionData0 = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, reflectedDir, roughness * UNITY_SPECCUBE_LOD_STEPS);
                float3 reflectionColor0 = DecodeHDR(reflectionData0, unity_SpecCube0_HDR);

                //Probe 2
                float4 reflectionData1 = UNITY_SAMPLE_TEXCUBE_SAMPLER_LOD(unity_SpecCube1, unity_SpecCube0, reflectedDir, roughness * UNITY_SPECCUBE_LOD_STEPS);
                float3 reflectionColor1 = DecodeHDR(reflectionData1, unity_SpecCube1_HDR);

                reflectionColor = lerp(reflectionColor1, reflectionColor0, interpolator);
            }
            else
            {
                float4 reflectionData = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, reflectedDir, roughness * UNITY_SPECCUBE_LOD_STEPS);
                reflectionColor = DecodeHDR(reflectionData, unity_SpecCube0_HDR);
            }
            
            reflectionColor *= Diffuse;
        #endif
    #elif defined(_SPECGLOSSMAP)
        //Specular workflow
        float4 specularTex = tex2D(_SpecGlossMap, TRANSFORM_TEX(i.uv0, mainTexture));
        float3 specular = specularTex.rgb * _SpecColor.rgb;
        
        //Not actually metallic, but this saves some work.
        //Defines how much of the diffuse and reflection color is used.
        float metallic = max(specular.r, max(specular.g, specular.b));
        
        #ifdef UNITY_PASS_FORWARDBASE
            //Unlit reflections in ForwardBase
            float roughness = 1 - (specularTex.a * _Glossiness);
            roughness *= 1.7 - 0.7 * roughness;
            
            float3 reflectedDir = reflect(-viewDirection, normalDirection);
            float3 reflectionColor;
            
            //Sample second probe if available.
            float interpolator = unity_SpecCube0_BoxMin.w;
            UNITY_BRANCH
            if(interpolator < 0.99999)
            {
                //Probe 1
                float4 reflectionData0 = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, reflectedDir, roughness * UNITY_SPECCUBE_LOD_STEPS);
                float3 reflectionColor0 = DecodeHDR(reflectionData0, unity_SpecCube0_HDR);

                //Probe 2
                float4 reflectionData1 = UNITY_SAMPLE_TEXCUBE_SAMPLER_LOD(unity_SpecCube1, unity_SpecCube0, reflectedDir, roughness * UNITY_SPECCUBE_LOD_STEPS);
                float3 reflectionColor1 = DecodeHDR(reflectionData1, unity_SpecCube1_HDR);

                reflectionColor = lerp(reflectionColor1, reflectionColor0, interpolator);
            }
            else
            {
                float4 reflectionData = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, reflectedDir, roughness * UNITY_SPECCUBE_LOD_STEPS);
                reflectionColor = DecodeHDR(reflectionData, unity_SpecCube0_HDR);
            }
            
            reflectionColor *= specular;
        #endif
    #endif
    
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
    
    #ifdef NOENOETOON_RAMP_MASKING
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
    #else
        float4 node_9498 = tex2D(_Ramp,TRANSFORM_TEX(node_8091, _Ramp));
        float ToonContrast_var = _ToonContrast;
    #endif
    
    float3 StaticToonLighting = node_9498.rgb;
    
    #if defined(_LIGHTING_LEGACY_ON)
        float3 finalColor = ((IntensityVar*FlatLighting*Diffuse) > 0.5 ? (1.0-(1.0-2.0*((IntensityVar*FlatLighting*Diffuse)-0.5))*(1.0-lerp(float3(node_424,node_424,node_424),StaticToonLighting,ToonContrast_var))) : (2.0*(IntensityVar*FlatLighting*Diffuse)*lerp(float3(node_424,node_424,node_424),StaticToonLighting,ToonContrast_var)));
    #else
    
        #if defined(_TOON_RAMP_DIMMING)
            // Dim the toon ramp effect as the area gets brighter
            float3 toonContrastModifier = (IntensityVar*saturate(FlatLighting)*Diffuse);
            toonContrastModifier = (1 - toonContrastModifier) * _ExposureContrast;
            toonContrastModifier = smoothstep(0.5, 1, toonContrastModifier);
            
            toonContrastModifier *= ToonContrast_var;
        #else
            float3 toonContrastModifier = float3(ToonContrast_var, ToonContrast_var, ToonContrast_var);
        #endif
        
        float3 finalColor = 2 * (IntensityVar*FlatLighting*Diffuse);
        finalColor *= lerp(float3(0.5, 0.5, 0.5), StaticToonLighting, toonContrastModifier);
    #endif
    
    #if defined(_LIGHTING_LEGACY_ON)
        finalColor = saturate(finalColor);
    #endif
    
    #if defined(_METALLICGLOSSMAP) || defined(_SPECGLOSSMAP)
        // Apply unlit reflections
        #ifdef UNITY_PASS_FORWARDBASE
            finalColor = lerp(finalColor, reflectionColor, metallic);
        #endif
        
        // To avoid drowning out metallic in bright light, decrease forwardadd output as things get more metallic.
        #ifdef UNITY_PASS_FORWARDADD
            finalColor *= (1 - metallic);
        #endif
    #endif
    
    #if defined(UNITY_PASS_FORWARDBASE) && defined(_EMISSION)
        #ifndef NOENOETOON_OUTLINE_PASS
            // Sample emission
            float4 _EmissionMap_var = tex2D(_EmissionMap,TRANSFORM_TEX(i.uv0, _EmissionMap));
            float3 MappedEmissive = (_EmissionMap_var.rgb*_EmissionColor);
            float3 emissive = MappedEmissive;
        
            // Apply emission
            finalColor = emissive + finalColor;
        #endif
    #endif
    
    float finalAlpha = 1;
    
    // Transparent stuff, use alpha and multiply by opacity
    // Forward additive pass multiplies the colors instead
    #ifdef NOENOETOON_TRANSPARENT
        #ifdef UNITY_PASS_FORWARDADD
            finalAlpha = 0;
            finalColor *= (SurfaceAlpha * _Opacity);    
        #else
            finalAlpha = _MainTex_var.a * _Opacity;
        #endif
    #endif
    
    return fixed4(finalColor,finalAlpha);
}