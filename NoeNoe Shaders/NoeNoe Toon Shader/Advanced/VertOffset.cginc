float4 _VertexOffset;
float4 _WorldVertexOffset;
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

VertexOutput vertOffset (VertexInput v) {

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
    // Apply worldspace vertex offset
    o.posWorld += _WorldVertexOffset;
    float3 lightColor = _LightColor0.rgb;
    
    // Apply worldspace vertex offset back to local position
    v.vertex = mul(unity_WorldToObject, o.posWorld);
    
    o.pos = UnityObjectToClipPos(v.vertex);
    TRANSFER_VERTEX_TO_FRAGMENT(o)
    return o;
}