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
	float4 lightDir : TEXCOORD6; // AutoLight took 5 already
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
	
	#ifdef UNITY_PASS_FORWARDBASE
		float4 _EmissionMap_var = tex2D(_EmissionMap,TRANSFORM_TEX(i.uv0, _EmissionMap));
		float3 MappedEmissive = (_EmissionMap_var.rgb*_Emission);
		float3 emissive = MappedEmissive;
	#endif
	
	float3 FlatLighting = saturate((Function_node_3693( float3(0,1,0) )+(_LightColor0.rgb*attenuation)));
	float3 MappedTexture = (_MainTex_var.rgb*_Color.rgb);
	
	#ifdef NOENOETOON_RAMP_MASKING
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
	#else
		float SaturationVar = _Saturation;
		float IntensityVar = _Intensity;
	#endif
	
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