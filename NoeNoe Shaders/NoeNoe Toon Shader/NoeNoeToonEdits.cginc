float _WorldLightIntensity;

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

sampler2D _MetallicGlossMap;
float _Metallic;
float _Glossiness;

float3 GIsonarDirection()
{
    float3 GIsonar_dir_vec = (unity_SHAr.xyz*unity_SHAr.w + unity_SHAg.xyz*unity_SHAg.w + unity_SHAb.xyz*unity_SHAb.w);

    UNITY_FLATTEN
    if ( length( GIsonar_dir_vec) > 0)
    {
		GIsonar_dir_vec = Unity_SafeNormalize(GIsonar_dir_vec);
	}
    else 
    {
		GIsonar_dir_vec = float3(0,0,0);
	}
    return GIsonar_dir_vec;
}

float4 lightDirection(float4 fallback, float alwaysUseFallback)
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
	return lerp(worldLightDir, fallback, alwaysUseFallback);
}

float3 FlatLightSH(float3 normal)
{
	return ShadeSH9(half4(normal, 1.0));
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
	float4 lightDir : TEXCOORD7; // AutoLight took 5 and 6 already
	float3 viewDir : TEXCOORD8;
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
	o.lightDir = lightDirection(_StaticToonLight, _OverrideWorldLight);
	o.viewDir = normalize(_WorldSpaceCameraPos - mul(unity_ObjectToWorld, v.vertex).xyz);
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
	
	#ifdef NOENOETOON_OUTLINE_PASS
		// Only clip if outline cutout is on
		clip(SurfaceAlpha - _Cutoff + (1 - _OutlineCutout));
	#else
		clip(SurfaceAlpha - _Cutoff);
	#endif
	
	float3 lightColor = _LightColor0.rgb;
////// Lighting:
	float attenuation = LIGHT_ATTENUATION(i) / SHADOW_ATTENUATION(i);
	
	#ifdef UNITY_PASS_FORWARDBASE
		float4 _EmissionMap_var = tex2D(_EmissionMap,TRANSFORM_TEX(i.uv0, _EmissionMap));
		float3 MappedEmissive = (_EmissionMap_var.rgb*_Emission);
		float3 emissive = MappedEmissive;
	#endif
	
	float3 FlatLighting = saturate((FlatLightSH( float3(0,1,0) )+(_LightColor0.rgb*attenuation)));
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
	
	#ifdef UNITY_PASS_FORWARDBASE
		//Reflections
		float4 metallicTex = tex2D(_MetallicGlossMap, TRANSFORM_TEX(i.uv0, mainTexture));
		float metallic = metallicTex.r * _Metallic;
		float roughness = 1 - (metallicTex.a * _Glossiness);
		roughness *= 1.7 - 0.7 * roughness;
		
		float3 reflectedDir = reflect(-i.viewDir, normalize(i.normalDir));
		
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
	float3 finalColor = saturate(((IntensityVar*FlatLighting*Diffuse) > 0.5 ?  (1.0-(1.0-2.0*((IntensityVar*FlatLighting*Diffuse)-0.5))*(1.0-lerp(float3(node_424,node_424,node_424),StaticToonLighting,ToonContrast_var))) : (2.0*(IntensityVar*FlatLighting*Diffuse)*lerp(float3(node_424,node_424,node_424),StaticToonLighting,ToonContrast_var))) );
	
	// Apply unlit reflections
	#ifdef UNITY_PASS_FORWARDBASE
		// TODO: If reflecting the skybox rather than a probe, dim the reflection.
		// Is that even possible? If so, tell me how ;)
		finalColor = lerp(finalColor, reflectionColor, metallic);
		
		// Apply emission
		finalColor = emissive + finalColor;
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