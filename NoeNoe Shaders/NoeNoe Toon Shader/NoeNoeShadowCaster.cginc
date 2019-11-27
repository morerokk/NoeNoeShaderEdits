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
    VertexOutputShadow o = (VertexOutputShadow)0;
    o.uv0 = v.texcoord0;                
    o.pos = UnityObjectToClipPos(v.vertex);
    TRANSFER_SHADOW_CASTER(o)
    return o;
}

float4 fragShadow(VertexOutputShadow i, float facing : VFACE) : COLOR {
    float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
    float SurfaceAlpha = _MainTex_var.a;
    clip(SurfaceAlpha - _Cutoff);
    SHADOW_CASTER_FRAGMENT(i)
}